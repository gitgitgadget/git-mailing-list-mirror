From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] git-status: colorize status output
Date: Mon, 7 Aug 2006 19:12:18 +0200
Message-ID: <20060807171218.GB10918@mars.ravnborg.org>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> <20060805112851.GA20807@moooo.ath.cx> <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 07 19:13:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA8ef-0005os-Ms
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 19:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWHGRMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWHGRMj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 13:12:39 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:63910 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932227AbWHGRMi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 13:12:38 -0400
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id 92BF2801942;
	Mon,  7 Aug 2006 19:12:32 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id B7D4143C01F; Mon,  7 Aug 2006 19:12:18 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25019>

> 
> Not that I can think of, but do people really run "git status"?
Always (almost) before I run 'git fetch'.
I do it to check that I have not made any local modifications that I
need to get rid of before fetching and that I do not have stale files
around.

One example is my copy of Linus' kernel tree. I use it now and then for
small experiments (can I reporoduce this bug etc) and when fetching I
want it to be gone.

	Sam
