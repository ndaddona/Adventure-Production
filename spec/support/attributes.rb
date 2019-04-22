def campaign_attributes(overrides = {})
    {
        name: 'Test',
        description: 'description',
        category: "MotW"
    }.merge(overrides)
end
  
def user_attributes(overrides = {})
    {
        name: "Example User",
        email: "user@example.com",
        password: "secret",
        password_confirmation: "secret"
    }.merge(overrides)
end

def game_attributes(overrides = {})
    {
        title: 'Session1',
        description: 'New game'
    }.merge(overrides)
end

def meeting_attributes(overrides = {})
    {
        title: 'RSpec',
        description: 'Testing',
        start_time: '2019/04/03'
    }.merge(overrides)
end
