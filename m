From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Fix rename/copy when dealing with temporarily broken pairs.
Date: Mon, 13 Jun 2005 19:58:12 +0200
Message-ID: <20050613175812.GA21005@pasky.ji.cz>
References: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net> <7vwtp0p6tz.fsf@assigned-by-dhcp.cox.net> <2cfc4032050613092462d3a456@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 19:54:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dht7x-0007jI-7G
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 19:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFMR6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 13:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFMR6X
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 13:58:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4563 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261165AbVFMR6U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2005 13:58:20 -0400
Received: (qmail 26019 invoked by uid 2001); 13 Jun 2005 17:58:12 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc4032050613092462d3a456@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jun 13, 2005 at 06:24:16PM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> diff --git a/epoch.c b/traversal.c
> similarity index 100%
> rename from epoch.c
> rename to traversal.c
> What tool am I meant to be using to apply the patch? 
> 
> I am currently using "patch -p1"

Try git-apply.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
