filename = 'dbd_blog.yml'
config_path = "/etc/thin"       
file = config_path + '/' + filename
config = YAML.load_file(file) 
num_servers = config['servers'].to_i
num_servers.times do |i|
  # UNIX socket cluster use number 0 to 2 (for 3 servers)
  # and tcp cluster use port number 3000 to 3002.
  number = config['port'] + i
  
  God.watch do |w|
    w.group = "thin-" + File.basename(file, ".yml")
    w.name = w.group + "-#{number}"
    
    w.interval = 30.seconds
    
    w.uid = config["user"]
    w.gid = config["group"]
    
    w.start = "sudo thin start -C #{file} -o #{number}"
    w.start_grace = 10.seconds
    
    w.stop = "sudo thin stop -C #{file} -o #{number}"
    w.stop_grace = 10.seconds
    
    w.restart = "sudo thin restart -C #{file} -o #{number}"

    pid_path = config["chdir"] + "/" + config["pid"]
    ext = File.extname(pid_path)

    w.pid_file = pid_path.gsub(/#{ext}$/, ".#{number}#{ext}")
    
    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
      end
    end

    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 150.megabytes
        c.times = [3,5] # 3 out of 5 intervals
      end

      restart.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
      end
    end

    w.lifecycle do |on|
      on.condition(:flapping) do |c|
        c.to_state = [:start, :restart]
        c.times = 5
        c.within = 5.minutes
        c.transition = :unmonitored
        c.retry_in = 10.minutes
        c.retry_times = 5
        c.retry_within = 2.hours
      end
    end
  end
end 