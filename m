From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git_progname
Date: Tue, 25 Oct 2005 15:32:08 +0200
Message-ID: <20051025133208.GC30889@pasky.or.cz>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <435DF6DA.6010205@op5.se> <20051025093150.GB30889@pasky.or.cz> <435E1307.3090209@op5.se> <435E2ABA.8030907@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 15:34:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUOuV-0004qv-ML
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 15:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVJYNcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 09:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJYNcM
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 09:32:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27008 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932106AbVJYNcK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 09:32:10 -0400
Received: (qmail 10230 invoked by uid 2001); 25 Oct 2005 15:32:08 +0200
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <435E2ABA.8030907@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10586>

Dear diary, on Tue, Oct 25, 2005 at 02:53:14PM CEST, I got a letter
where Andreas Ericsson <ae@op5.se> told me that...
> Andreas Ericsson wrote:
> >Petr Baudis wrote:
> >>Urgh. Now this is ugly. What about making it a bit more intrusive while
> >>quite more saner?
> >
> >I'm not sure what you're referring to. The one-liner is a one-liner. 
> >It's sort of supposed to be ugly.
> 
> Oh. I saw what you meant now. Lots of main.h included. :)

No, I didn't mean the oneliner at all, actually - just the notion that
you stealthily hijack main(). We'll see what Junio thinks about it. ;)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
