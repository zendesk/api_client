require "spec_helper"

describe ApiClient::Connection::Middlewares::Request::Json do
  let(:app) { mock }
  let(:body) { {:some => :data} }
  let(:env) do
    {
      :url => "http://api.twitter.com",
      :request_headers => {},
      :method => "post",
      :body => body
    }
  end

  subject { ApiClient::Connection::Middlewares::Request::Json.new(app) }

  it "sets content type to json" do
    app.should_receive(:call).
      with(hash_including(:request_headers => {"Content-Type" => "application/json"}))

    subject.call(env)
  end

  it "JSON encodes body" do
    app.should_receive(:call).
      with(hash_including(:body => Yajl::Encoder.encode(body)))

    subject.call(env)
  end
end
