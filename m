From: Petr Baudis <pasky@suse.cz>
Subject: Re: Proposed script: cg-info
Date: Tue, 5 Jul 2005 11:22:28 +0200
Message-ID: <20050705092228.GC6191@pasky.ji.cz>
References: <1120542372.17286.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 05 11:23:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpjeA-0006vu-Ki
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 11:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVGEJWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 05:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVGEJWw
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 05:22:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32441 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261770AbVGEJWa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 05:22:30 -0400
Received: (qmail 13976 invoked by uid 2001); 5 Jul 2005 09:22:28 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1120542372.17286.7.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 05, 2005 at 07:46:12AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> It would be useful to have a script to display current status of the
> repository - branches, current branch and merge status.  Maybe I'm
> missing something, but I don't see such script.
> 
> I wrote a script that would do that.  I'm still not fully familiar with
> the concepts of cogito, so maybe wrong terms are used in the script.  I
> just want to offer this scripts as a base for further work.
> 
> cg-info sounds very pretentious, so maybe the script should be renamed
> to cg-heads-ls or cg-admin-status or something like that.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>

thanks. I've somewhat cleaned it up and added some more information to
show, and committed it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
