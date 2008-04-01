From: "J.H." <warthog9@kernel.org>
Subject: Kernel.org Downtime Notice - Please read *very* important
Date: Tue, 01 Apr 2008 01:01:17 +0000
Message-ID: <47F1895D.7090509@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ftpadmin@kernel.org, mirror-list-d@redhat.com, suse-mirror@suse.de,
	centos-mirror@centos.org, mirror-list@redhat.com, hands@isc.org,
	support@osuosl.org, git@vger.kernel.org
To: users@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 03:40:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgVUV-00075W-MH
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 03:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYDABkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 21:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYDABkA
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 21:40:00 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:41877 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYDABj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 21:39:59 -0400
X-Greylist: delayed 2167 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 21:39:59 EDT
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m3111HvL002166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Mar 2008 18:01:17 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/6520/Mon Mar 31 17:31:38 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78615>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Afternoon everyone,

I and the other Kernel.org admins would like to announce downtime for
ALL kernel.org machines (this includes all of the mirror machines, the
public machines and the backend master).  The downtime is scheduled to
start on or around April 2nd, 2008 on or around 0001 UTC.

After much deliberation, research and argument in #korg (along with
screaming matches between HPA and I over dinner) we are upgrading the
kernel.org machines from Fedora Core 5 to FreeBSD 7.0.  This decision
does not come lightly to the Kernel.org admins, and we would like to
point out several key things that helped us form our decision:

FreeBSD 7.0 Bests Linux in SMP Performance:
	http://bsd.slashdot.org/article.pl?sid=08/03/06/1313218
	http://people.freebsd.org/~kris/scaling/7.0%20Preview.pdf

FreeBSD vs. Linux vs. Windows 2000
	http://www.freebsd.org/maketing/os-comparison.html

We feel that we can better serve our mirrors, our users and the
community by making the switch, and we hope to have the transition done
very shortly.

- - John 'Warthog9' Hawley
Kernel.org Admin



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFH8Ylc/E3kyWU9dicRAq9bAJ9h2lMO7abuLyhMQFsimqLVGGpcYgCfa4x1
xHRv2IOLKqMv3Ntmx5jentc=
=pjFh
-----END PGP SIGNATURE-----
