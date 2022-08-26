local GitHubSession = {}
GitHubSession.__index = GitHubSession

function GitHubSession.new(Repo, Author)
    if not Author then
        Author, Repo = string.match(Repo, '/([%w_]+)/([%w_]+)/')
    end
    local self = {
        __auth = Author,
        __repo = Repo
    }
    return setmetatable(self, GitHubSession)
end

function GitHubSession:GetFile(...)
    local Path = { 'main', ... }
    return game:HttpGet(string.format('https://raw.githubusercontent.com/%s/%s/%s', self.__auth, self.__repo, table.concat(Path, '/')))
end

function GitHubSession:GetJson(...)
    return HttpService:JSONDecode(self:GetFile(...))
end

return GitHubSession
