From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 01:58:41 -0600
Message-ID: <200902100158.46884.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4861976.2ScUHQGbgW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 09:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWnZP-000708-L4
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 09:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbZBJIAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 03:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbZBJIAt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 03:00:49 -0500
Received: from eastrmmtao102.cox.net ([68.230.240.8]:44025 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbZBJIAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 03:00:48 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090210080037.GLAY8735.eastrmmtao102.cox.net@eastrmimpo03.cox.net>;
          Tue, 10 Feb 2009 03:00:37 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id E7yn1b00B2i4SyG027zttF; Tue, 10 Feb 2009 03:00:15 -0500
X-Authority-Analysis: v=1.0 c=1 a=kahiNejmDeEA:10 a=2p8oXooCbN8A:10
 a=Fq1VQ0LPAAAA:8 a=ePsdSzR-p6olBjPDX_kA:9 a=grtyAi_wy3l89x7Ru979IdHGm90A:4
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=E53Qa5HFL1CIiZSd7XcA:9
 a=rW8BQhDl6Yqk8Q1E1uk4Pv-byAoA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LWnW3-000KeE-06; Tue, 10 Feb 2009 01:58:47 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109187>

--nextPart4861976.2ScUHQGbgW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 09 February 2009 15:12:06 Johannes Schindelin wrote:
> So I think it would be a sane plan to do the following when a commit note
> is requested:

So, something like a Trie data structure?  I think that is a great way to=20
store fixed-length strings from a limited alphabet with arbitrary data=20
attached.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart4861976.2ScUHQGbgW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmRM7EACgkQ55pqL7G1QFkd2wCggYF7ZqrKIm+JGfJAzA1abXVo
+ZMAoIm1GzoovXj453g2PZ9M8K63OkYu
=qbhK
-----END PGP SIGNATURE-----

--nextPart4861976.2ScUHQGbgW--
