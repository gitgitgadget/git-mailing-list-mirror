From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Couple of read-tree questions
Date: Thu, 1 Sep 2005 00:17:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 06:15:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAgST-0007f2-16
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 06:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVIAENe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 00:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVIAENe
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 00:13:34 -0400
Received: from iabervon.org ([66.92.72.58]:38148 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932074AbVIAENd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 00:13:33 -0400
Received: (qmail 9243 invoked by uid 1000); 1 Sep 2005 00:17:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Sep 2005 00:17:18 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7989>

Is there any current use for read-tree with multiple trees without -m or 
equivalent?

Why does --emu23 use I+H for stage 2, rather than just I? Wouldn't this 
just reintroduce removed files?

	-Daniel
*This .sig left intentionally blank*
