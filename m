From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Small, simple and obvious cleanups (are they wanted at this stage?)
Date: Sun, 5 Jun 2005 22:34:22 +0200
Message-ID: <20050605203422.GP17462@pasky.ji.cz>
References: <429E0B08.5040603@gkhs.net> <20050605202527.GO17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 22:31:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df1lz-0006A3-F3
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 22:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVFEUe2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 16:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVFEUe2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 16:34:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23969 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261608AbVFEUeZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 16:34:25 -0400
Received: (qmail 25983 invoked by uid 2001); 5 Jun 2005 20:34:22 -0000
To: "C. Cooke" <ccooke@gkhs.net>
Content-Disposition: inline
In-Reply-To: <20050605202527.GO17462@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jun 05, 2005 at 10:25:27PM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> Dear diary, on Wed, Jun 01, 2005 at 09:22:48PM CEST, I got a letter
> where "C. Cooke" <ccooke@gkhs.net> told me that...
> > This is a simple example - giving a nice error if you're in the wrong
> > directory.
> > 
> > Is this sort of patch wanted? If so, I'm sure I can spare the time to
> > look into some polishing.
> 
> Of course they are wanted. Thanks, applied.

Ok, another thing I forgot to mention - I moved it to cg-Xlib so that
it's checked everytime you run a command, unless the command says it
does need a repository in order to run successfully (that's the case for
cg-clone, cg-init and cg-help).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
