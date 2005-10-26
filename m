From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 10:36:58 +0200
Message-ID: <20051026083658.GE30889@pasky.or.cz>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 10:39:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUgmo-0000OK-LU
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVJZIhD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVJZIhC
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:37:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3811 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932598AbVJZIhA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 04:37:00 -0400
Received: (qmail 18796 invoked by uid 2001); 26 Oct 2005 10:36:58 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10653>

Dear diary, on Wed, Oct 26, 2005 at 10:33:33AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> Aargh! I had the impression "expr" was a builtin... Just forget about the 
> patch, okay?

I think that builtin or not, $() will always spawn a subshell. ...?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
