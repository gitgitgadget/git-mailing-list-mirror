From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Rename tracking
Date: Sat, 14 May 2005 18:21:33 +0200
Message-ID: <20050514162133.GW3905@pasky.ji.cz>
References: <7vk6m260xf.fsf@assigned-by-dhcp.cox.net> <20050514151159.GL3905@pasky.ji.cz> <7v4qd523p1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWzOk-0001j8-TA
	for gcvg-git@gmane.org; Sat, 14 May 2005 18:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVENQVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 12:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVENQVu
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 12:21:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44443 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262792AbVENQVf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 12:21:35 -0400
Received: (qmail 22453 invoked by uid 2001); 14 May 2005 16:21:33 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4qd523p1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 06:05:30PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> I'll postpone it for another while since there is still some discussion
> PB> about tuning the output.
> 
> What discussion did I miss???

Mainly

From: Petr Baudis <pasky@ucw.cz>
Date: Sat, 14 May 2005 17:03:56 +0200
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Message-ID: <20050514150356.GK3905@pasky.ji.cz>

> PB> I'm thinking about using "\n---\n\n" in commit message to separate some
> PB> "internal data" like this. cg-log (and web interfaces and other
> PB> toolkits, if we get to agree on something common) could then by default
> PB> hide it. Below it would contain something which we could hopefully embed
> PB> in patches too (actually less work for extracting patches by cg-mkpatch
> PB> or similar tools). What do you think?
> 
> Since I have not been particularly interested in rename tracking
> (because I myself personally have not felt the need for it), I
> do not offhand have much idea worth to offer.  Sorry.

Well, I'd say that with those renaming patches we are feeling the need
for it?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
