From: Petr Baudis <pasky@suse.cz>
Subject: Re: Remove "historical" objects from repository to save place
Date: Sat, 21 Jan 2006 21:06:15 +0100
Message-ID: <20060121200615.GM28365@pasky.or.cz>
References: <200601212218.51055.arvidjaar@mail.ru> <7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 21:04:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Oyf-0001jX-2P
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWAUUEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWAUUEq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:04:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10890 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932311AbWAUUEq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 15:04:46 -0500
Received: (qmail 3867 invoked by uid 2001); 21 Jan 2006 21:06:15 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15013>

Dear diary, on Sat, Jan 21, 2006 at 08:58:55PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> You might be able to cauterize the history at a specific commit
> and then re-clone.  I've talked about how in "[QUESTION] about
> .git/info/grafts file" thread yesterday, so I won't repeat that.

Shouldn't the git-prune be sufficient after cauterizing the history?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
