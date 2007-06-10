From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 17:04:47 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706101704.51374.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101645.27090.ismail@pardus.org.tr> <e5bfff550706100659l41c392f4n9dc9fb3097f3da29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8506495.6DeO8KbZdX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 16:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxO2a-0006KW-OF
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbXFJOFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbXFJOFL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:05:11 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:48322 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751559AbXFJOFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:05:09 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 0A78060257C2;
	Sun, 10 Jun 2007 17:05:03 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706100659l41c392f4n9dc9fb3097f3da29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49737>

--nextPart8506495.6DeO8KbZdX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 16:59:48 Marco Costalba wrote:
> On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > Still no go. Though the final linker line have a -lQtUiTools
>
> I'm quickly running out of ideas.
>
> Please post the list of your qt4 libs directory
>
> $ls /usr/lib/qt4/lib/
>
> and again your make output after the patch.
>
> One thing I would like to to is to test with Qt4.3 as in your
> environment but it will require some time.

Uploaded to http://cekirdek.pardus.org.tr/~ismail/tmp/qgit4-report.txt .

Great thanks,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart8506495.6DeO8KbZdX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmwFA0e9qviWcMsnAQJaVQ/+IgwOrsz3QtqDrU+Xy+RaLCq3zy2bf/ot
Rlzs3HIh3M7C0nIbe3ZYpFOC5Ku9zgcIQA9rv3dnZubEOuCm6tC24S8FEq7+qW04
k7r3SWdFdqgEGHc0NrvlIXU2jlp2lDYUY+RebtDEYeqO7MoQ4n30Wc0wfUOuuu2t
CO6czeYBCjHY+XVowPoeI27u8RY7/ZF1f4fsMfuqf8VFdugtLVoF1q12FbwbHApa
0nD4KKRuNFOGMn2J/2IQpv3QTlYPPx7zwXDHUPJlAUwGLzsqem+U8Nrs+SVHms2S
Yuf1SfqZvQhcrd0hWofc3yLFLR6lHw62B66qrMgfL+dNAzSLKFKklTn664EJ9/VU
r5c6oncn4XzyqXBk2lfPDMX0znHnSbyYFknxFt4SmsBnoRKoorQzpuiSM2ex2h4h
bfHS3Wv4rjgmGrzYSG9AZ4QLy7Eo/+LobnsCBQVzHqELj70JxoFOQOimPjsDvpHa
adp4149i/7tWpUdMJ6L5G9u5BkN5zBGq7Rq1hjDW4zCnMF5b5QxvYmAGuKWcVzdG
RanpRRey69DXVpdupDQ7umuxYEv3sNY8yONthcdblPFLrKE8eIAsGT+4jJCGUU7x
ZlByjLedH3DLS1eqtQxtMPTytP/u2pM7dmzv4WLUmEk85jDqy1Uc5zv4Jdt+e9oj
U35p5q2PvGw=
=RTB5
-----END PGP SIGNATURE-----

--nextPart8506495.6DeO8KbZdX--
