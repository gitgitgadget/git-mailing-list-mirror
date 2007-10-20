From: Simon Hausmann <simon@lst.de>
Subject: git-p4 pull request
Date: Sat, 20 Oct 2007 17:17:50 +0200
Message-ID: <200710201717.54604.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1561638.hBs7vqTY69";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Pettitt <cpettitt@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 17:18:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjG5S-0000TF-Kh
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 17:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbXJTPRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 11:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755546AbXJTPRu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 11:17:50 -0400
Received: from esparsett.troll.no ([62.70.27.18]:33232 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbXJTPRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 11:17:49 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 5D90C7422D; Sat, 20 Oct 2007 17:17:46 +0200 (CEST)
Received: from luria.local (unknown [172.20.1.59])
	by esparsett.troll.no (Postfix) with ESMTP
	id E983C741E9; Sat, 20 Oct 2007 17:17:45 +0200 (CEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61840>

--nextPart1561638.hBs7vqTY69
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The following changes since commit 7840ce6cb24a9d65152d45e08f5d7cf7dc97a2e3:
  Shawn O. Pearce (1):
        Merge branch 'maint'

are available in the git repository at:

  git://repo.or.cz/git/git-p4.git git-p4

Chris Pettitt (1):
      git-p4 support for perforce renames.

Simon Hausmann (1):
      git-p4: When skipping a patch as part of "git-p4 submit" make sure we=
=20
correctly revert to the previous state of the files using "p4 revert".

 contrib/fast-import/git-p4 |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)


These changes fit nicely into master I would say.

Thanks,
Simon

--nextPart1561638.hBs7vqTY69
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHGhwiWXvMThJCpvIRAooSAKCfmXgmqNC2uUge8JmvGX3jK6KoKgCdGo5r
S6q4K+ag897Sa2Z5aIRG/U4=
=1Vhy
-----END PGP SIGNATURE-----

--nextPart1561638.hBs7vqTY69--
