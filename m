From: Tim Ottinger <tottinge@progeny.com>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 06 Sep 2005 11:42:01 -0500
Message-ID: <431DC6D9.30802@progeny.com>
References: <200509020150.j821oXXM006699@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 18:45:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECgYO-0007wc-6m
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 18:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVIFQnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 12:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIFQno
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 12:43:44 -0400
Received: from zealot.progeny.com ([216.37.46.162]:46526 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1750753AbVIFQno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 12:43:44 -0400
Received: from [192.168.1.95] (inigo.progeny.com [192.168.1.95])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 411EA636A4; Tue,  6 Sep 2005 11:43:43 -0500 (EST)
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509020150.j821oXXM006699@laptop11.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8133>

Horst von Brand wrote:

>Junio C Hamano <junkio@cox.net> wrote:
>  
>
>>Tim Ottinger <tottinge@progeny.com> writes:
>>    
>>
>>>git-update-cache for instance?
>>>I am not sure which 'cache' commands need to be 'index' now.
>>>      
>>>
>>Logically you are right, but I suspect that may not fly well in practice.  Too many of us have already got our fingers wired to type cache, and the glossary is there to describe both cache andindex.
>>    
>>
>
>I'd vote for cleaning it up /now/. Sure, it will hurt, but if you let time
>go by and do it later, it will hurt much more.
>
>Pre-1.0 is the last chance, AFAICS.
>  
>
I guess it all depends on whether your target audience is already using
it an happy with how it is, or whether your target audience is yet to
be reached.

Is git growing? Do we expect to suddenly find git upside down, where
there are a few old-timers awash in a sea of newbies? Do we care?

If you care, and git is growing, then probably it makes sense to
choose "the greatest good for the greatest number", I guess.

Personally, I'm a newbie and I find the command set confusing and
hard to internalize for reasons mostly dealing with naming, but also
because I don't have 6 months shared history with all of you. I have
to learn it partly from docs and partly through folklore gleaned from
the list (which moves pretty quickly).

Maybe that's just complaining, but maybe it is pointing out a
weakness that's correctable.

-- 
                             ><>
... either 'way ahead of the game, or 'way out in left field.
