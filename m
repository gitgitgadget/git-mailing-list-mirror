From: Luciano Rocha <luciano@eurotux.com>
Subject: relative objects/info/alternates
Date: Fri, 14 Dec 2007 14:06:13 +0000
Message-ID: <20071214140613.GA13259@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 15:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3BBa-0001zi-Jp
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 15:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXLNOGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 09:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbXLNOGU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 09:06:20 -0500
Received: from os.eurotux.com ([216.75.63.6]:58035 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbXLNOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 09:06:19 -0500
Received: (qmail 6812 invoked from network); 14 Dec 2007 14:06:18 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 14 Dec 2007 14:06:18 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68306>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

Can I use relative $GIT_DIR/objects/info/alternates? Will the git
commands work anywhere inside the working-copy despice the alternate
being relative to the root of it?

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHYo3VinSul6a7oB8RArkCAJ9xfaaoy0KTQlH6pLsz8f4kY0a2pwCfU1VC
4Nrs74BBMn8GYex37yHgRFA=
=W8nc
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
