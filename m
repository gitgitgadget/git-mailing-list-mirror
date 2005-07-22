From: Petr Baudis <pasky@suse.cz>
Subject: git-pb rebased
Date: Sat, 23 Jul 2005 00:35:35 +0200
Message-ID: <20050722223534.GN11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 23 00:36:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw67R-0006qX-5C
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 00:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVGVWfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVGVWfi
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 18:35:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12553 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261436AbVGVWff (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 18:35:35 -0400
Received: (qmail 5469 invoked by uid 2001); 22 Jul 2005 22:35:35 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I don't expect anyone but myself to actually follow git-pb, but just
in case - I rebased it against the latest Linus' HEAD since its history
was becoming rather dirty, rusty and generally undesirable to merge for
anyone. So if you will try to update, you will end up with tree merge
and you don't want to do that, so

	cat .git/refs/heads/origin >.git/refs/heads/master

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
