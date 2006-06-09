From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Failed git commands and StGIT
Date: Fri, 9 Jun 2006 23:25:29 +0200
Message-ID: <20060609212529.GL11941@pasky.or.cz>
References: <20060609183623.GJ11941@pasky.or.cz> <b0943d9e0606091405o79002a79id02e8fdd3936a345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 23:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FooTg-0004mV-Sm
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbWFIVZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWFIVZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:25:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5853 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030517AbWFIVZH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 17:25:07 -0400
Received: (qmail 24079 invoked by uid 2001); 9 Jun 2006 23:25:29 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0606091405o79002a79id02e8fdd3936a345@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21562>

Dear diary, on Fri, Jun 09, 2006 at 11:05:47PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> said that...
> I also found this annoying but I was too lazy to fix it. To not
> capture the stderr is easy (just change pass false as the 2nd argument
> to popen2.Popen3) but there is a duplicate of error messages from both
> GIT and StGIT. The other option is to add a '--verbose' option to most
> of the commands. I'll have a look at it this weekend.

  I don't think this is actually an issue. I'd actually prefer the
behaviour of NOT having to add a '--verbose' option to a stgit command
to see the full error output.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
