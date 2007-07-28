From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 12:07:41 +0200
Message-ID: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--995852588"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 12:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEjDV-0001ey-Cd
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 12:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbXG1KHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 06:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbXG1KHx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 06:07:53 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:59782 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXG1KHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 06:07:52 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IEjDC-0002Y8-UU
	for git@vger.kernel.org; Sat, 28 Jul 2007 12:07:51 +0200
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54020>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3--995852588
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hello,
git version 1.5.2.3 over here, I've googled and searched in the ML  
archives but did not find this:  when I git-svn rebase, my commits in  
Git (that are temporarily removed and then re-applied) get their  
commit message flattened on a single line (needless to say this is  
utterly annoying :D).

Is this a bug or something?

Thanks.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-3--995852588
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGqxVtwwE67wC8PUkRAnBLAJkBu/fy74RRDf1yWbAQ7pilIDkVQwCgmmQN
ZEEuqR5dvGL6+RNh/G949yw=
=i1qz
-----END PGP SIGNATURE-----

--Apple-Mail-3--995852588--
