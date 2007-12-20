From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Commit a series of patches to SVN without rebase
Date: Thu, 20 Dec 2007 17:40:45 +0100
Message-ID: <20071220164044.GA22683@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 17:54:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Oen-00041v-Ba
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 17:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760692AbXLTQxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 11:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760245AbXLTQxe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 11:53:34 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:1365 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758204AbXLTQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 11:53:33 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 946DB48803E; Thu, 20 Dec 2007 17:53:31 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J5ORx-0000b6-0U
	for git@vger.kernel.org; Thu, 20 Dec 2007 17:40:45 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.68)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J5ORx-0005wA-1E
	for git@vger.kernel.org; Thu, 20 Dec 2007 17:40:45 +0100
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69010>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've a number of patches in git I want to send to a SVN repository. git
svn dcommit does a rebase after each commit which makes the whole commit
takes very long. Is it possible to skip the rebase? All patches are in
one branch without merges, a simple chain. Is it save to use --no-rebase
in this case?

Bye, J=F6rg
--=20
Der Kl=FCgere gibt so lange nach bis er der Dumme ist.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHapsMwe0mZwH1VIARAv+OAKCpEHmEincHNbxXuCxzQBa/uTNn5wCfWvNg
IrwdhHzXDsUhiKr3HjGBQtA=
=DZ78
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
