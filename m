From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Fri, 18 Aug 2006 15:16:57 +0200
Message-ID: <20060818131656.GR13776@pasky.or.cz>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org> <7vk65815h1.fsf@assigned-by-dhcp.cox.net> <87y7tnxv9g.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 15:20:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE4Dg-0004SM-W6
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 15:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWHRNQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 09:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWHRNQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 09:16:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2254 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751294AbWHRNQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 09:16:59 -0400
Received: (qmail 26536 invoked by uid 2001); 18 Aug 2006 15:16:57 +0200
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87y7tnxv9g.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25661>

Dear diary, on Thu, Aug 17, 2006 at 05:00:11PM CEST, I got a letter
where Carl Worth <cworth@cworth.org> said that...
> PS. A secondary problem is the difficulty of publishing a new
> branch. But if I can get the 3 URLs above down to 1, then I could
> probably live with the user having to figure out how to combine the
> repository URL with the branch name, (in different ways depending on
> what the user is doing).

Could you be more specific here, please? Is it just that Git won't
automagically pick up new branches published on the server?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
