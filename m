From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 21:10:04 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706102110.14258.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101933.36760.ismail@pardus.org.tr> <20070610175628.GI4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1358725.InDTUCPxBZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pavel Roskin <proski@gnu.org>,
	Andy Parkins <andyparkins@gmail.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxRs2-0000Vv-Pz
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 20:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbXFJSKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 14:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbXFJSKd
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 14:10:33 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:43725 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754228AbXFJSKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 14:10:32 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 23459604C865;
	Sun, 10 Jun 2007 21:10:24 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070610175628.GI4084@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49752>

--nextPart1358725.InDTUCPxBZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 20:56:28 Jan Hudec wrote:
> On Sun, Jun 10, 2007 at 19:33:31 +0300, Ismail D=C3=B6nmez wrote:
> > On Sunday 10 June 2007 17:36:42 you wrote:
> > > On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > > > Uploaded to
> > > > http://cekirdek.pardus.org.tr/~ismail/tmp/qgit4-report.txt .
> > >
> > > Ok. You seem to miss all the debug libraries  _and_ the whole
> > > libQtUiTools library.
> >
> > Nope not a Qt problem. Removing -frepo from CXXFLAGS fixes the issue. G=
cc
> > 4.2.0 doesn't seem to like it for some reason.
>
> I did a brief STFW and found problems with -frepo to be rather common. Fr=
om
> what I understood, it works by trying to link, parsing the errors,
> instantiating the missing bits and compiling again. And the whole thing is
> rather fragile.
>
> What could be interesting for you is debian bug
> http://lists.debian.org/debian-gcc/2007/05/msg00374.html
>
> It says that -frepo only works with C locale, but it would actually be in
> any locale where ld messages are not localized. On my system it has messa=
ge
> catalog in da, es, fr, ga, sv, tr, vi, zh_CN and zh_TW. Don't you have
> tr_TR for LC_MESSAGES?

My LC_ALL is tr_TR.UTF-8. Btw LC_ALL=3DC make gives the same problem.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart1358725.InDTUCPxBZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmw+hke9qviWcMsnAQIzLg/7BENwgXv7LFVA8Dj0RjlCN7RQhs5bq4xH
UOb5ztTctXZVd1ZteHKeSr8MMpLOcG64s5L8/quIANWREAQEXQtFzBbZBx6izQJd
dutaS7pY173rieFwGfQT1w3BG4TYtaxUfU+O7B09I0mMHAcjDxO7Lk1PIJTiXARu
Cq66NKxDMvlOF8TF0bRHtFP2+ISvDS1bfJHlvxlnDbPCFeRBcsQpcS4v5tugCRlx
PdVCDPBCT83yNBZZLiG5Fzmmnoi/1zYWiWZS9OwLD88Qehkunz72DnI4lHOBP4Ir
CnE9riK2uE6T5e83YJcKLpitS9+INZjuOIlVguJ37LZIaGH7KZ5yJ0qL89ckIpjP
4Q5SwMd5hdg0XvPmDAOicHgWnFOhjGjsKTnXALpCSLLo7olYdMRESFTZNNvdaNkN
W5HIABev8KvtHnD08IcYd0JHZLdzZq4LWWOaML/+bCAv2gR5K2SXqxKm0sD6C5bS
cLSV/cNKlow03C51IMlYvnPTcSFPMHpWKjZ+8X8WaflNHnbkyATeApCV4Eqjxs+k
K3bQK0TVpPnH/zESP44zLps0lZY/NQZDXcdxKvLmhwXo3fLYu5kMpEZPei3+kbW6
M1gJfpqqFL1r9bMNMGhVfgsJtb/Sh2ppY4jwzhrrVG3bb328lH08c9uLihO4XfEF
FDHAnfjHodw=
=LYER
-----END PGP SIGNATURE-----

--nextPart1358725.InDTUCPxBZ--
