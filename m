From: Eric Wong <normalperson@yhbt.net>
Subject: [0/2 PATCH] git-svn 1.0.0 release
Date: Fri, 05 May 2006 12:35:38 -0700
Message-ID: <11468577402388-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 05 22:51:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc7Gy-0001mV-AJ
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWEEUvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWEEUvc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:51:32 -0400
Received: from hand.yhbt.net ([66.150.188.102]:10950 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751772AbWEEUvb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 16:51:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EA5AC2DC01A;
	Fri,  5 May 2006 13:51:30 -0700 (PDT)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19644>

It's been very solid for a long time now.  I haven't run into
any problems with it myself in a while, and no critical bugs
that I know of exist.  Labeling it 1.0.0 may make it look
less scary to new users :)

Thanks to all those who gave feedback.

 git-svn.perl |    8 +++++---
 git-svn.txt  |   45 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 14 deletions(-)
