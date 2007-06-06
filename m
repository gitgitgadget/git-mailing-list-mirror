From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: git-svn error msg
Date: Wed, 6 Jun 2007 16:09:46 +0200
Message-ID: <008601c7a844$56dc5030$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 16:24:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvwR8-0002kO-TW
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 16:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXFFOY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 10:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbXFFOY0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 10:24:26 -0400
Received: from mail.transmode.se ([83.241.175.147]:30183 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750906AbXFFOY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 10:24:26 -0400
X-Greylist: delayed 861 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2007 10:24:26 EDT
Received: from Jocke ([84.217.92.176]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 6 Jun 2007 16:09:59 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AceoRFZDWZo+0clISdWEBNkvPxol9Q==
X-OriginalArrivalTime: 06 Jun 2007 14:09:59.0243 (UTC) FILETIME=[5E0BE9B0:01C7A844]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49289>

  git-svn init file:///usr/local/src/tst-git-svn/svn-uboot-repo/
and then
  git-svn fetch yields lots of:
Use of uninitialized value in substitution (s///) at /usr/bin/git-svn line 2144.
Use of uninitialized value in substitution (s///) at /usr/bin/git-svn line 2144.
....

seems to work though.

git version - 1.5.1.3
