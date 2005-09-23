From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 22:55:58 +0200
Message-ID: <20050923205558.GG10255@pasky.or.cz>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net> <dh0uur$h4g$1@sea.gmane.org> <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net> <20050923205242.GY27375@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, walt <wa1ter@myrealbox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 22:57:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIuaU-0005pB-0q
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 22:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVIWU4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 16:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVIWU4A
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 16:56:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27588 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751278AbVIWU4A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 16:56:00 -0400
Received: (qmail 22520 invoked by uid 2001); 23 Sep 2005 22:55:58 +0200
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20050923205242.GY27375@ca-server1.us.oracle.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9204>

Dear diary, on Fri, Sep 23, 2005 at 10:52:42PM CEST, I got a letter
where Joel Becker <Joel.Becker@oracle.com> told me that...
> On Fri, Sep 23, 2005 at 01:46:14PM -0700, Junio C Hamano wrote:
> > If you pulled from "master" branch, then --version would still
> > say 0.99.7; I agree it is confusing.  On the other hand, I do
> > not think we would want to increment the version string with
> > every little changes, so...
> 
> 	Every little change, no.  But ANNOUNCEd releases should be
> considered 'major' from this point of view.  I don't think a little
> extra version number incrementing is too big a deal.

The point is that the bugfix releases aren't tagged on the master branch
but on the maint branch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
