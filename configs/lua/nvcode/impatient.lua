-- Improve start time
local present, impatient = pcall(require, "impatient")
if present then
	impatient.enable_profile()
end
