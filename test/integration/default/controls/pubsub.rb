# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id = attribute('project_id')
topic      = attribute('topic')

describe command("gcloud --project='#{project_id}' pubsub topics describe #{topic}") do
  its(:exit_status) { should be_zero }
  it { expect(subject.stdout).to match(%r{name: projects/#{project_id}/topics/#{topic}}) }
end

describe command("gcloud --project='#{project_id}' pubsub subscriptions describe pulley --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/subscriptions/pulley") }
  it { expect(stdout).to include(topic: "projects/#{project_id}/topics/#{topic}") }
  it { expect(stdout).to include(ackDeadlineSeconds: 10) }
end

describe command("gcloud --project='#{project_id}' pubsub subscriptions describe pushy --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/subscriptions/pushy") }
  it { expect(stdout).to include(topic: "projects/#{project_id}/topics/#{topic}") }
  it { expect(stdout).to include(pushConfig: { pushEndpoint: "https://#{project_id}.appspot.com/" }) }
  it { expect(stdout).to include(ackDeadlineSeconds: 20) }
end
