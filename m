From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 0/4] Minor git-daemon enhancements
Date: Sat, 24 Sep 2005 16:12:54 +0200
Message-ID: <20050924141254.8423.80265.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:14:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJAmH-0002Hw-9I
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 16:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVIXOM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 10:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVIXOM4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 10:12:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2500 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750754AbVIXOMz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 10:12:55 -0400
Received: (qmail 8427 invoked from network); 24 Sep 2005 16:12:54 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 16:12:54 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9232>

The following series contains some minor git-daemon enhancements,
based on the input from the mailing list.

And I'm also playing with StGIT. ;-)

-- 
And on the eigth day, God started debugging.
