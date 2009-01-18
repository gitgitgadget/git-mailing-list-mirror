From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [WIP Patch 00/12] Refactoring the http API
Date: Sun, 18 Jan 2009 05:29:28 -0600
Message-ID: <200901180529.28980.bss@iguanasuicide.net>
References: <20090118074911.GB30228@glandium.org> <7v8wp9yq23.fsf@gitster.siamese.dyndns.org> <20090118091219.GA6505@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1718710.Gx6fhvW44z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 12:31:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOVsV-000068-2t
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 12:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764314AbZARL3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 06:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762883AbZARL3c
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 06:29:32 -0500
Received: from eastrmmtao104.cox.net ([68.230.240.46]:35843 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762818AbZARL3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 06:29:31 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090118112930.GXHF3752.eastrmmtao104.cox.net@eastrmimpo03.cox.net>;
          Sun, 18 Jan 2009 06:29:30 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 4zVV1b0092i4SyG02zVVF9; Sun, 18 Jan 2009 06:29:30 -0500
X-Authority-Analysis: v=1.0 c=1 a=aNoIo_LZgtQA:10 a=HC5W82astm0A:10
 a=Fq1VQ0LPAAAA:8 a=vHLO6Zzms4sDcdUuQBUA:9 a=PIAx3TNUFdI3Cpyl3nJ9WlYR-IIA:4
 a=Ak6yjH5nytEA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=u1kNeMVqq7HrlpLE-sUA:9 a=Z3-fDPXWFpXgLCoYmtN_YuaUFgIA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LOVqL-000Dci-2u; Sun, 18 Jan 2009 05:29:29 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <20090118091219.GA6505@glandium.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106172>

--nextPart1718710.Gx6fhvW44z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 18 January 2009, Mike Hommey <mh@glandium.org> wrote about 'Re:=20
[WIP Patch 00/12] Refactoring the http API':
>On Sun, Jan 18, 2009 at 12:30:12AM -0800, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> > [I]
>> > haven't actually tested it, though, as the code hasn't changed much,
>> > I guess it should be fine.
>> >  6 files changed, 162 insertions(+), 304 deletions(-)
>>
>> Thanks.
>> But I am puzzled by what you mean by "haven't actually tested it".  Do
>> you mean you do not use http transport very much yourself, or even when
>> you do you do not use a version of git with these patches applied?
>I mean I haven't tested the rebased version. The original version was
>tested extensively a year ago. I don't use http transport that much
>now.

I know it's uncool of me to ask to do this, BUT... Do we have a good=20
test-suite for this?  If so, I can always run it against any number of=20
different WEBDAV implementations.  I have a glut of CPU time on many of my=
=20
systems and enjoy breaking things.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1718710.Gx6fhvW44z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklzEpgACgkQ55pqL7G1QFnqGgCeLbm4HD6eWZy19CsiBW4nqls4
2SIAn39lMFDxH5vw8tPmWy/cSgSPS0lb
=qCtZ
-----END PGP SIGNATURE-----

--nextPart1718710.Gx6fhvW44z--
