From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Improvements for cg and cg-help
Date: Sat, 11 Jun 2005 00:36:16 +0200
Message-ID: <20050610223616.GC22111@pasky.ji.cz>
References: <1118330242.27441.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:32:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgs3H-0004mQ-HK
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 00:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVFJWgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 18:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVFJWgY
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 18:36:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19358 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261303AbVFJWgS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 18:36:18 -0400
Received: (qmail 28312 invoked by uid 2001); 10 Jun 2005 22:36:16 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1118330242.27441.15.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 09, 2005 at 05:17:22PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> cg with any option before the command ("cg -foo cmd") should also run
> cg-help.

it shouldn't.

> cg-help should print help for cg-help if specific help is not available,

it shouldn't, it should report an error.

The rest was applied, thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
