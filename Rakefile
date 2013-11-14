
include Rake::DSL

desc 'open a pry console with the files loaded'
task(:default) do
  exec *%W|pry -I #{__dir__}
               -r fixnum

               -r register
               -r status
               -r address
               -r instruction

               -r operation|
end
