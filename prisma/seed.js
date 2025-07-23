const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function main() {
  // Seed data ke tb_customers
  await prisma.tb_customers.create({
    data: {
      id_customers: 1,
      nama_customers: 'Non-Member',
      telp_customers: '0',
      email_customers: '-',
      alamat_customers: '-',
      tglLahir_customers: new Date('0001-01-01'),
      gender_customers: 'Laki_Laki',
      status_customers: 'aktif',
    },
  })

  // Seed data ke tb_shifts
  await prisma.tb_shifts.create({
    data: {
      id_shifts: 1,
      nama_shifts: 'Full Time Shift',
      start_time: new Date('2025-04-21T08:00:00'),
      end_time: new Date('2025-04-21T16:00:00'),
    },
  })

  // Seed data ke tb_users
  await prisma.tb_users.createMany({
    data: [
      {
        id_user: 1,
        kode_user: 'NMKSR',
        nama_user: 'Nama Kasir',
        password_user: '$2b$10$caX12QUpKy6KtI2LaAuo2OlPhRs8C8LwgcIBHMnp7gnwtMW65Hl4m',
        contact_user: '081234567890',
        role_user: 'kasir',
        status_user: 'aktif',
        gambar_user: '1745200384655.jpg',
      },
      {
        id_user: 2,
        kode_user: 'NMDMN',
        nama_user: 'Nama Admin',
        password_user: '$2b$10$/YIR/z0VcIxqg1WXs6J6zuPWJzCoyALDMwDr27GaNVzoU0ejJR0Gm',
        contact_user: '081278901234',
        role_user: 'admin',
        status_user: 'aktif',
        gambar_user: '1745200439821.jpg',
      },
    ],
    skipDuplicates: true,
  })

  // Seed data ke tb_karyawan
  await prisma.tb_karyawan.createMany({
    data: [
      {
        id_karyawan: 1,
        id_user: 1,
        posisi_karyawan: 'Barista',
        gaji_karyawan: 5000000,
        alamat_karyawan: 'Jl. Mawar No. 123',
        id_shifts: 1,
      },
      {
        id_karyawan: 2,
        id_user: 2,
        posisi_karyawan: 'Admin',
        gaji_karyawan: 8000000,
        alamat_karyawan: 'Jl. Mawar No. 123',
        id_shifts: 1,
      },
    ],
    skipDuplicates: true,
  })
}

main()
  .then(() => {
    console.log('✅ Seed berhasil dimasukin!')
  })
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
