From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Add missing test file for UTF-16.
Date: Sun, 4 Aug 2013 16:06:17 +0000
Message-ID: <20130804160617.GA4560@vauxhall.crustytoothpaste.net>
References: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
 <CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 18:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V60pA-0000Bg-DR
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 18:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3HDQGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 12:06:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45684 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753496Ab3HDQGX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 12:06:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 65F3528073;
	Sun,  4 Aug 2013 16:06:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231633>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 04, 2013 at 09:31:01AM +0700, Duy Nguyen wrote:
> Tested-by: Duy Nguyen <pclouds@gmai.com>

I think you're missing an "l" in the domain name there.

> and sorry, my bad. I think we need your sign-off in this patch.

I just ran across it because I'm going through all the TODO tests and
seeing which ones I can fix, and I generally just CC the last three or
four people who touched the files in question.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJR/nv5AAoJEL9TXYEfUvaLneEP/Ru5c1aCsjDpo79wcSdeDwY0
951V8AdhGreGKe6R1BTsltv0rISFSpM6GkCeyy0EUAeBbC6EYfxZ/PHBNv6zkt3/
rugRnCl6my/XdLR24VXuIgmNmu533AnQceEl8bu182eRNgKriDlGKosI8CEG4GzN
TOVEmro6HRyGHNYmXqomADbeAsbubwVhC8dEKbuAC73z1yJNgBniix4+G8i2+J1y
/splXXxHP0xAvLpNSsfT/1deiEja8F/ToiYjEGeGm5p5GeosJyEamv1M57AU/Ofz
wO9Gc14Ft6XgXUETJLn48Yo+9Fe605nKOuWa62P6hPsuYk0KoqmPDgvbFCa537pV
JkGkcwBFjtrc1DD/2abXTh/yF4xnDKXxojhXC/bSn78Q29Z6FMIUnoBhiddfOBqG
gSks0W5ppmB5vPUvSpeksOjMXQllzXiKrEaKN+wKpMWzy904ZEHEBl1ELcnLbW+w
kerHA2zUv1+FAnjKKKJtktuxrnNpLDc+3MvJTvF4kgs/qYAr3YZUORV79Zf5Q0q5
+tvJ/UnoHHbMMI6qHcCRByZSzM0eJccZedeDN/DYQgMnAthUOacOk8H6QycCNpHb
ryFfgGifHcFRf44F1x4w2Pw8EB698ygH4bL8ppMThkIUUZAqa5sO1NmQVpS2menT
bvrNKbOgeHLAKXf3Dm8T
=LAIf
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
