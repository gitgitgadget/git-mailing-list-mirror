From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 16:41:39 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706101641.40372.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101556.25110.ismail@pardus.org.tr> <e5bfff550706100626t2d5721a6r7beb0cfeb19dff4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4334385.PeI8T1lOxW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:42:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNg9-0002cD-P5
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 15:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbXFJNmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 09:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXFJNmA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 09:42:00 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:47044 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895AbXFJNl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 09:41:59 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id AEBEC6025B3B;
	Sun, 10 Jun 2007 16:41:51 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706100626t2d5721a6r7beb0cfeb19dff4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49730>

--nextPart4334385.PeI8T1lOxW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 16:26:27 Marco Costalba wrote:
> On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > > Please could you post _whole_ the make output?
> >
> > Attached.
>
> It seems your linker is unable to find libQtUiTools.so where the
> missing functions are defined.
>
> As example try:
>
> $nm -C -D libQtUiTools.so | grep ::mutableFindNode
>
> And you will see that this as all the other missing functions are in
> this library.
>
> I will try an update to src/src.pro file to let Qt pass this library
> to the linker.

It seems to be built as a static lib only, I only have libQtUiTools.a .

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart4334385.PeI8T1lOxW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmv/lEe9qviWcMsnAQKklw//Xf6apTJ8CBLofkDwQ5FTjIIYwz/uUvBp
kI9pvXLV9yUa7GjFP1WY+Sgwzrdy9bJxVrKh4T8jDsSKFNLILkQWZvn6J/I7+72T
OTy8Dd9WkXJRpSKpatNiNs2lA7+sAfV+hJn4h9hOBDezDQkr9C3MpIabP1mSieEy
ADQWFjtcXUYWpo3UrSUtWIfnKICGhaaYEml5RLFZNG8uX+JwqSMwoCmttH4N8SdO
oI5JNBitlcnPmAFGddZ1g8L/nmwNkK9w5L/52GEDj0tOel6PAAHKgve9O9Ormoul
SD1rRiNSBXcM8aOhi/x6CCV0EDTWiX/olPXW9XJkWH1oi9kiCzYa1BQoCfKfSpb3
eny1IcRr1c/o+/r6RlWrP4tIgD0kQcDhKRPi9DIfBdlenvZK+8ZVoMXoUPmyTQWv
UF2X4SKEsK5cxJN42FlFc4IueawQKNXOie/mu1pTx6kSkQH5EXT2+t6yTYeYyHv6
RZAJMgmfG1p7NEZJannkxpF+pS2ub3L9eTEVnVu+rLa44NO5wEG/ZSpt60WiU2qT
PPzN/N1JuHYXi2gyD4Tx9xDj/xmnwcO4X1nGh21qBNyunbX1cH1iczry+E9nmTuI
td7L+Adp3X3dEWglW52Pkk6cwiRXW+XzBKBqmZ62Z3ok+rjfN6jPGcYi7iyX4OtJ
23+mO1KrkiU=
=lcMl
-----END PGP SIGNATURE-----

--nextPart4334385.PeI8T1lOxW--
