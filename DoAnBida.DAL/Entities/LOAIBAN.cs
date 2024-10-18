namespace DoAnBida.DAL.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LOAIBAN")]
    public partial class LOAIBAN
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int LoaiBanID { get; set; }

        [Required]
        [StringLength(100)]
        public string LoaiBanName { get; set; }
    }
}
