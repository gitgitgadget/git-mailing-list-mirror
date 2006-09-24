From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Git.pm: Kill Git.xs for now
Date: Sun, 24 Sep 2006 14:07:24 +0200
Message-ID: <20060924120724.GB5732@steel.home>
References: <20060923181849.28753.56984.stgit@machine.or.cz> <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net> <20060924105016.GA5732@steel.home> <20060924110816.GK20017@pasky.or.cz> <20060924114834.GA5800@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 14:08:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSm5-00040t-Db
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 14:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIXMHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 08:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWIXMHy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 08:07:54 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:7574 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750708AbWIXMHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 08:07:53 -0400
Received: from fwd28.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1GRSlu-0001Vl-03; Sun, 24 Sep 2006 14:07:46 +0200
Received: from tigra.home (Vgemp6ZYYeRSDx3xUUjdVw0ACj5e-4iIV2OfEdwHfAN+iEB7VM5Cot@[84.160.110.72]) by fwd28.sul.t-online.de
	with esmtp id 1GRSlg-125llA0; Sun, 24 Sep 2006 14:07:32 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id ECA97277AF;
	Sun, 24 Sep 2006 14:07:24 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GRSlY-0001Wx-FW; Sun, 24 Sep 2006 14:07:24 +0200
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060924114834.GA5800@steel.home>
User-Agent: Mutt/1.5.11
X-ID: Vgemp6ZYYeRSDx3xUUjdVw0ACj5e-4iIV2OfEdwHfAN+iEB7VM5Cot
X-TOI-MSGID: 116eca5b-0078-4000-ace2-e8a72707b47e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27663>

Alex Riesen, Sun, Sep 24, 2006 13:48:34 +0200:
> Aside from that, any chance of making Git.xs optional (enabled by
> default, but disableable)? Disabling Git.xs will disable related
> scripts, sure, but also gives you an installation with one external
> (libperl) dependency less (probably with ability to install git and
> Git.xs separately).

I see that was already meantioned. Sorry, just have read the whole
discussion.
