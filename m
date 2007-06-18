From: Simon Hausmann <simon@lst.de>
Subject: merging git-p4 into git/fastimport.git (second try)
Date: Tue, 19 Jun 2007 00:35:55 +0200
Message-ID: <200706190036.01950.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1670913.7BQEiXvPEk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 00:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0PpH-00045t-LM
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 00:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbXFRWfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 18:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbXFRWfj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 18:35:39 -0400
Received: from verein.lst.de ([213.95.11.210]:56622 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932173AbXFRWfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 18:35:39 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5IMZVo6000940
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 19 Jun 2007 00:35:32 +0200
User-Agent: KMail/1.9.7
X-Spam-Score: -0.001 () BAYES_44
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50424>

--nextPart1670913.7BQEiXvPEk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

after reworking most of the really short commit logs and adding the missing=
=20
SOB lines I'd like to ask for consideration of merging git-p4 as part of=20
contrib/fastimport/ from

	git://repo.or.cz/fast-export.git git-p4


Simon

--nextPart1670913.7BQEiXvPEk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGdwjRWXvMThJCpvIRAo97AKDr/MyTIt/Vt1K1Z7KhLhquYU3CogCg491X
JEIUcyobub7ABm2uiGoImB8=
=vHxL
-----END PGP SIGNATURE-----

--nextPart1670913.7BQEiXvPEk--
