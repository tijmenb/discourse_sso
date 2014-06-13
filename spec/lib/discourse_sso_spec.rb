require "spec_helper"
require "discourse_sso"

describe DiscourseSSO::Request do
  # this data is taken from the real-world example
  # https://meta.discourse.org/t/official-single-sign-on-for-discourse/13045

  describe "#to_url" do
    before do
      DiscourseSSO::Config.configure do |config|
        config.secret = "d836444a9e4084d5b224a60c208dce14"
        config.return_url_base = "http://discuss.example.com/session/sso_login"
      end
    end

    it "returns the correct URL" do
      request = DiscourseSSO::Request.new(
        "bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGI=\n",
        "2828aa29899722b35a2f191d34ef9b3ce695e0e6eeec47deb46d588d70c7cb56")

      request.user = {
        name: "sam",
        username: "samsam",
        email: "test@test.com",
        external_id: "hello123",
      }

      request.callback_url.should == 'http://discuss.example.com/session/sso_login?sso=bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGImbmFtZT1z%0AYW0mdXNlcm5hbWU9c2Ftc2FtJmVtYWlsPXRlc3QlNDB0ZXN0LmNvbSZleHRl%0Acm5hbF9pZD1oZWxsbzEyMw%3D%3D%0A&sig=1c884222282f3feacd76802a9dd94e8bc8deba5d619b292bed75d63eb3152c0b'
    end

    it "raises an error if the signature does not match" do
      expect { DiscourseSSO::Request.new('x', 'aa') }.to raise_error(DiscourseSSO::InvalidSignature)
    end
  end
end
