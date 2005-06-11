From: Russ Allbery <rra@stanford.edu>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 09:45:45 -0700
Organization: The Eyrie
Message-ID: <87br6cn8p2.fsf@windlord.stanford.edu>
References: <E1DgodI-0003ov-Fl@highlab.com>
	<7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	<E1DgyW0-0004PE-Ct@highlab.com>
	<2cfc403205061023346c03a25b@mail.gmail.com>
	<87r7f9xsux.fsf@windlord.stanford.edu>
	<7v7jh1xli5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 11 18:41:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh936-0008AP-T7
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVFKQpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVFKQpx
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 12:45:53 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:52637 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261734AbVFKQpr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 12:45:47 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp3.Stanford.EDU (8.12.11/8.12.11) with SMTP id j5BGjjwj019353
	for <git@vger.kernel.org>; Sat, 11 Jun 2005 09:45:46 -0700
Received: (qmail 23259 invoked by uid 1000); 11 Jun 2005 16:45:45 -0000
To: git@vger.kernel.org
In-Reply-To: <7v7jh1xli5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 11 Jun 2005 02:58:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:
>>>>>> "RA" == Russ Allbery <rra@stanford.edu> writes:

> RA> ... it turns out in discussion on the Debian mailing lists
> RA> that people actually do use GIT.

> I thought the Debian way to resolve this kind of naming conflict
> was to rename _both_ commands involved.  Sorry if this was a
> misconception, but I think I read that somewhere in the
> developer's guide.

There are various ways in which you can deal with the problem, but then
you end up making that distribution different possibly than any other and
certainly different than the behavior people get when they build the
package themselves.  Then users ask questions here talking about running
"cogito-git" or the like and developers go "I've never heard of that
program," users try to use recipes off the net and the command isn't
found, etc.

Users of a tool like git are in a better position to figure this sort of
thing out, but it's still rather annoying and frustrating.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
