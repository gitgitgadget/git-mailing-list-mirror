From: Frank Sorenson <frank@tuxrocks.com>
Subject: Kernel git tree problem? gitk problem?
Date: Sat, 18 Jun 2005 18:12:44 -0600
Message-ID: <42B4B87C.2000007@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 19 02:07:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjnLJ-0008S0-Ky
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 02:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVFSAMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 20:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVFSAMt
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 20:12:49 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:32016 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262207AbVFSAMr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2005 20:12:47 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j5J0Ci5w003397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 18 Jun 2005 18:12:45 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With the new crop of post-2.6.12 updates, my kernel trees (tested on
several computers, and even with brand-new tree) now give the following
error messages when I run gitk:
ERROR: none of the pending commits can be done yet:
  bd6ae2f6d61da0f90c6b66e9a4ab6c53ef8c159a
  2512809255d018744fe6c2f5e996c83769846c07
  88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
  b3214970abbe983cd89842ae24ea00e21bba79f6

git-fsck-cache doesn't appear to know about any problems.

Is this a gitk problem, or is there something wrong with the tree?

What is a "pending commit?"  Is that a commit that hasn't been
committed, or something? :)

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCtLh8aI0dwg4A47wRAscuAJ4ut87UDbYimUbfxmYT06e1AlNpMwCeIGrA
wgDmnq31zPOcPEZr67BOb4E=
=rdnC
-----END PGP SIGNATURE-----
