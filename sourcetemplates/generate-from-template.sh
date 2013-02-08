#! /bin/sh

printSynopsis() {
	if test -n "$1"
	then
		echo "ERROR:\n\t$1" >&2
	fi
	echo "SYNOPSIS"
	echo "\t`basename $0` fileBaseName fileExtension..."
	echo "\tfileBaseName and fileExtension form the new file name(s) based"
	echo "\ton the following patten:" 
	echo "\t\tfileBaseName.fileExtension"
}

projectCopyRightHolder="GenerateProjectCopyrightHolder"
projectCopyRightContact="GenerateprojectCopyRightContact"
projectInitialCopyrightYear="GenerateProjectInitialCopyrightYear"
projectTemplateProjectDescription="GenerateProjectDescription"
projectTemplateProjectPrefix="GenerateProjectPrefix"
projectTemplateProjectPrefixLowerCase=`echo ${projectTemplateProjectPrefix} | tr '[:upper:]' '[:lower:]'`
projectTemplateProjectPrefixUpperCase=`echo ${projectTemplateProjectPrefix} | tr '[:lower:]' '[:upper:]'`

validRegExp() {
	if test -z "$2"
	then
		echo "Empty is no match" >&2
		exit 1
	fi
	if echo "$1" | grep -Ei "$2" >/dev/null
	then
		echo "$1"
	else
		echo "Input '$1' does not match regexp '$2'" >&2
		exit 1
	fi
}

checkRegExp() {
	echo "$1" | grep -Ei "$2" >/dev/null
}

if ! test -n "$2"
then
	printSynopsis "Missing argument(s)"
	exit 1
fi

fileNameRegExp="^[A-Z][-_A-Z0-9]+\$"

if ! fileBaseName=`validRegExp "$1" "${fileNameRegExp}"`
then
	printSynopsis "File base name not valid: $1"
	exit 2
fi
shift

fileBaseName="${projectTemplateProjectPrefixLowerCase}${fileBaseName}"

fileGuardName=`echo "${fileBaseName}" | sed -r s/"\\-"/"_"/g | tr '[:lower:]' '[:upper:]'`
fileGuardName="${projectTemplateProjectPrefixUpperCase}${fileGuardName}_H_"
currentYear=`date +"%Y"`
if test "${currentYear}" = "${projectInitialCopyrightYear}"
then
	copyRightNotice="Copyright (C) ${projectInitialCopyrightYear} ${projectCopyRightHolder}."
else
	copyRightNotice="Copyright (C) ${projectInitialCopyrightYear}-${currentYear} ${projectCopyRightHolder}."
fi

echo "Generating files from tempates with"
echo "\tCopyright = ${copyRightNotice}"
echo "\tContact   = ${projectCopyRightContact}"
echo "\tGuard     = ${fileGuardName}"

for fileExtension in $*
do
	directory=""
	for tryDirectory in src include
	do
		templateFile="./sourcetemplates/${tryDirectory}/template.${fileExtension}"
		if test -f "$templateFile"
		then
			directory="${tryDirectory}"
			generatedFile="${directory}/${fileBaseName}.${fileExtension}"
			echo "Generating ${generatedFile}..."
			echo "BB ${fileBaseName}"
			cat "${templateFile}" |\
				sed -r s/"TemplateFileNameLowerCase"/"${fileName}"/g |\
				sed -r s/"TemplateProjectCopyrightNotice"/"${copyRightNotice}"/g |\
				sed -r s/"TemplateProjectCopyrightContact"/"${projectCopyRightContact}"/g |\
				sed -r s/"TemplateFileName"/"${fileBaseName}"/g |\
				sed -r s/"TemplateProjectFileGuard"/"${fileGuardName}"/g \
				> ${generatedFile}
		fi
	done
	if test -z "${directory}"
	then
		echo "WARNING: There is no template for file extension \"${fileExtension}\"" >&2
	fi
done
