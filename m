From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/4] git-svn: more improvements
Date: Fri, 16 Jun 2006 10:57:22 -0700
Message-ID: <11504806463470-git-send-email-normalperson@yhbt.net>
References: <11504049343825-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:57:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIZX-0006j0-2x
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWFPR52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWFPR52
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:57:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:9700 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750954AbWFPR51 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:57:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3A0CB7DC020;
	Fri, 16 Jun 2006 10:57:26 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 16 Jun 2006 10:57:26 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504049343825-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21955>

Another round of patches to git-svn, all depending on previous patches.

I've also setup a pullable repo here for all my latest git-svn stuff:
	git://git.bogomips.org/git-svn.git
	(http:// also works)

-- 
Eric Wong
