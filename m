From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] describe: Add documentation for "--abbrev=+"
Date: Sun, 24 Aug 2014 06:35:38 +0000
Message-ID: <20140824063536.GB3439@vauxhall.crustytoothpaste.net>
References: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
 <1408814002-6553-3-git-send-email-jonh.wendell@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Cc: git@vger.kernel.org
To: Jonh Wendell <jonh.wendell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 08:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLRP8-00063q-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 08:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbaHXGft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 02:35:49 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49740 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752138AbaHXGfs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2014 02:35:48 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [195.24.50.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 891D02808F;
	Sun, 24 Aug 2014 06:35:46 +0000 (UTC)
Mail-Followup-To: Jonh Wendell <jonh.wendell@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1408814002-6553-3-git-send-email-jonh.wendell@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255783>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2014 at 02:13:22PM -0300, Jonh Wendell wrote:
> ---
>  Documentation/git-describe.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.=
txt
> index d20ca40..e291770 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -54,6 +54,12 @@ OPTIONS
>  	abbreviated object name, use <n> digits, or as many digits
>  	as needed to form a unique object name.  An <n> of 0
>  	will suppress long format, only showing the closest tag.
> +	+
> +	+

Did you intend to have two lines with just plus signs here?  I'm not
aware of anywhere else in the Documentation where we do that.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT+Ye4AAoJEL9TXYEfUvaLn2IQAKwCXIo4HBD1dCWyPnNH/1KQ
9Y5QijqOyGLTvv9uRylaG6ZVjuOWy5gH/a4feGVh3meMdXloV3IL9mQTS1cYCamG
a6iQIvfI1YEWNLNbsyQVu/vzcn8ab0FtM9i4hFmR/aopwqWjGVSQ7pQDB4Lp3HHZ
P9D/wogOKeOWO4x1uvpG0yIyJrvlPMdEEzke7U9cTDTntjqAixtWbbN2MpuaDv9Q
PUmyhWOyvjuejIIvdB43VOS4pXgnq8gtrjdnBXjA6SeqxxKxGLxv0q4hknPtGJrk
lJcR83RbDQxlOGrGU9+gFPcMEljuyJ9+rucYO45FNjoslePJU2+P3FGXjm+s0nb2
Kx9dhmK6BPBbCAppoXVED6bA1b3HuXNxiACmkCdeQSKy/CmpsMpttnTXqHxJUgWv
cumwko7BWinGeOIEjipR4mIn7NvKDN39ZRhWBgWyYM8QFXMaj3SqnWAUdVNPExj4
iqEC7bvukGJ256qoVH9DH0gexobDEb73FqjQ8lO5Pa3jhUdYI4H7WF4aG+4dn9OJ
k4+eI1HW0tiWkSSjQefFsSK33CMlfen6tQFPF1BZz5Y9KqOW41+bwvSOkMbt/sXe
WlULyNfvrRzHDZ3iHS5DBFL/PAC0GWx+r2I6Z7rgWcrHo+ttMCPDt162Rffdr9Wc
CB3NfmNcAAx+8/RtxpT8
=eV8q
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
