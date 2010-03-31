From: Yawar Amin <yawar.amin@gmail.com>
Subject: [PATCH] Documentation: clarify grammar
Date: Tue, 30 Mar 2010 22:28:27 -0400
Message-ID: <4BB2B34B.1080508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig25FDC2FB09BD8E74083D522E"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 04:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwnfo-000147-D8
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 04:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021Ab0CaC2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 22:28:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47219 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932937Ab0CaC2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 22:28:30 -0400
Received: by vws20 with SMTP id 20so1222222vws.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type;
        bh=N1TA8q0I36DvrstKBoFL4aMEgxI1zJcfDk5qsJHgG/Y=;
        b=pTDcX7ymqVDKx3wJXLwo161dFKxoiti5Am1yxDjeBFdLiRK/JDcMtMTSgClh9INSRQ
         BeBovH7guWSh/Dqfdw/h1+lt25zn0AJau6xnxcmrB4xGFlCLCe9v2bggPLHHSY+22Nex
         fMI8TDxNkWdiLOA3fFBQv2zmkPRpK2bKBl8Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type;
        b=ZwznhYydnA0c/M5AoT7zktV+dN1tBDSEBrN+26RKY4aoEvJrpgo12skdor9VlpDUVH
         5EqYQDQsUcHulkGCeOtFdgizI3Lr/gVYB0Xu461XF+JAh+gCVe/txHNoI4tfWrLe/YEu
         p+7Z2nV0o2lsicvnoZ+8XgMQX569b93zvP4P8=
Received: by 10.220.126.197 with SMTP id d5mr4116060vcs.121.1270002509906;
        Tue, 30 Mar 2010 19:28:29 -0700 (PDT)
Received: from Yawar-Quadir-Amins-MacBook.local (CPE00173f9e1ecd-CM0014e827917c.cpe.net.cable.rogers.com [99.230.35.242])
        by mx.google.com with ESMTPS id 29sm132834272vws.5.2010.03.30.19.28.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 19:28:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143636>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25FDC2FB09BD8E74083D522E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Parenthesize the mention of the git protocol to make it clear that
`former' and `latter' refer to the standard SSH syntax and the
alternate SCP-like syntax, rather than the SSH protocol and git
protocol.

Signed-off-by: Yawar Amin <yawar.amin@gmail.com>
---
 Please Cc replies to me, thanks.

 Documentation/urls.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 459a394..29ded16 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -17,7 +17,7 @@ to name the remote repository:
 SSH is the default transport protocol over the network.  You can
 optionally specify which user to log-in as, and an alternate,
 scp-like syntax is also supported.  Both syntaxes support
-username expansion, as does the native git protocol, but
+username expansion (as does the native git protocol) but
 only the former supports port specification. The following
 three are identical to the last three above, respectively:
=20
--=20
1.7.0.2



--------------enig25FDC2FB09BD8E74083D522E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEAREIAAYFAkuys0sACgkQqOXNpejCDdRZugCeJpItfGR2dzCWDUnCVwpwSXsV
nNoAoJlZQRSCXFNyrzIvHCvKHoC1TkVd
=Dehe
-----END PGP SIGNATURE-----

--------------enig25FDC2FB09BD8E74083D522E--
