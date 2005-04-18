From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [pasky] recent changes to gitdiff.sh
Date: Mon, 18 Apr 2005 12:40:38 +0200
Message-ID: <20050418104038.GM1461@pasky.ji.cz>
References: <1113820808.16288.9.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 12:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTca-0002RW-Hs
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVDRKko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVDRKko
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:40:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32419 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262022AbVDRKkk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 06:40:40 -0400
Received: (qmail 32139 invoked by uid 2001); 18 Apr 2005 10:40:39 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113820808.16288.9.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 12:40:08PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Hi,

Hello,

> I see the recent changes to gitdiff.sh requires you to pass -r (git diff
> -r local:$tracking) even if you separate the branches via ':'.  Is this
> intended (seems like it)?

yes. This brings the usage style in sync with the rest of the world. :-)

> If so, then gittrack.sh, gitpull.sh and gitmerge.sh needs to be
> updated ...

I hopes I updated all the places. If I missed anything, please say what.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
