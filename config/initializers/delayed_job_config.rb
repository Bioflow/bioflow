# config/initializers/delayed_job_config.rb
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 10
Delayed::Worker.max_attempts = 1
Delayed::Worker.max_run_time = 100.hours
Delayed::Worker.read_ahead = 2
Delayed::Worker.delay_jobs = !Rails.env.test?