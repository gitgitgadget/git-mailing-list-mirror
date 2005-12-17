From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 23:44:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512162342010.3698@g5.osdl.org>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
 <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net> <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
 <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
 <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
 <118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
 <Pine.LNX.4.64.0512161701400.3698@g5.osdl.org> <7vy82kbiho.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 08:45:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnWjl-0002LU-Aw
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 08:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVLQHoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 02:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVLQHoK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 02:44:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932105AbVLQHoI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2005 02:44:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBH7i3DZ028345
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Dec 2005 23:44:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBH7i3gQ031777;
	Fri, 16 Dec 2005 23:44:03 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy82kbiho.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13773>



On Fri, 16 Dec 2005, Junio C Hamano wrote:
> 
> You guys were on BK for how many months, and have been on git
> for how many months now?  Do BK-familiarity factor matter, and
> will it continue to matter for how long?

I don't think it is a huge deal, I suspect that people who used BK have a 
much easier time with git if only because they already understand the 
whole distributed thing and about commits and merges.

That said, I think a lot of newbies might want to have a "git undo", and 
not because of any BK history. Even if it just ends up being nothing but 
shorthand for "git reset --hard ORIG_HEAD".

		Linus
