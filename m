From: "J.H." <warthog9@kernel.org>
Subject: [KORG] Master backend downtime - hardware swap
Date: Thu, 06 Nov 2008 17:43:40 -0800
Message-ID: <49139D4C.2010004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: users@linux.kernel.org, git@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 03:23:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyH0r-0003Jp-KD
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 03:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbYKGCWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 21:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbYKGCWZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 21:22:25 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:60583 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYKGCWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 21:22:24 -0500
X-Greylist: delayed 2320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Nov 2008 21:22:24 EST
Received: from voot-cruiser.eaglescrag.net (12-210-47-166.client.mchsi.com [12.210.47.166])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id mA71hbV1022888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Nov 2008 17:43:39 -0800
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: ClamAV 0.88.7/8584/Thu Nov  6 14:09:22 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Thu, 06 Nov 2008 17:43:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100280>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey everyone,

Just a heads up to everyone, I'm going to be taking the master (hera)
backend server offline for a couple of hours tomorrow (Friday, CST)
afternoon.  Downtime is going to get used for finishing flipping over
the master to new hardware, which was very generously donated by
Hewlett-Packard.  We are moving up to a new DL380 G5.  That said I will
need time to shut everything down, get a current rsync from the old
hardware to the new hardware and confirm that serves are restored on the
new machine.

I'm expecting the entire downtime to only take a couple of hours, but
since we all know things will take longer I'm going to declare the
window from 1200 CST (1800 UTC Friday Nov 7th).  Expect the window to
run through 2000 UTC, and if things are up and running before that I'll
let people know.  Otherwise if there are problems you'll see another
e-mail from me.

If you have questions, comments, concerns, etc - please send them to me
CC ftpadmin@kernel.org

- - John 'Warthog9' Hawley
Chief Kernel.org Administrator
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFJE51L/E3kyWU9dicRAs8/AJ9DVJjQxcOt9CUVsQYVM6elJkTr2gCePLJ8
+UuEcZdwUpAICFijAXp9ae4=
=c6vs
-----END PGP SIGNATURE-----
