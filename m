From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: git-svn, svn:externals, git-submodules?
Date: Fri, 5 Oct 2007 22:37:41 +0200
Message-ID: <DEC49034-D594-4F4E-89E6-B98A3D4A8825@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-708580040"
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idtwm-0008Pl-D1
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763555AbXJEUiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 16:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764219AbXJEUiN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:38:13 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:55200 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763513AbXJEUiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 16:38:11 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Idtw1-0000Es-Hb
	for git@vger.kernel.org; Fri, 05 Oct 2007 22:38:09 +0200
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60132>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-708580040
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hello,
is there any plan to support svn:externals in git-svn with git- 
submodules?  If yes, where can we see the on-going work?  If no, is  
anyone already planning to implement this?  If no, has anyone  
anything to say about the idea?  I could give it a try as I really  
need this feature to properly interoperate with SVN repositories.   
Many of my friends and co-workers also need it.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-2-708580040
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHBqCVwwE67wC8PUkRAlqzAKDXS6SYHEiwNjU6BW/qVMKMR5yUDQCcCRmD
GkBioaZJR5qQbpIAI0ywDDw=
=QiAH
-----END PGP SIGNATURE-----

--Apple-Mail-2-708580040--
