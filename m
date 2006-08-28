From: Kai Blin <kai.blin@gmail.com>
Subject: gitweb filter for patches by a specific person in a specific timeframe
Date: Mon, 28 Aug 2006 14:59:21 +0200
Message-ID: <200608281459.26643.kai.blin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9728424.BFVzyFuDG1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 28 15:01:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgjT-0007nR-Sj
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 15:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWH1NAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 09:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWH1NAq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 09:00:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:6176 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750754AbWH1NAq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 09:00:46 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1007172nzf
        for <git@vger.kernel.org>; Mon, 28 Aug 2006 06:00:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=pIxyW9FY0C22RhnmuXNHpxnS3w9wm7r7VALAG9pyd+6fPX4XG7/lxc0b07xzgz7u+rav6htCtpU7Qq1oJtRU9t33R5HcJ5pzTdyhJMSIrW2PrFyQwalISuphLBJk0O8s/pgnvZVwqhzwVibyy1QoPjVoFH8VanbXUWTO1WU4iqU=
Received: by 10.64.156.3 with SMTP id d3mr6788561qbe;
        Mon, 28 Aug 2006 06:00:45 -0700 (PDT)
Received: from blackjack.home.nowhere-productions.org ( [212.23.126.23])
        by mx.gmail.com with ESMTP id e18sm4305495qba.2006.08.28.06.00.43;
        Mon, 28 Aug 2006 06:00:45 -0700 (PDT)
Received: by blackjack.home.nowhere-productions.org (Postfix, from userid 1000)
	id 163F5D093F; Mon, 28 Aug 2006 14:59:27 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26154>

--nextPart9728424.BFVzyFuDG1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

I have just completed my Google Summer of Code[1] project[2] working for th=
e=20
Wine project. Now, as I was submitting patches to a git repository, I don't=
=20
have a branch solely containing my patches or something like that. Google=20
seems to want something like this, so I figured maybe I could get gitweb to=
=20
filter for my patches during the SoC period. Is that possible?
If not, does it sound like something feasible to add?

Cheers,
Kai

PS: Please CC me, as I'm not on the list.

[1] http://code.google.com/soc/
[2] http://wiki.winehq.org/NtlmSigningAndSealing
=2D-=20
Kai Blin, <kai Dot blin At gmail Dot com>
WorldForge developer    http://www.worldforge.org/
Wine developer          http://wiki.winehq.org/KaiBlin/
=2D-
Will code for cotton.

--nextPart9728424.BFVzyFuDG1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE8uiuEKXX/bF2FpQRAsnVAKCJfsQgUqyeNY8An1QSY74XruF5dgCgovMU
TQ6trzM+L5oTMyGrcfGECVo=
=FyPG
-----END PGP SIGNATURE-----

--nextPart9728424.BFVzyFuDG1--
