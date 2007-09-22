From: David Kastrup <dak@gnu.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sat, 22 Sep 2007 21:11:51 +0200
Message-ID: <85bqbutszs.fsf@lola.goethe.zz>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	<46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
	<46F55E03.2040404@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 21:12:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZAOY-0000JC-Fj
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 21:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbXIVTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 15:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXIVTL4
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 15:11:56 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:47867 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777AbXIVTLz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Sep 2007 15:11:55 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 1F3FD3028D9;
	Sat, 22 Sep 2007 21:11:54 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 0DD92346AC4;
	Sat, 22 Sep 2007 21:11:54 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-012-197.pools.arcor-ip.net [84.61.12.197])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id D71AD1C36CF;
	Sat, 22 Sep 2007 21:11:53 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 754A41C22919; Sat, 22 Sep 2007 21:11:51 +0200 (CEST)
In-Reply-To: <46F55E03.2040404@krose.org> (Kyle Rose's message of "Sat\, 22 Sep 2007 14\:25\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4359/Sat Sep 22 17:57:21 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58940>

Kyle Rose <krose@krose.org> writes:

> Miles Bader wrote:
>> Of course, some of the most horrid unreadable source code I've ever seen
>> is in one of git's competitors -- written in python....
>
> Indeed. :-)
>
> At the office, people constantly badmouth Perl, which has some
> admittedly evil syntax (especially around exception handling).

Since Perl has agglomerated pretty much _every_ syntax, it is not
surprising that evil syntax is included.

> C++ is in the same category as Perl IMO: too easy to produce
> unreadable code.

Not quite.  Perl gives you a hundred illegible ways to _say_ the same
thing, C++ gives you a hundred illegible ways to _achieve_ the same
thing, but using different means.

> I like Ruby, except for the performance problems.  Once they have
> those worked out, Ruby will be "Perl done right." ;-)

Ruby again is in the "throw every syntactical idiom I can think of
together" ballpark.  I find that a design mistake in Perl, a design
mistake in Ruby, and even in C++ (Ada syntax for templates was just
stupid, but at least there is no alternative syntax for it).

That's one of the things I like about Lua: its syntax fits on one page
in the reference manual.  And the reference manual has a paper size of
about A5.  While the syntax for Lisp would probably fit in the margin,
it does so at a cost in legibility.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
