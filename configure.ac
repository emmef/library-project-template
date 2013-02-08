dnl Process this file with autoconf to produce a configure script.
dnl This is the configuration for: GenerateProjectDescription.
dnl Copyright GenerateProjectInitialCopyrightYear GenerateProjectCopyrightHolder.
dnl GenerateprojectCopyRightContact
dnl The output of this project will be libTemplateLibraryName.

AC_PREREQ(2.59)
AC_INIT(TemplateLibraryName, 0.1.001)

AC_CANONICAL_SYSTEM
AM_INIT_AUTOMAKE

AC_PROG_CC
AC_PROG_CXX

dnl If you want to disable static linking: hre's how
dnl AC_DISABLE_STATIC

AC_PROG_LIBTOOL
AC_CONFIG_MACRO_DIR([m4])
PKG_CHECK_MODULES(GLIB,[glib-2.0 >= 2.24] gthread-2.0,,)

AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

dnl Check for additional libraries jere
dnl AC_CHECK_LIB(asound, snd_pcm_open,)

dnl Doxygen
dnl Disabled as it doesn't work and gives syntax errors during 
dnl ./configure
 
dnl DX_HTML_FEATURE(ON)
dnl DX_CHM_FEATURE(OFF) 
dnl DX_CHI_FEATURE(OFF)
dnl DX_MAN_FEATURE(ON)
dnl DX_RTF_FEATURE(OFF)
dnl DX_XML_FEATURE(OFF)
dnl DX_PDF_FEATURE(ON)
dnl DX_PS_FEATURE(OFF)
dnl DX_INIT_DOXYGEN(TemplateLibraryName, doxygen.cfg)


dnl gettext
AM_GNU_GETTEXT([external])
if test "$MSGFMT" = ":" ; then
    AC_MSG_ERROR([msgfmt was not found; have you installed gettext?])
fi
AM_GNU_GETTEXT_VERSION


AC_OUTPUT(Makefile src/Makefile)
