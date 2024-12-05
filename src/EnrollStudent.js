// // src/EnrollStudent.js
// import React, { useState, useContext } from "react";
// import { AuthContext } from "./AuthContext";

// const EnrollStudent = () => {
//   const { username, password } = useContext(AuthContext);
//   const [studentName, setStudentName] = useState("");
//   const [studentUsername, setStudentUsername] = useState("");
//   const [degreeProgram, setDegreeProgram] = useState("");
//   const [message, setMessage] = useState("");

//   const handleSubmit = async (e) => {
//     e.preventDefault();
//     try {
//       const response = await fetch("http://localhost:3000/enrollstudent", {
//         method: "POST",
//         headers: {
//           "Content-Type": "application/json",
//           "x-username": username,
//           "x-password": password,
//         },
//         body: JSON.stringify({
//           studentName,
//           studentUsername,
//           degreeProgram,
//         }),
//       });
//       const data = await response.json();
//       if (response.ok) {
//         setMessage("Student enrolled successfully");
//       } else {
//         setMessage(data.error || "Failed to enroll student");
//       }
//     } catch (error) {
//       setMessage("Error connecting to server");
//     }
//   };

//   return (
//     <div className="p-4">
//       <h2 className="text-2xl font-bold mb-4">Enroll Student</h2>
//       <form onSubmit={handleSubmit} className="space-y-4">
//         <div>
//           <label className="block text-gray-700">Student Name</label>
//           <input
//             type="text"
//             value={studentName}
//             onChange={(e) => setStudentName(e.target.value)}
//             className="w-full p-2 border border-gray-300 rounded"
//             required
//           />
//         </div>
//         <div>
//           <label className="block text-gray-700">Username</label>
//           <input
//             type="text"
//             value={studentUsername}
//             onChange={(e) => setStudentUsername(e.target.value)}
//             className="w-full p-2 border border-gray-300 rounded"
//             required
//           />
//         </div>
//         <div>
//           <label className="block text-gray-700">Degree Program</label>
//           <input
//             type="text"
//             value={degreeProgram}
//             onChange={(e) => setDegreeProgram(e.target.value)}
//             className="w-full p-2 border border-gray-300 rounded"
//             required
//           />
//         </div>
//         <button
//           type="submit"
//           className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
//         >
//           Enroll
//         </button>
//       </form>
//       {message && <p className="mt-4">{message}</p>}
//     </div>
//   );
// };

// export default EnrollStudent;
