From: david@davidwbrown.name
Subject: Mercurial over Git no success
Date: Mon, 14 Feb 2011 15:01:45 -0600 (CST)
Message-ID: <1297717305.19327@davidwbrown.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1297717305"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 22:22:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5s1-0007QM-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab1BNVWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:22:04 -0500
Received: from node-65-183-55-42.static.ipglobal.net ([65.183.55.42]:40734
	"EHLO davidwbrown.name" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab1BNVWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:22:03 -0500
X-Greylist: delayed 1215 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Feb 2011 16:22:03 EST
Received: from davidwbrown.name (davidwbrown.name [127.0.0.1])
	by davidwbrown.name (Postfix) with ESMTP id 5308B6F8067
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 15:01:46 -0600 (CST)
Received: (from root@localhost)
	by davidwbrown.name (8.13.8/8.13.8/Submit) id p1EL1ju1019433;
	Mon, 14 Feb 2011 15:01:45 -0600
X-Originating-IP: 208.91.15.170
X-Mailer: Webmin 1.530
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166770>

This is a multi-part message in MIME format.

--bound1297717305
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Gitters, long ago when first starting the project I'm currently running at my company I looked around for a VCS/SCM that would be anywhere better than: CVS/SVN. At first I looked at Git but could not get a version to run on my Ubuntu box. So, I had to settle for Hg. Now, that I'm several months into the web app dev I'm responsible for the hired help has convinced me to switch to Git. Now, I'm back at the same old problem I had months ago that forced me to give up on using Git. Unlike a lot of Unix/Linux based software the usual:

./configure
make
make install

Does not work for building Git on my local Ubuntu box (10.10 BTW). Some non-innocuous error condition as follows:

cannot find zlib.h

Pls advise. David.

--bound1297717305--
