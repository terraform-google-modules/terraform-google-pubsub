# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id  = attribute('project_id')
registry    = attribute('registry_name')
region      = attribute('region')
event_topic = "#{registry}-event-topic"
state_topic = "#{registry}-state-topic"

describe command("gcloud --project='#{project_id}' iot registries describe #{registry} --region=#{region} --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/locations/#{region}/registries/#{registry}") }
end

describe command("gcloud --project='#{project_id}' pubsub topics describe #{event_topic} --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/topics/#{event_topic}") }
end

describe command("gcloud --project='#{project_id}' pubsub topics describe #{state_topic} --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/topics/#{state_topic}") }
end

describe command("gcloud --project='#{project_id}' pubsub subscriptions describe #{registry}-event-pull --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/subscriptions/#{registry}-event-pull") }
  it { expect(stdout).to include(topic: "projects/#{project_id}/topics/#{event_topic}") }
  it { expect(stdout).to include(ackDeadlineSeconds: 20) }
end

describe command("gcloud --project='#{project_id}' pubsub subscriptions describe #{registry}-state-push --format=json") do
  let(:stdout) { JSON.parse(subject.stdout, symbolize_names: true) }
  its(:exit_status) { should be_zero }
  it { expect(stdout).to include(name: "projects/#{project_id}/subscriptions/#{registry}-state-push") }
  it { expect(stdout).to include(topic: "projects/#{project_id}/topics/#{state_topic}") }
  it { expect(stdout).to include(ackDeadlineSeconds: 20) }
end
