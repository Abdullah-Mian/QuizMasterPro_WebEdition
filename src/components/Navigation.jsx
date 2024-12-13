// src/Navigation.js
import React, { useContext } from "react";
import { Link, useNavigate, useLocation } from "react-router-dom";
import { AuthContext } from "../Contexts/AuthContext";
import { motion } from "framer-motion";
import {
  FaGraduationCap,
  FaChartLine,
  FaSignOutAlt,
  FaSignInAlt,
  FaTachometerAlt,
  FaUserPlus,
  FaChartBar,
} from "react-icons/fa";

const NavLink = ({ to, children, icon }) => {
  const location = useLocation();
  const isActive = location.pathname === to;

  return (
    <motion.div whileHover={{ scale: 1.05 }} whileTap={{ scale: 0.95 }}>
      <Link
        to={to}
        className={`px-4 py-2 rounded-lg flex items-center space-x-2 transition-all duration-300 ${
          isActive
            ? "bg-gradient-to-r from-blue-500 to-blue-600 text-white"
            : "text-gray-700 hover:bg-gray-100"
        }`}
      >
        {icon}
        <span>{children}</span>
      </Link>
    </motion.div>
  );
};

const Navigation = () => {
  const { username, setUsername, setPassword, setLoginType, setVerified } =
    useContext(AuthContext);
  const navigate = useNavigate();
  const { loginType } = useContext(AuthContext);

  const handleLogout = () => {
    setUsername("");
    setPassword("");
    setLoginType("");
    setVerified(false);
    navigate("/");
  };

  return (
    <motion.nav
      initial={{ y: -100 }}
      animate={{ y: 0 }}
      className="sticky top-0 z-50 bg-white shadow-lg border-b border-gray-200"
    >
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center h-16">
          <motion.div
            whileHover={{ scale: 1.05 }}
            className="flex items-center space-x-2"
          >
            <Link to="/" className="flex items-center space-x-2">
              <FaGraduationCap className="text-3xl text-blue-600" />
              <span className="text-2xl font-bold bg-gradient-to-r from-blue-600 to-blue-800 bg-clip-text text-transparent">
                QuizMasterPro
              </span>
            </Link>
          </motion.div>

          <div className="hidden md:flex items-center space-x-4">
            {loginType === "admin" && (
              <NavLink
                to="/admin/enroll"
                icon={<FaUserPlus className="text-lg" />}
              >
                Enroll Students
              </NavLink>
            )}

            <NavLink
              to={loginType === "admin" ? "/admin" : "/student"}
              icon={<FaTachometerAlt className="text-lg" />}
            >
              Dashboard
            </NavLink>

            <NavLink to="/progress" icon={<FaChartLine className="text-lg" />}>
              Progress
            </NavLink>

            <NavLink to="/analytics" icon={<FaChartBar className="text-lg" />}>
              Analytics
            </NavLink>

            {username ? (
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handleLogout}
                className="px-4 py-2 rounded-lg flex items-center space-x-2 text-gray-700 hover:bg-gray-100 transition-all duration-300"
              >
                <FaSignOutAlt className="text-lg" />
                <span>Logout</span>
              </motion.button>
            ) : (
              <NavLink to="/login" icon={<FaSignInAlt className="text-lg" />}>
                Login
              </NavLink>
            )}
          </div>

          {/* Mobile menu button */}
          <motion.button
            whileTap={{ scale: 0.95 }}
            className="md:hidden rounded-lg p-2 hover:bg-gray-100"
          >
            <svg
              className="h-6 w-6 text-gray-600"
              fill="none"
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path d="M4 6h16M4 12h16m-16 6h16"></path>
            </svg>
          </motion.button>
        </div>
      </div>
    </motion.nav>
  );
};

export default Navigation;
