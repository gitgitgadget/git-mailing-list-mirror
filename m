From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Mar 2007 00:25:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703260023260.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net> <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
 <7vk5x54snc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703251156530.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v648p2cef.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 00:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVb9Z-0000Ld-M4
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 00:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbXCYWZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 18:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbXCYWZb
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 18:25:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:50775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752619AbXCYWZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 18:25:30 -0400
Received: (qmail invoked by alias); 25 Mar 2007 22:25:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 26 Mar 2007 00:25:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tHzJQTAstT+IQPjcT8wLyIR7aiuT/tpFqkt0b8R
	8K+KvGyWalZeZ/
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v648p2cef.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43086>

Hi,

On Sun, 25 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 25 Mar 2007, Junio C Hamano wrote:
> >
> >> * jc/fpl (Tue Mar 13 01:57:22 2007 -0700) 1 commit
> >>  + git-log --first-parent: show only the first parent log
> >> 
> >> This makes viewing topic-heavy style of project history pleasant, at 
> >> least in my opinion.  With a bit of cheering up, I'd merge it to 
> >> 'master', as it has been cooking in 'next' without causing problems, and 
> >> is of low-impact kind.  But it can wait until 1.5.1 is done.
> >
> > *lol* I just tried it on 'next'...
> >
> > But I agree that it is ready to be merged, and that it is useful.
> 
> Hmph.  I am having hard time to decide what to make out of that "*lol*".

I was not sure what to expect, and thus was surprised by _that_ many 
diagonal lines...

But this picture -- unexpected as it was -- makes tons of sense if you are 
interested to see e.g. the history of a topic branch which was merged into 
'next'.

So, I'm all in favour of this feature.

Ciao,
Dscho
