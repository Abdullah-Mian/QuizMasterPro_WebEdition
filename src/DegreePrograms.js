const DegreePrograms = () => {
  return <h1>Degree Programs</h1>;
};
export default DegreePrograms;

// // src/DegreePrograms.js
// import React, { useEffect, useState, useContext } from "react";
// import { AuthContext } from "./AuthContext";
// import { Link, useRouteMatch } from "react-router-dom";

// const DegreePrograms = () => {
//   const { username, password } = useContext(AuthContext);
//   const [degreePrograms, setDegreePrograms] = useState([]);
//   const [loading, setLoading] = useState(false);
//   const [error, setError] = useState(null);
//   const { url } = useRouteMatch();

//   useEffect(() => {
//     const fetchDegreePrograms = async () => {
//       setLoading(true);
//       setError(null);

//       try {
//         const response = await fetch("http://localhost:3000/degreeprograms", {
//           method: "GET",
//           headers: {
//             "Content-Type": "application/json",
//             "x-username": username,
//             "x-password": password,
//           },
//         });
//         const data = await response.json();
//         if (response.ok) {
//           setDegreePrograms(data);
//         } else {
//           setError(data.error || "Failed to fetch degree programs");
//         }
//       } catch (error) {
//         setError("Error connecting to server");
//       } finally {
//         setLoading(false);
//       }
//     };

//     fetchDegreePrograms();
//   }, [username, password]);

//   return (
//     <div className="p-4">
//       <h2 className="text-2xl font-bold mb-4">Degree Programs</h2>
//       {loading && <p>Loading...</p>}
//       {error && <p>Error: {error}</p>}
//       {!loading && !error && (
//         <ul className="list-disc pl-5">
//           {degreePrograms.map((degProg, index) => (
//             <li key={index} className="mb-2">
//               <Link
//                 to={`${url}/students/${degProg.Deg_Prog}`}
//                 className="text-blue-500 hover:underline"
//               >
//                 {degProg.Deg_Prog_Name}
//               </Link>
//             </li>
//           ))}
//         </ul>
//       )}
//     </div>
//   );
// };

// export default DegreePrograms;
