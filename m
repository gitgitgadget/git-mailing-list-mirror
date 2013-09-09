From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] version-gen: avoid messing the version
Date: Mon, 9 Sep 2013 23:30:28 +0000
Message-ID: <20130909233028.GB101065@vauxhall.crustytoothpaste.net>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
 <1378702889-21638-3-git-send-email-felipe.contreras@gmail.com>
 <7vtxhuilv1.fsf@alter.siamese.dyndns.org>
 <CAMP44s1B4F8k_TEgXT8reatCw9UKATDAH=D31v=79QA6voEKOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 01:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAum-0001UT-DF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 01:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab3IIXag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 19:30:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60193 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756072Ab3IIXae (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 19:30:34 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6A91228074;
	Mon,  9 Sep 2013 23:30:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMP44s1B4F8k_TEgXT8reatCw9UKATDAH=D31v=79QA6voEKOw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234402>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 02:00:55AM -0500, Felipe Contreras wrote:
> Of course not. First of all, who exactly is packaging release
> candidates nowadays? And second, why they can't they use the existing
> tools, like the 'version' file?

Debian unstable, for one.  However, they don't use RPMs and the version
would be rewritten to use ~ anyway.  Fedora rawhide might.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSLloUAAoJEL9TXYEfUvaLbz8QAJg1CQTtFfzdYeFige3L6mLn
oq17Y7arh0w9OM59Rry8Bbe1K92mmNhUvXDruXTlq62PXnXr8lmZPUCpBciMEVGD
g6+L78+B8e6ooJZXPCCWqGVyAAcdfTcXla6FQEhau/U/a6UsZluL2voxj5nP77wr
bLhX1gzPcBPl4B8Z6BlrhBao3LRdp5o5JOcfSBw1+z3igKI7FR8ICJa2IGWRu9al
WHq1b2OrpbdtvpqusyP7r/aT1QNzATU/n63SmSk9/nhDKrEyqgY+VPxMw8W1NRFe
sbp1xzTozO70q/U5TQtH53XNJah8FZsA/CF+bVs66QeKwgRHEaGbUv/G6ILr4f2i
TxUhzE+d5Kqx01Zi3KYWfdJzr3+tkBjDH23GTgnTUa4QhTLH6UrlxDySzL7fMuoR
CzDLHXDVOnwTqZ/8pOJwI6i65rvzK3470FWQ2y13LQI7ABqtoeSsR1DffMGPfzX5
e37bRchZaLA8MAZOr+BMG38iqZxGAPc1nYmtejeavXdHtpjmjO41Lxgx0vCrbS4M
U58dkATw+M/Vhc+jGd+N4qV+ByAnMHmsY9aWwosMAcYvSzVf4MSuz0QhrNY0aYDq
gUrWTyEYO2fHD5e+Uma78zn6Tk4H1YGDzSfBrXyO3iuyeNOCajobTls6yC0/mPru
EGJZQRqFUqUUvYdwwjkX
=ziI8
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
