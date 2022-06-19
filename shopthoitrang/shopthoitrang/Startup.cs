using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(shopthoitrang.Startup))]
namespace shopthoitrang
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
