From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 24/24] git-status.txt: advertisement for untracked cache
Date: Thu, 22 Jan 2015 20:16:58 +0000
Message-ID: <20150122201658.GB96498@vauxhall.crustytoothpaste.net>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
 <1421759013-8494-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEOBp-00064c-N2
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbbAVURL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:17:11 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43394 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753429AbbAVURD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 15:17:03 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c8c4:ec20:e47c:f338])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1BA142808F;
	Thu, 22 Jan 2015 20:17:02 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1421759013-8494-25-git-send-email-pclouds@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262866>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2015 at 08:03:33PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
>When a good user sees the "too long, consider -uno" advice when
>running `git status`, they should check out the man page to find out
>more. This change suggests they try untracked cache before -uno.
>
>Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
>---
> Documentation/git-status.txt | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
>index def635f..7850f53 100644
>--- a/Documentation/git-status.txt
>+++ b/Documentation/git-status.txt
>@@ -58,7 +58,10 @@ When `-u` option is not used, untracked files and direc=
tories are
> shown (i.e. the same as specifying `normal`), to help you avoid
> forgetting to add newly created files.  Because it takes extra work
> to find untracked files in the filesystem, this mode may take some
>-time in a large working tree.  You can use `no` to have `git status`
>+time in a large working tree.
>+Consider to enable untracked cache and split index if supported (see

This might sound more natural (at least to my ears) if you wrote=20
"Consider enabling untracked cache=E2=80=A6".
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwVq6AAoJEL9TXYEfUvaLh38QAJmmWiIiaZNhPdt8mQX8Ncu5
2Q08NJczSKP+LRUnmZKipMAQB++W8NLhR7y9s7xeUBo8KGFfPG3qbMtcHy8HVzq0
/EiNRh+mWm/OXwqmVh20Xua4HnaefM7ZXrv7ekFtTJyJ8qhjUOxQz+KAlCUBpWGq
Y2rr0/aymECsjPqdSGIA+3sAP6yR/mnE/aaCrV3csE+0YvFy/cpDgkuiokSXSWJf
fmMe+geN+/5Y6ZEjyTA+hMNcx8OJqPXbIZGFOZMp0bfiv5zLUt9XhcTochxVOoWn
FhhrS3ETVvtA8OsfnF69e4sZ9oRt/jD7Xkx+juoZ7NIkvieLJ0B96qbnMC9ZixoN
BYFjnKHVZCpTO8nnrnZdGJHVbu3lXzg3EDZ+2OkRoAdu2EfipCkSkm6qCXogBheI
k69ZkyUDK2VxSuUjEsJDYkkirrTGzZYqPucjpRgivUrMAPk+YLfyN+SQ/fHx4iA8
6qR6aHVNVkOZGLBp/IBDTEvdYS4KyYyAHwL3aKDODhy0rEUqo5indmqU15u3RYOy
xdYBaiBJUi/s7UZks6CQe+Y4xGOIX1GNfjxPt77VaceBdVaYU5oMPvUwSG3XuRda
ZaWc/qX7AFvOxGfF3M/rk3APFnqRu51qqzMRiLk6l8VMbBg2MxvGXwc+J+YHXn1w
qKHbEVwmIVSE8/M8xUZv
=6Dbu
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
