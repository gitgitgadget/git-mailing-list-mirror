From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3] Remotes library, take 3
Date: Fri, 11 May 2007 22:39:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705112234520.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 04:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmhW4-0001b6-9P
	for gcvg-git@gmane.org; Sat, 12 May 2007 04:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760994AbXELCjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 22:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760982AbXELCjV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 22:39:21 -0400
Received: from iabervon.org ([66.92.72.58]:3646 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760660AbXELCjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 22:39:20 -0400
Received: (qmail 6071 invoked by uid 1000); 12 May 2007 02:39:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 02:39:19 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47015>

This series is the same as the previous version, except that it matches 
the current behavior of builtin-push with respect to treating names as 
literal URIs.

	-Daniel
*This .sig left intentionally blank*
