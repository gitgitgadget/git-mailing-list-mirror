From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig for git-format-patch.
Date: Mon, 9 Feb 2009 08:39:57 -0600
Message-ID: <200902090840.03344.bss@iguanasuicide.net>
References: <498E50E2.8050309@codeweavers.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903491.7000509@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2721370.86QUGYNyos";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ben Bucksch <ben.bucksch.news@beonex.com>,
	Jeremy White <jwhite@codeweavers.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 15:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWXKN-0004EW-W7
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 15:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZBIOkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 09:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZBIOkM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 09:40:12 -0500
Received: from eastrmmtao104.cox.net ([68.230.240.46]:42759 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbZBIOkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 09:40:10 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090209144006.TTIJ3752.eastrmmtao104.cox.net@eastrmimpo01.cox.net>;
          Mon, 9 Feb 2009 09:40:06 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id Dqg41b0052i4SyG02qg4kh; Mon, 09 Feb 2009 09:40:05 -0500
X-Authority-Analysis: v=1.0 c=1 a=6f3eBEffxpEA:10 a=j0VOIwAs8i0A:10
 a=Fq1VQ0LPAAAA:8 a=6i2Mm5TXWJJtdopHHNoA:9 a=VQiziwjvc3NiplRKfF4F8xiUJD4A:4
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=4li9ktzFzW-tsNy7rUIA:9
 a=rNLFLIV9pFbXKK2osUl_LqZuvGAA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LWXIp-000Iyg-IC; Mon, 09 Feb 2009 08:40:03 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <49903491.7000509@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109077>

--nextPart2721370.86QUGYNyos
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 09 February 2009 07:50:09 Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 09.02.2009 14:36:
> > On Mon, 9 Feb 2009, Ben Bucksch wrote:
> >> On 09.02.2009 13:34, Michael J Gruber wrote:
> >>> Johannes Schindelin venit, vidit, dixit 08.02.2009 18:28:
> >>>> On Sun, 8 Feb 2009, Jeremy White wrote
> >>>>> Essentially, the problem is well understood - Thunderbird uses
> >>>>> format=3Dflowed by default, which is what mangles the patches.
> >>>> I guess I'll start discouraging use of Thunderbird from now on.
> >> Or you could just publish:
> >> 1. Prefs | Advanced | General | Config Editor...
> >> 2. "mailnews.send_plaintext_flowed" =3D false
> > Ah.  Mhm...
> >> I don't think it's a matter of clue, it's a matter of background and
> >> attitude.
> > Yeah, I think my background dictates that I stay by my word and recomme=
nd
> > other mailers than Thunderbird.
> I think Ben made it clear why "format flowed" is the default.
> The default will not change.

=46or the record, KMail does f=3Df by default, too.  And I think any client=
 that=20
doesn't do format=3Dflowed by default it probably doing a disservice to it'=
s=20
users.  Luckily, in KMail it is easy to turn off for a particular message w=
ith=20
"Options -> Word Wrap" in the composer window.  I think you can turn it off=
=20
globally, but patches aren't a big enough part of my workflow that I've=20
investigated it too much.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/



--nextPart2721370.86QUGYNyos
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmQQD4ACgkQ55pqL7G1QFnf0QCePUJlfwj2Gg7YzHEqzy8mGv/p
8NUAn2k+z3QsZGyQ7LCFQ730mXU+Zb+o
=jBYF
-----END PGP SIGNATURE-----

--nextPart2721370.86QUGYNyos--
