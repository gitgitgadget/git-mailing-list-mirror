From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Add -u option to cg-log to show only commits from a specific user
Date: Thu, 12 May 2005 22:23:30 +0200
Message-ID: <20050512202329.GM324@pasky.ji.cz>
References: <1115599773.8949.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:17:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWK6J-0005RJ-2f
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVELUXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVELUXn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:23:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46810 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262081AbVELUXc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 16:23:32 -0400
Received: (qmail 17716 invoked by uid 2001); 12 May 2005 20:23:30 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115599773.8949.90.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 02:49:33AM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> the attached patch introduces the -u option for cg-log. Now you can give
> a username or a part of a username and only commits with a matching
> author or committer will be displayed.
> 
> This patch also changes the option parsing, because otherwise we are
> stuck to a specific order.

I think that one should be in a separate patch.

At any rate, could you please resend the patch(es) signed off?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
