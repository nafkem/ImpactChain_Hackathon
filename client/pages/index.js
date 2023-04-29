import Btn from "@/components/Btn";
import InvestModal from "@/components/InvestModal";
import Nav from "@/components/Nav";
import { Inter } from "next/font/google";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  return (
    <>
      <InvestModal />
      <Nav />
      <main className={`${inter.className}`}>
        <section className="hero mt-[65px]">
          <h1 className="hero__title">ImpactChain</h1>

          <div className="hero__img-wrapper w-full h-[400px] relative">
            <span className="hero__tagline w-fit p-4 bg-[#1f1f1f] capitalize text-center">
              Invest, Earn and Donate for Impact.
            </span>
            <img
              className="hero__img w-full h-full rounded-[15px] object-cover "
              src="/hero_bg.png"
              alt="hero bg"
            />

            <div className="hero__about absolute z-1 top-0 right-0 max-w-[400px] p-4 m-4">
              <h2 className="title font-semibold mb-4">
                Harvest Your Investment
              </h2>

              <p>
                Get ready to earn green while going green with FarmFund!
                FarmFund lets you invest in sustainable farming practices,
                earning a return on your investment. With FarmFund, your money
                is used to plant crops, producing high-quality, organic food
                that is distributed to investors and consumers alike. FarmFund
                is committed to using organic farming methods to protect the
                environment and promote biodiversity. Join us today and stake
                your claim in the future of agriculture while growing your
                wealth sustainably.
              </p>
            </div>
          </div>
        </section>

        <section className="how-it-works flex gap-[50px]">
          <div className="how-it-works__left">
            <h2 className="how-it-works__title">How It works</h2>
            <p className="how-it-works__desc max-w-[400px]">
              We basically handle the hardwork for you while you sit back,
              invest and track your earnings
            </p>
          </div>

          <ul className="how-it-works__info mt-[100px] bg-[#131313e1] flex flex-col gap-8 p-6 pt-8 pb-8 rounded-[15px]">
            <li className="how-it-works__item ml-4 pb-2">
              Choose a venture to invest in
            </li>
            <li className="how-it-works__item ml-4 pb-2">
              What time period it should last for
            </li>
            <li className="how-it-works__item ml-4 pb-2">
              Earn returns after stipulated time
            </li>
            <li className="how-it-works__item ml-4 pb-2">
              Donate to a cause or withdraw
            </li>
            <li className="how-it-works__item ml-4 pb-2">
              Tracks your investment/donations
            </li>
          </ul>
        </section>

        <section className="investments flex flex-col">
          <h2 className="investments__title">
            Our Investment
            <br />
            Plan
          </h2>
          <p className="investments__subtitle self-end font-semibold uppercase mb-2">
            Let's Get You Invested!
          </p>
          <p className="investments__desc max-w-[300px] self-end text-end mb-4">
            We do the heavy lifting while your investment works for you because
            we believe investing should be easy and profitable.
          </p>

          <div className="investments__container flex justify-between gap-2">
            <div className="investment p-4 max-w-[300px] rounded-[15px] bg-[#131313e1] h-fit flex flex-col gap-2">
              <h3 className="investment__title font-semibold">Seedling</h3>
              <p className="investment__sub">90 days</p>
              <p className="investment__desc">
                Invest for 90 days and earn 2% interest - the perfect short-term
                plan for quick and steady growth.
              </p>
              <button className="invest p-2 text-[#f1f1f1] rounded bg-[#101010] w-fit">
                Invest
              </button>
            </div>
            <div className="investment p-4 max-w-[300px] rounded-[15px] bg-[#131313e1] h-fit flex flex-col gap-2 mt-8">
              <h3 className="investment__title font-semibold">Sapling</h3>
              <p className="investment__sub">180 days</p>
              <p className="investment__desc">
                Looking for a long-term investment strategy? Invest for 180 days
                and earn 5% interest - a smart choice for those seeking
                stability and substantial returns.
              </p>
              <button className="invest p-2 text-[#f1f1f1] rounded bg-[#101010] w-fit">
                Invest
              </button>
            </div>
            <div className="investment p-4 max-w-[300px] rounded-[15px] bg-[#131313e1] h-fit flex flex-col gap-2 mt-16">
              <h3 className="investment__title font-semibold">Harvest</h3>
              <p className="investment__sub">365 days</p>
              <p className="investment__desc">
                Ready for a big investment payoff? Invest for 365 days and earn
                a whopping 12% interest - the ultimate choice for those who want
                to maximize their returns and reach their financial goals faster
              </p>
              <button className="invest p-2 text-[#f1f1f1] rounded bg-[#101010] w-fit">
                Invest
              </button>
            </div>
          </div>

          <div className="investments__start">
            <p className="max-w-[250px] mb-3">
              Convinced yet? Get started now and make an impact!
            </p>
            <Btn text={"Make an Investment"} />
          </div>
        </section>

        <footer className="footer w-full p-12">
          <p className="footer__text h-[60px] rounded-[15px] bg-[#131313e1] text-center flex items-center justify-center">
            ©2023 ImpactChain Limited
          </p>
        </footer>
      </main>
    </>
  );
}
