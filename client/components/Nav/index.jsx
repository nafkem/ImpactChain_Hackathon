import { useState, useEffect } from "react";

const Nav = () => {
  const [isWalletConnected, setIsWalletConnected] = useState(false);
  return (
    <nav className="nav items-center">
      <div className="nav__logo">ImpactChain</div>

      {isWalletConnected ? (
        <button className="nav__wallet text-[#e7e7e7] bg-[#2fa50b] pt-1 pb-1.5 pl-3 pr-3 rounded-[10px]">
          Dashboard
        </button>
      ) : (
        <button className="nav__wallet text-[#e7e7e7] bg-[#2fa50b] pt-1 pb-1.5 pl-3 pr-3 rounded-[10px]">
          Connect
        </button>
      )}
    </nav>
  );
};

export default Nav;
