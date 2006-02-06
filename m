From: Petr Baudis <pasky@suse.cz>
Subject: Re: Push or merge certain commitid
Date: Mon, 6 Feb 2006 22:04:50 +0100
Message-ID: <20060206210450.GI31278@pasky.or.cz>
References: <20060206204935.GA20274@guybrush.melee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 06 22:05:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6DXS-0006x7-OG
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 22:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWBFVEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBFVEn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 16:04:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28903 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964828AbWBFVEm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 16:04:42 -0500
Received: (qmail 485 invoked by uid 2001); 6 Feb 2006 22:04:50 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060206204935.GA20274@guybrush.melee>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15660>

  Hello,

  your email address is broken. I'm replying just to the mailing list.

Dear diary, on Mon, Feb 06, 2006 at 09:49:35PM CET, I got a letter
where "Bertrand Jacquin (Beber)" <beber@guybrush.melee> said that...
> I don't know if it's really possible to do but I would like to know if
> there is a way to push or merge just certain commitid specified ?
> I think it can trouble parents, trees, etc, but here I need that.

  As I already said on IRC, you can merge a specified commit by using
the git-cherry-pick(1) command.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
