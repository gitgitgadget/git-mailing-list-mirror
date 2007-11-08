From: Simon Hausmann <simon@lst.de>
Subject: git-p4 pull request
Date: Thu, 8 Nov 2007 12:55:45 +0100
Message-ID: <200711081255.45838.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1491888.yEvfPhU5RA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Chris Pettitt <cpettitt@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 12:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq5zs-0002MS-Co
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 12:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339AbXKHL4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 06:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757724AbXKHL4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 06:56:16 -0500
Received: from verein.lst.de ([213.95.11.210]:55785 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbXKHL4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 06:56:15 -0500
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id lA8BtpF3011946
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Thu, 8 Nov 2007 12:55:52 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63999>

--nextPart1491888.yEvfPhU5RA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following changes since commit fe61935007b6803ce116e233316e4ff51de02be6:
  Junio C Hamano (1):
        Merge branch 'maint'

are available in the git repository at:

  git://repo.or.cz/git/git-p4.git git-p4

Chris Pettitt (2):
      git-p4: Add a helper function to parse the full git diff-tree output.
      git-p4: Detect changes to executable bit and include them in p4 submit.

 contrib/fast-import/git-p4 |   93 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 89 insertions(+), 4 deletions(-)


Chris implemented support for representing mode changes in git in submits to
Perforce. Fits well into master IMHO.

Thanks,
Simon

--nextPart1491888.yEvfPhU5RA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBHMvlBWXvMThJCpvIRAjO7AJdbLwNGXi16fd8FcRiYdZOz9AJjAJ9YXzgb
hlXHMhvU97mJWYyHBdx+7Q==
=zNAp
-----END PGP SIGNATURE-----

--nextPart1491888.yEvfPhU5RA--
