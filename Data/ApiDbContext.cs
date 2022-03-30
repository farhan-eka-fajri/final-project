using Microsoft.EntityFrameworkCore;
using PaymentApiApp.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using MySql.Data;
using MySql.EntityFrameworkCore;

namespace PaymentApiApp.Data{

    public class ApiDbContext : IdentityDbContext{

        public virtual DbSet<ItemData> Items {get; set;}

        public virtual DbSet<RefreshToken> RefreshTokens {get; set;}

        public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options){
            
        }
    }
}