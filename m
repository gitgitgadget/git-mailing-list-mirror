From: Kyle Rose <krose@krose.org>
Subject: [OT] Re: C++ *for Git*
Date: Sat, 22 Sep 2007 14:25:07 -0400
Organization: The Valley of Wind
Message-ID: <46F55E03.2040404@krose.org>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>	<46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 20:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ9fJ-0004UL-7R
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 20:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbXIVSZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbXIVSZK
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 14:25:10 -0400
Received: from kai.krose.org ([140.186.190.96]:52891 "EHLO kai.krose.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbXIVSZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 14:25:09 -0400
Received: from [192.168.33.7] (nausicaa.valley-of-wind.krose.org [192.168.33.7])
	by kai.krose.org (Postfix) with ESMTP id 0A6C02AEC0C5;
	Sat, 22 Sep 2007 14:25:33 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070802)
In-Reply-To: <877imishdp.fsf@catnip.gol.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58938>

Miles Bader wrote:
> Of course, some of the most horrid unreadable source code I've ever seen
> is in one of git's competitors -- written in python....

Indeed. :-)

At the office, people constantly badmouth Perl, which has some
admittedly evil syntax (especially around exception handling).  My view
is that good Perl programmers can produce good, readable, maintainable
Perl programs, while bad Perl programmers can produce spaghetti the
likes of which can't be found outside Italy.

OTOH, I think it is much harder to hang one's self with Python, though
admittedly possible, as it is when you combine a bad coder with *any*
language.  Still, typical bad programmer + Perl is much worse than
typical bad programmer + Python.

C++ is in the same category as Perl IMO: too easy to produce unreadable
code.  I contend that C is pretty much just as bad, though in a
different way: while C lacks C++'s ability to bury code in multiple
layers of opaque abstractions, C makes up for it by providing absolutely
no GC-type structures (i.e., I do this now, you clean it up later when
I'm no longer interested in it).  C is all explicit, which is nice when
you have a good handle on everything that is going on *or* an explicit
system for remembering to do those types of cleanup tasks that is
well-understood by all developers involved.

I like Ruby, except for the performance problems.  Once they have those
worked out, Ruby will be "Perl done right." ;-)

Kyle
