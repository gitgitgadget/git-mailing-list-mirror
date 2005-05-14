From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-log gives error on old tags
Date: Sat, 14 May 2005 17:31:58 +0200
Message-ID: <20050514153158.GO3905@pasky.ji.cz>
References: <20050514151157.GB14184@tumblerings.org> <20050514151922.GC14184@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWycS-0005FQ-Jp
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVENPcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVENPcB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:32:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37018 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261416AbVENPb7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:31:59 -0400
Received: (qmail 14291 invoked by uid 2001); 14 May 2005 15:31:58 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050514151922.GC14184@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 05:19:22PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> I should add, I'm fully current with the cogito origin, with Junio's --author
> patch on top.

Hmm, works here. I forgot to update the tags immediately after the big
rehashing, so you could get them from that time and rsync wouldn't
overwrite them. Try deleting them from .git/refs/tags/ and re-pull.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
