From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git-cache-meta -- simple file meta data caching and applying
Date: Thu, 8 Jan 2009 22:29:45 -0600
Message-ID: <200901082229.46433.bss@iguanasuicide.net>
References: <87hc49jq04.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3872595.ZtGjDl7Y5E";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 09 05:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL91d-0001qU-Rn
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 05:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbZAIE3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 23:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZAIE3t
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 23:29:49 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:37381 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZAIE3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 23:29:49 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090109042948.FLUD26835.eastrmmtao101.cox.net@eastrmimpo01.cox.net>;
          Thu, 8 Jan 2009 23:29:48 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 1GVm1b00B2i4SyG02GVn8y; Thu, 08 Jan 2009 23:29:48 -0500
X-Authority-Analysis: v=1.0 c=1 a=L12jSFsJ6lsA:10 a=0rXz1A-AtCwA:10
 a=Fq1VQ0LPAAAA:8 a=_Ur97z5I8IrHvSefInkA:9 a=_3onmQ3wQuIF1HDEEPsA:7
 a=_Eah4PVar7PI6t7uIsVu_vc5uI8A:4 a=Vuv1EOu76mEA:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=iZDPj9AI_IXyMhDzs-AA:9 a=8YDu315M-FE4ZOuWZJ3zrwYfT08A:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LL90E-000A83-HH; Thu, 08 Jan 2009 22:29:46 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <87hc49jq04.fsf@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104981>

--nextPart3872595.ZtGjDl7Y5E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 08 January 2009, jidanni@jidanni.org wrote=20
about 'git-cache-meta -- simple file meta data caching and applying':
>Gentlemen, I have whipped up this:
>
>#!/bin/sh -e
>#git-cache-meta -- simple file meta data caching and applying.
>#Simpler than etckeeper, metastore, setgitperms, etc.

You *might* look at pristine-tar from Debian.  It's specifically designed=20
to be able to generate the .orig.tar.gz that Debian packages are based on=20
from a VCS checkout, but it's code might be useful.

I do like your script though.  It's simple and the output is plain text so=
=20
it is easy to have your VCS maintain it.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3872595.ZtGjDl7Y5E
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklm0roACgkQ55pqL7G1QFmWoACfc7kPw11l4iHVTimJ8/iAn0u5
cT0AoInNSSSOpODJLAxQEK0cbZk0zyqH
=FIae
-----END PGP SIGNATURE-----

--nextPart3872595.ZtGjDl7Y5E--
