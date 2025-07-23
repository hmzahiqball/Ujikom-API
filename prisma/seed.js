const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function main() {
  // Seed data ke tb_customers
  await prisma.customer.upsert({
    where: { id: 1 },
    update: {},
    create: {
      id: 1,
      name: 'Non-Member',
      phone: '0',
      email: '-',
      address: '-',
      birthdate: new Date('0001-01-01'),
      gender: 'Laki_Laki',
      status: 'aktif',
      createdAt: new Date('2025-04-21T09:10:33'),
      updatedAt: new Date('2025-04-21T09:10:33'),
    },
  })

  // Seed data ke tb_users
  await prisma.user.createMany({
    data: [
      {
        id: 1,
        kode: 'NMKSR',
        nama: 'Nama Kasir',
        password: '$2b$10$caX12QUpKy6KtI2LaAuo2OlPhRs8C8LwgcIBHMnp7gnwtMW65Hl4m',
        contact: '081234567890',
        role: 'kasir',
        status: 'aktif',
        gambar: '1745200384655.jpg',
        createdAt: new Date('2025-04-21T08:53:04'),
        updatedAt: new Date('2025-04-21T08:53:04'),
      },
      {
        id: 2,
        kode: 'NMDMN',
        nama: 'Nama Admin',
        password: '$2b$10$/YIR/z0VcIxqg1WXs6J6zuPWJzCoyALDMwDr27GaNVzoU0ejJR0Gm',
        contact: '081278901234',
        role: 'admin',
        status: 'aktif',
        gambar: '1745200439821.jpg',
        createdAt: new Date('2025-04-21T08:53:59'),
        updatedAt: new Date('2025-04-21T08:53:59'),
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
