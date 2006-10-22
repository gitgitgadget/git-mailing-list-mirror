From: Andy Parkins <andyparkins@gmail.com>
Subject: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 15:48:35 +0100
Message-ID: <200610221548.42048.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21515191.1E9f57hqxU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 22 16:51:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbefW-0008IQ-Fm
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJVOvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 10:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWJVOvP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:51:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12806 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750700AbWJVOvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 10:51:15 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1056081ugd
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 07:51:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=rsAsgK11CQMddT0K0PRjo9KkfjNty+e3BVO+cYQ/8NFEhIQnBDAKfLRudjKRnkbcS6dxxDL55vtxtVk5C+mh3qU4PQHYs5zEnMSoESznMCva8EyVVPu5jMk3rHXzepxizGBIEUeOo8QCg8YUg0BZhBmD9RudJsy7sWlfmk42Qv8=
Received: by 10.67.91.6 with SMTP id t6mr5576032ugl;
        Sun, 22 Oct 2006 07:51:13 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e33sm1164780ugd.2006.10.22.07.51.13;
        Sun, 22 Oct 2006 07:51:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29755>

--nextPart21515191.1E9f57hqxU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Git's commit-ish is very powerful.  I was wondering however, if there was a=
=20
shortcut for (for example)?

 git-diff 3435fdb4c^..3435fdb4c

That is - the short range of a particular commit's parent to that commit; l=
ike

 git-diff 3435fdb4c!

Or similar.


Andy
=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart21515191.1E9f57hqxU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFO4TJwQJ9gE9xL20RApowAJ47TYM/4OO8rNys8Qm3ik6xRy3jCACggCpT
ZOZKAg2hQvnS+VcdiKN7JJo=
=wUCk
-----END PGP SIGNATURE-----

--nextPart21515191.1E9f57hqxU--
