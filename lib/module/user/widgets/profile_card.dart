var ProfileCard = () => {
  return (
    <div className="bg-white shadow-md rounded-lg p-6 mb-8">
      <div className="flex items-center">
        <img
          src="/profile-placeholder.png" // Ganti dengan URL atau path foto profil
          alt="Profile Picture"
          className="w-16 h-16 rounded-full mr-4"
        />
        <div>
          <h2 className="text-xl font-semibold">Micheline Wijaya Limbergh</h2>
          <p className="text-gray-600">Palugada Owner</p>
        </div>
      </div>
    </div>
  );
};

export default ProfileCard;
