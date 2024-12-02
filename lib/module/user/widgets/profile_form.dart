import { useState } from 'react';

const ProfileForm = () => {
  const [formData, setFormData] = useState({
    name: 'Micheline Wijaya Limbergh',
    email: 'micheline@example.com',
    phone: '081234567890',
    address: 'Jl. Mawar No. 123, Jakarta',
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Updated Data:', formData);
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="bg-white shadow-md rounded-lg p-6"
    >
      <h2 className="text-xl font-semibold mb-4">Edit Profile</h2>

      <div className="mb-4">
        <label className="block text-gray-700">Name</label>
        <input
          type="text"
          name="name"
          value={formData.name}
          onChange={handleChange}
          className="w-full border-gray-300 rounded-md p-2"
        />
      </div>

      <div className="mb-4">
        <label className="block text-gray-700">Email</label>
        <input
          type="email"
          name="email"
          value={formData.email}
          onChange={handleChange}
          className="w-full border-gray-300 rounded-md p-2"
        />
      </div>

      <div className="mb-4">
        <label className="block text-gray-700">Phone</label>
        <input
          type="tel"
          name="phone"
          value={formData.phone}
          onChange={handleChange}
          className="w-full border-gray-300 rounded-md p-2"
        />
      </div>

      <div className="mb-4">
        <label className="block text-gray-700">Address</label>
        <textarea
          name="address"
          value={formData.address}
          onChange={handleChange}
          className="w-full border-gray-300 rounded-md p-2"
        ></textarea>
      </div>

      <button
        type="submit"
        className="bg-purple-600 text-white py-2 px-4 rounded-md hover:bg-purple-700"
      >
        Save Changes
      </button>
    </form>
  );
};

export default ProfileForm;
