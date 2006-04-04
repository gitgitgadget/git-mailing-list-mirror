From: Petr Baudis <pasky@suse.cz>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Tue, 4 Apr 2006 12:00:35 +0200
Message-ID: <20060404100035.GM27689@pasky.or.cz>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net> <20060403180929.GA14967@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Daniel Drake <dsd@gentoo.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 12:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQiKP-0007Mz-Rd
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 12:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWDDJ76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 05:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWDDJ76
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 05:59:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38063 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964925AbWDDJ76 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 05:59:58 -0400
Received: (qmail 2673 invoked by uid 2001); 4 Apr 2006 12:00:35 +0200
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20060403180929.GA14967@reactrix.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18383>

Dear diary, on Mon, Apr 03, 2006 at 08:09:30PM CEST, I got a letter
where Nick Hengeveld <nickh@reactrix.com> said that...
> Long term, this could give a repo admin the choice of either making sure
> git-update-server-info has been run after every ref/pack change or
> enabling DAV once.  Assuming they need to use HTTP.

Well, what is the actual advantage of DAV compared to
git-update-server-info? Why would I prefer enabling DAV?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
