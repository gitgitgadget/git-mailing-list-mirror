From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Minor glitch in git-gui: changes to global options aren't taken into account immediately
Date: Tue, 6 Nov 2007 02:30:02 +0100
Message-ID: <93FD01F4-71F8-4025-BA7F-A642E2B7CAD6@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15--890445938"
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpDH9-0001Qk-4b
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXKFBaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 20:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbXKFBaK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:30:10 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38681 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXKFBaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 20:30:09 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IpDGZ-00040M-73
	for git@vger.kernel.org; Tue, 06 Nov 2007 02:30:07 +0100
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63610>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15--890445938
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi list,

[git-gui version 0.8.4
  git version 1.5.3.4.398.g859b
  Tcl/Tk version 8.4.7
  OSX 10.4.10]

I've just realized that git-gui wasn't only using 3 lines of context  
in the diffs so I changed the setting under the menu Wish>Options...  
under the section `Global'.  I had to restart git-gui so that the new  
setting is taken into account.  Admittedly, it's a minor  
inconvenience, but I thought I'd let you know, in case one of the Tcl/ 
Tk hackers out there want to fix it :-)

Also, when I click the green `+' to maximize the size of the window  
of git-gui, it doesn't do anything.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-15--890445938
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHL8OawwE67wC8PUkRApD9AJ46RzKBWEtSzEby/nBzMr0TKlsFVgCeOYlb
FoezTnL7vcKjtShqJlzID08=
=eRJ3
-----END PGP SIGNATURE-----

--Apple-Mail-15--890445938--
