From: Marc Singer <elf@buici.com>
Subject: Re: git clone rsync:... ?
Date: Mon, 11 Jul 2005 15:41:45 -0700
Message-ID: <20050711224144.GA24278@buici.com>
References: <20050711213050.GA18693@buici.com> <7v4qb1ouwk.fsf@assigned-by-dhcp.cox.net> <20050711222112.GA21248@buici.com> <7vwtnxnf5m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:46:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds71c-0000VW-KE
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVGKWor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVGKWmr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 18:42:47 -0400
Received: from florence.buici.com ([206.124.142.26]:25239 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261638AbVGKWlq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 18:41:46 -0400
Received: (qmail 27312 invoked by uid 1000); 11 Jul 2005 22:41:45 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtnxnf5m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2005 at 03:36:53PM -0700, Junio C Hamano wrote:
> Marc Singer <elf@buici.com> writes:
> 
> > Looks like something's borked.
> 
> Cogito I slurped about half hour ago has a quite different
> git-clone-script from your 4-line version.  It is not surprising
> "git clone -l" would not work with it ;-).
> 
> I just checked.  Are you using Cogito 0.12 by any chance?

I pulled cogito from the repo.

> Unfortunately it is ancient in this area.  Selected diffstat
> between 0.12 and Pasky head I think relevant is this:
> 
>  git-clone-script                       |   97 ++++

OK.  Let's take another step backward.  There are lots of changes
being made to all of these tools.  Where should I be getting my git
programs so that I've got a good chance that they'll work.  Jeff's
instructions, I believe, are already out-of-date.
