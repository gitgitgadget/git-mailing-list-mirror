From: Petr Baudis <pasky@suse.cz>
Subject: git daemon usage
Date: Fri, 12 Aug 2005 02:13:39 +0200
Message-ID: <20050812001339.GL25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 12 02:14:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3NBr-0005s5-V3
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 02:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVHLANm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 20:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVHLANm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 20:13:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1804 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932328AbVHLANl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 20:13:41 -0400
Received: (qmail 10201 invoked by uid 2001); 12 Aug 2005 00:13:39 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  is anyone actually using the git daemon in practice, now that the
other transfer methods can deal with packs? I ask since I wonder if I
should actually bother with adding support for it to cg-pull.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
