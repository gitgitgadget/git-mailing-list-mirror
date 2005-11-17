From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/3] Support setting SymrefsOnly=true from scripts
Date: Thu, 17 Nov 2005 13:09:09 +0100
Message-ID: <20051117120909.GA30496@pasky.or.cz>
References: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de> <7vfypxh5mn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511160127130.4334@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xvpe6vi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 17:16:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmKI-0007vc-IB
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVKQQJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVKQQJS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:09:18 -0500
Received: from w241.dkm.cz ([62.24.88.241]:14269 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932353AbVKQQJR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 11:09:17 -0500
Received: (qmail 22258 invoked by uid 2001); 17 Nov 2005 13:09:09 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xvpe6vi.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12127>

Dear diary, on Wed, Nov 16, 2005 at 02:09:05AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - copy the template; if the commandline specifies where the
>    templates are, take them from there otherwise use the
>    built-in location.

The disadvantage is that I will have to maintain my own template for
Cogito, which is silly - I would much rather just use GIT's default
templates and only add the symrefonly option on behalf of Cogito.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
