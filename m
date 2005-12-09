From: linux@horizon.com
Subject: Re: as promised, docs: git for the confused
Date: 9 Dec 2005 09:01:23 -0500
Message-ID: <20051209140123.3234.qmail@science.horizon.com>
References: <20051209094328.GT22159@pasky.or.cz>
Cc: alan@chandlerfamily.org.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 15:03:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekios-0004om-Vg
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 15:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVLIOBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 09:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLIOBc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 09:01:32 -0500
Received: from science.horizon.com ([192.35.100.1]:41019 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751027AbVLIOBb
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 09:01:31 -0500
Received: (qmail 3235 invoked by uid 1000); 9 Dec 2005 09:01:23 -0500
To: linux@horizon.com, pasky@suse.cz
In-Reply-To: <20051209094328.GT22159@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13425>

>   BTW, such a "wide" reply is a bit hard to handle - it might be perhaps
> more practical to make separate replies at least to the mails whose
> contents does not overlap. Also, people would not get Cc's of subthreads
> they are not involved with.

Sorry... it was one edit session while I made all the corrections,
and it was just more natural...

>> Unfortunately, given the number of commands, you can't just document
>> them well individually.  Some overview of how they fit together into
>> a system is required.

> Hmm. Well, actually... what's the point? If I want to get a really quick
> overview, I do
>
>	whatis git
>
> and it will DTRT. But when do I need something more detailed but not yet
> the manual page of the given command?

"I want to do X and Y but not Z.  What commands are worth knowing?"

I have 106 git-* commands available to me (my document covers 105;
I'll have to find the extra), and the biggest question I have is
"how many of those man pages can I get away with NOT reading?"

Heck, that categorized list is what I started out writing, and I happen
to think it's the most important part of the whole document.

The man page tells me HOW to execute a command.  But before I'm ready for
that level of detail, I need to figure out WHICH command to execute.
To be specific, I need to know the terrain just well enough so I can
plan a route from where I am to where I want to be.  Then I can look
into the details of each step.

But without that overview, my trip is going to take me into a lot of dead
ends, because I'm executing commands that I think are getting me closer,
but I have the wrong mental model of what "close" is.

Or perhaps I found one command that sort-of does what I want an
missed the one that works better.


(BTW, don't you mean "whatis -w git\*"?)
