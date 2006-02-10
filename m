From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 14:07:02 -0800
Message-ID: <7vd5huvpfd.fsf@assigned-by-dhcp.cox.net>
References: <20060210195914.GA1350@spearce.org>
	<20060210211740.GO31278@pasky.or.cz>
	<20060210213818.GB1604@spearce.org>
	<20060210214723.GP31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 23:07:17 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7gQ8-00073h-01
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 23:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWBJWHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 17:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWBJWHF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 17:07:05 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13460 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751384AbWBJWHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 17:07:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210220555.DWBE15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 17:05:55 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060210214723.GP31278@pasky.or.cz> (Petr Baudis's message of
	"Fri, 10 Feb 2006 22:47:23 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15891>

Petr Baudis <pasky@suse.cz> writes:

> On a second thought, this is probably simply caused by the web server
> not reporting 404 on missing files.

I suspect that is it.  The webserver is broken^W not being a
good network citizen.
