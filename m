From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 22:54:36 +0200
Message-ID: <20050923205436.GF10255@pasky.or.cz>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net> <dh0uur$h4g$1@sea.gmane.org> <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 22:55:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIuZ7-0005Re-QE
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 22:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVIWUyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 16:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVIWUyj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 16:54:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25796 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751264AbVIWUyi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 16:54:38 -0400
Received: (qmail 22289 invoked by uid 2001); 23 Sep 2005 22:54:36 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9203>

Dear diary, on Fri, Sep 23, 2005 at 10:46:14PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> If you pulled from "master" branch, then --version would still
> say 0.99.7; I agree it is confusing.  On the other hand, I do
> not think we would want to increment the version string with
> every little changes, so...

In ELinks, we pseudo-bump the version number from v1.2.3 to v1.2.3.CVS
(now v1.2.3.GIT) right after the release.

In Cogito, we append the commit ID current at the time of build to
cg-version output (if it was built from GIT-tracked working directory).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
