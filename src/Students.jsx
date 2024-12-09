// // src/Students.js
// import React, { useEffect, useState, useContext } from "react";
// import { AuthContext } from "./AuthContext";
// import { useParams } from "react-router-dom";

// const Students = () => {
//   const { username, password } = useContext(AuthContext);
//   const { degProg } = useParams();
//   const [students, setStudents] = useState([]);
//   const [loading, setLoading] = useState(false);
//   const [error, setError] = useState(null);

//   useEffect(() => {
//     const fetchStudents = async () => {
//       setLoading(true);
//       setError(null);

//       try {
//         const response = await fetch(
//           `http://localhost:3000/students?degProg=${degProg}`,
//           {
//             method: "GET",
//             headers: {
//               "Content-Type": "application/json",
//               "x-username": username,
//               "x-password": password,
//             },
//           }
//         );
//         const data = await response.json();
//         if (response.ok) {
//           setStudents(data);
//         } else {
//           setError(data.error || "Failed to fetch students");
//         }
//       } catch (error) {
//         setError("Error connecting to server");
//       } finally {
//         setLoading(false);
//       }
//     };

//     fetchStudents();
//   }, [username, password, degProg]);

//   return (
//     <div className="p-4">
//       <h2 className="text-2xl font-bold mb-4">Students in {degProg}</h2>
//       {loading && <p>Loading...</p>}
//       {error && <p>Error: {error}</p>}
//       {!loading && !error && (
//         <ul className="list-disc pl-5">
//           {students.map((student, index) => (
//             <li key={index}>{student.StudentName}</li>
//           ))}
//         </ul>
//       )}
//     </div>
//   );
// };

// export default Students;
