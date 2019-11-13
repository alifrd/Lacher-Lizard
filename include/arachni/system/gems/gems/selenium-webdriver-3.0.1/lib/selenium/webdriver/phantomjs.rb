# encoding: utf-8
#
# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require 'net/http'

require 'selenium/webdriver/phantomjs/service'
require 'selenium/webdriver/phantomjs/bridge'

module Selenium
  module WebDriver
    module PhantomJS
      MISSING_TEXT = 'Unable to find phantomjs executable.'.freeze

      def self.path=(path)
        Platform.assert_executable path
        @path = path
      end

      def self.path
        @path ||= begin
          path = Platform.find_binary('phantomjs')
          raise Error::WebDriverError, MISSING_TEXT unless path
          Platform.assert_executable path

          path
        end
      end
    end # PhantomJS
  end # WebDriver
end # Selenium
