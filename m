From: Petr Baudis <pasky@suse.cz>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 14:09:40 +0100
Message-ID: <20060119130940.GC28365@pasky.or.cz>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com> <cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <cda58cb80601190251v5251c8bdh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 14:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZWa-0007wc-IE
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 14:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWASNIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 08:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWASNIV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 08:08:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51396 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751401AbWASNIV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 08:08:21 -0500
Received: (qmail 23177 invoked by uid 2001); 19 Jan 2006 14:09:40 +0100
To: Franck <vagabon.xyz@gmail.com>
Content-Disposition: inline
In-Reply-To: <cda58cb80601190251v5251c8bdh@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14905>

Dear diary, on Thu, Jan 19, 2006 at 11:51:22AM CET, I got a letter
where Franck <vagabon.xyz@gmail.com> said that...
> well, dealing with a repo that has more than 300,000 objects becomes a
> burden. A lots of git commands are slow, and cloning it take a while !

Were the objects packed? It would be interesting to have some data about
how GIT performs with that much objects...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
