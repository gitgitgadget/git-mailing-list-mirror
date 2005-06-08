From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-diff-cache: handle pathspec beginning with a dash
Date: Wed, 8 Jun 2005 20:47:09 +0200
Message-ID: <20050608184709.GE982@pasky.ji.cz>
References: <20050606212700.GA3498@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:47:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg5Yq-0000Fo-BH
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 20:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFHSsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 14:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVFHSsw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 14:48:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37599 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261505AbVFHSrP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 14:47:15 -0400
Received: (qmail 5186 invoked by uid 2001); 8 Jun 2005 18:47:09 -0000
To: Jonas Fonseca <fonseca@diku.dk>, torvalds@osdl.org
Content-Disposition: inline
In-Reply-To: <20050606212700.GA3498@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jun 06, 2005 at 11:27:00PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Parse everything after '--' as tree name or pathspec.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

Thanks, applied to git-pb. Linus, any particular reason for holding this
off?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
