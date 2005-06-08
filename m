From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Anal retentive 'const unsigned char *sha1'
Date: Wed, 8 Jun 2005 20:52:19 +0200
Message-ID: <20050608185219.GG982@pasky.ji.cz>
References: <20050603150539.GA3239@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason McMullan <jason.mcmullan@timesys.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg5bK-0000mI-QM
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFHSwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 14:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFHSwY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 14:52:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44767 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261520AbVFHSwU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 14:52:20 -0400
Received: (qmail 6373 invoked by uid 2001); 8 Jun 2005 18:52:19 -0000
To: torvalds@osdl.org
Content-Disposition: inline
In-Reply-To: <20050603150539.GA3239@jmcmullan.timesys>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jun 03, 2005 at 05:05:39PM CEST, I got a letter
where Jason McMullan <jason.mcmullan@timesys.com> told me that...
> Anal Retentive: make 'sha1' parameters const where possible
> 
> Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

This seems as a generally Good Thing (tm). const is nice, isn't it?
Any particular reason for not applying it?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
