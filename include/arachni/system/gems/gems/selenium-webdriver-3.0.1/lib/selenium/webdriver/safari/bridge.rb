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

module Selenium
  module WebDriver
    module Safari
      # @api private
      class Bridge < Remote::Bridge
        def initialize(opts = {})
          opts[:desired_capabilities] ||= Remote::Capabilities.safari
          port = opts.delete(:port) || Service::DEFAULT_PORT
          service_args = opts.delete(:service_args) || {}

          @service = Service.new(Safari.driver_path, port, *extract_service_args(service_args))
          @service.start
          opts[:url] = @service.uri

          super(opts)
        end

        def quit
          super
        ensure
          @service.stop if @service
        end

        private

        def extract_service_args(args = {})
          args.key?(:port) ? ["--port=#{args[:port]}"] : []
        end
      end # Bridge
    end # Safari
  end # WebDriver
end # Selenium
