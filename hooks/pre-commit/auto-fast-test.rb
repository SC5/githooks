#!/usr/bin/env ruby
#
#
require 'optparse'

class AutoFastTest
  def initialize(*args)
    @initialized = false
    
    @git_root = %x[git rev-parse --show-toplevel].chop
    if not @git_root.empty?  then
      @initialized = true 
      @test_driver = getGitConfig("test.driver","grunt")
      @test_target = getGitConfig("test.target","fast-tests")
    end

  end


  def getGitConfig(option, defaultval)
    tmp = %x[git config #{option}].chop
    tmp = defaultval if tmp.empty?
    return tmp
  end

  def to_s
    "Repo folder: #{@git_root}\nTest Driver: #{@test_driver}\nTest Target: #{@test_target}"
  end
end


## Execute of main app
if __FILE__ == $0 then
  aft = AutoFastTest.new
  puts aft
end

#if [ -z $GIT_NO_VERIFY ]; then
#  GITREPO=`git rev-parse --show-toplevel`
#  tmp=`git config test.driver`
#  TESTDRIVER=${tmp:-grunt}
#  tmp=`git config test.target`
#  TESTTARGET=${tmp:-fast-tests}
#
#  git config test.driver "${TESTDRIVER}"
#  git config test.target  "${TESTTARGET}"
#
#  git stash -q --keep-index
#  if [ -x `which ${TESTDRIVER}` ]; then 
#    ${TESTDRIVER} ${TESTTARGET}
#    RESULT=$?
#  else
#    echo Binary ${TESTDRIVER}: not found
#  fi
#
#  git stash pop -q
#
#  if [ $RESULT -ne 0 ]; then
#    RESULT=1 # Just to make sure that only exit values are 0 and 1
#  fi
#else
#  echo Checking tests disabled.
#fi
#exit $RESULT 


