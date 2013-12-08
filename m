From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Adding --gpg-sign to cherry-pick, revert, am, rebase
Date: Sun, 8 Dec 2013 20:40:09 +0000
Message-ID: <20131208204009.GG118858@vauxhall.crustytoothpaste.net>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Sun Dec 08 21:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpl9n-0003TH-F0
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 21:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949Ab3LHUkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 15:40:35 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34549 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759935Ab3LHUkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Dec 2013 15:40:16 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9965:b023:d7b:c74a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7B4F12807E;
	Sun,  8 Dec 2013 20:40:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239049>


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2013 at 04:54:16PM +0100, Nicolas Vigier wrote:
> Hello,
>=20
> Here is a series of patches to add the --gpg-sign option to be able to
> gpg sign commits, to the cherry-pick, revert, am and rebase commands.

Whatever happened to this series?  It looks like it never made it into
next, master, or pu, and Junio's immediately-following "What's cooking"
email didn't mention it.

I'm really very interested in seeing it merged, so if there's something
I can do to help it along, please let me know.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSpNkpAAoJEL9TXYEfUvaLVg4QAKddgbdwkMX33LiPXNlF/p3j
mYWG8F3oSl0eIPqkk/968Yu5OQZiFpvB0B9oyK5tCp8+QhL9vtMJe7CeA0c3LC/I
SNXZ0FjPPw79Hz2OAFSpx6ahh5ia7yibtQuC/9bB1gPWa5aL3ZSz0iindsvoQJd+
WIre3YGGEsIXwxA2uZ+A5H/qOY+5QnKTZX0eZdlO1gnLX+az8Yi+X+HLNBzCBrYZ
FaEbGLOSWYsl8F1Aj83YbvBxG7kiwUMghVAbH8ovM6keF4uFuTEg432UpBu/HBof
6XwXmGkwsrkbYNPbpd+rFBPIlv9MkMX5lJa5/BtvMqalb2OFrtS+IJWrgwABJ/fz
TL2vtr3Zh270/PFKvWNhoabqWhuRUxtX8Zb1sU8hMAJMW4GiHG13zVHP7HE9J1fK
jANZCci5cTGhmJDFLlz7TawokiWF8/yO9v43WlReL8MnErErZzz9u/RLwuf/HfcK
YxFbjUkDtxmXqw0FoRQkk9BFptu1CTTcc4XpLczd5B7gwjlg9e2/EOUyBHNutLuU
geXSkND4EmIpTo2MkozCoZxz/llN48tafIYEZP89GHbcjx8OasRSljYJKjFOlHH/
hRQjjRL3CnpXvOEbdlRbZ481Y15ev8n1rO2HrUnLKa6KQD9Dj3PCEq8R+MzCINHt
hkO0reoMUgctBEEKM/tU
=zxIl
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
