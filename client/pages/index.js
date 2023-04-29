import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export default function Home() {
  return (
    <>
      <Nav />
      <main className={`${inter.className}`}></main>
    </>
  )
}
