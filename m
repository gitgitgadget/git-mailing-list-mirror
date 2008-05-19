From: Luciano Rocha <luciano@eurotux.com>
Subject: bare --init Vs --init bare
Date: Mon, 19 May 2008 18:53:13 +0100
Message-ID: <20080519175313.GA17305@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 19:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy9Z4-0006kS-HM
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 19:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbYESRxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 13:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759919AbYESRxV
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 13:53:21 -0400
Received: from os.eurotux.com ([216.75.63.6]:45889 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbYESRxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 13:53:20 -0400
Received: (qmail 27429 invoked from network); 19 May 2008 17:53:17 -0000
Received: from adsl.eurotux.com (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 19 May 2008 17:53:17 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82437>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

This is odd:
$ git init --bare
usage: git-init [-q | --quiet] [--template=3D<template-directory>] [--share=
d]
$ git --bare init
Initialized empty Git repository in /tmp/1/

My git version:
$ git --version
git version 1.5.5.1.318.gc99b

(Has two patches on top of origin's
377d9c409ffe0f0d994b929aeb94716139207b9d, setting default prefix in
Makefile.)

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgxvogACgkQinSul6a7oB++hACdHIcpjZluBwKJw94Z70htevBI
w5sAnjjNQsmagZDCFWrBAhl7UD03pcSz
=CQkV
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
