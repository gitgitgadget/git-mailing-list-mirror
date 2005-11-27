From: Petr Baudis <pasky@suse.cz>
Subject: Re: [BUG] cg-mkpatch uses non-portable "tac" command
Date: Sun, 27 Nov 2005 16:08:05 +0100
Message-ID: <20051127150805.GI22159@pasky.or.cz>
References: <86r79ayobj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 16:08:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgO8E-0007HN-3W
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 16:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVK0PHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 10:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVK0PHv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 10:07:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21924 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751087AbVK0PHv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 10:07:51 -0500
Received: (qmail 10402 invoked by uid 2001); 27 Nov 2005 16:08:05 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86r79ayobj.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12811>

Dear diary, on Mon, Nov 21, 2005 at 05:10:08PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> cg-mkpatch uses "tac" to reverse some lines.  This is not a POSIX command.

Thanks, fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
