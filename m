From: Shawn Pearce <spearce@spearce.org>
Subject: Re: author/commit counts
Date: Sat, 23 Dec 2006 00:29:29 -0500
Message-ID: <20061223052929.GA9396@spearce.org>
References: <20061222181030.d733deb3.rdunlap@xenotime.net> <7vfyb7usqd.fsf@assigned-by-dhcp.cox.net> <20061222212449.dd5bf939.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:29:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzS0-0004zv-06
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWLWF3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbWLWF3h
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:29:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35318 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbWLWF3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:29:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxzRX-0004Dr-Va; Sat, 23 Dec 2006 00:29:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3213020FB65; Sat, 23 Dec 2006 00:29:30 -0500 (EST)
To: Randy Dunlap <rdunlap@xenotime.net>
Content-Disposition: inline
In-Reply-To: <20061222212449.dd5bf939.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35269>

Randy Dunlap <rdunlap@xenotime.net> wrote:
> Yes, thanks, probably something like that....
> 
> git version 1.4.3.GIT
> 
> > git shortlog -n -s v2.6.19..
> Can't open v2.6.19..: No such file or directory at /usr/local/bin/git-shortlog line 99.

The git-shortlog being discussed is the new builtin shortlog,
which has not been released yet.  Try the 'master' branch in git.git.

-- 
Shawn.
