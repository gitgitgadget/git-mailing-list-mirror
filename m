From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Sat, 24 Sep 2005 14:59:05 -0700
Message-ID: <7v64squnyu.fsf@assigned-by-dhcp.cox.net>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net>
	<dh0uur$h4g$1@sea.gmane.org> <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
	<20050923205436.GF10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 00:00:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJI3L-0005af-69
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 23:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVIXV7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVIXV7L
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 17:59:11 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59638 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750771AbVIXV7K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 17:59:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924215910.RWBV9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Sep 2005 17:59:10 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050923205436.GF10255@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Sep 2005 22:54:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9251>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Sep 23, 2005 at 10:46:14PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
>> If you pulled from "master" branch, then --version would still
>> say 0.99.7; I agree it is confusing.  On the other hand, I do
>> not think we would want to increment the version string with
>> every little changes, so...
>
> In ELinks, we pseudo-bump the version number from v1.2.3 to v1.2.3.CVS
> (now v1.2.3.GIT) right after the release.

That's a nice way of doing it.  Maybe I should follow suit.
