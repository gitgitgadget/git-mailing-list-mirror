From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sun, 24 Apr 2005 09:14:13 +0200
Message-ID: <20050424071413.GA578@pasky.ji.cz>
References: <20050424005923.GA8859@pasky.ji.cz> <20050423205847.7758bfaa.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 09:09:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPbFK-0007gG-6e
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 09:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVDXHOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 03:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVDXHOT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 03:14:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26559 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262274AbVDXHOP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 03:14:15 -0400
Received: (qmail 1341 invoked by uid 2001); 24 Apr 2005 07:14:13 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050423205847.7758bfaa.pj@sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 05:58:47AM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> What are the exact steps, given that I have an empty chunk
> of diskspace, to get Linux 2.6.12-rc3 to appear there, using
> git.

FWIW, excerpt from the README:

===

If you want to start out new project, do (IN NEW DIRECTORY)

        git init

and if you want to have a look at someone else's project, do

        git init URL

(your working directory will be by default tracking branch 'origin').

===

(although I'm not sure why did I write it when apparently noone bothers
to read it anyway ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
