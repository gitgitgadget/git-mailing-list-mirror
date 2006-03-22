From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: Question about possible git races
Date: Wed, 22 Mar 2006 21:46:21 +0100
Message-ID: <200603222146.25395.astralstorm@o2.pl>
References: <200603201724.12442.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1411935.IPGzkifhxl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 22 21:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMAHe-0006Tc-PR
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 21:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWCVUuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 15:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbWCVUuU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 15:50:20 -0500
Received: from mx.go2.pl ([193.17.41.41]:13722 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932715AbWCVUuT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 15:50:19 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 9AE41137759
	for <git@vger.kernel.org>; Wed, 22 Mar 2006 21:50:12 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FMAEF-0001KU-Up
	for git@vger.kernel.org; Wed, 22 Mar 2006 21:46:51 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <200603201724.12442.astralstorm@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17829>

--nextPart1411935.IPGzkifhxl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 March 2006 17:24, Radoslaw Szkodzinski wrote yet:
> I'd like to write a multithreaded application using git, so I'd like to s=
ee
> if there are any races:
>
> - push vs fetch
> ...
> - push vs push
> ...
> - fetch vs fetch
> ...
>
> I'm meaning really bare git there, w/o bash+perl scripts.

Could anyone try to answer the question?=20
I'd really like to know, because it's crucial to my application.

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1411935.IPGzkifhxl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEIbehlUMEU9HxC6IRAgjDAJ9WWUPsgJFc2B6TGR1Dr+l4z2yIAgCgsJkZ
2CiDoD8A3I9qHpre+Lt+WBo=
=/XWg
-----END PGP SIGNATURE-----

--nextPart1411935.IPGzkifhxl--
