From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 09:27:38 -0700
Message-ID: <86lkcqvtdx.fsf@blue.stonehenge.com>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
	<85ejijgzzg.fsf@lola.goethe.zz>
	<20070805100532.GG12507@coredump.intra.peff.net>
	<85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
	<20070805110200.GA18083@coredump.intra.peff.net>
	<85tzre8b4w.fsf@lola.goethe.zz>
	<20070805115208.GA19734@coredump.intra.peff.net>
	<85fy2y89kb.fsf@lola.goethe.zz> <20070805154801.GD28263@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 18:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHixJ-0003a9-9H
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 18:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbXHEQ1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbXHEQ1l
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 12:27:41 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:12978 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847AbXHEQ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 12:27:38 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3C7DB1DE5A7; Sun,  5 Aug 2007 09:27:38 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.9.15; tzolkin = 2 Men; haab = 3 Yaxkin
In-Reply-To: <20070805154801.GD28263@thunk.org> (Theodore Tso's message of "Sun, 5 Aug 2007 11:48:01 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55038>

>>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:

Theodore> To use a GNU emacs example, consider M-x customize, which is this
Theodore> huge, very fancy, *very* complex hierarchical mechanism with a
Theodore> pointy-clicky interface for setting options.  Most emacs experts
Theodore> wouldn't use it, preferring to open code raw emacs-lisp settings in
Theodore> their .emacs.el.  If you ask an old-time emacs user how to set up
Theodore> some specific feature setting via M-x customize, they might look at
Theodore> you blankly, because it's not an interface they use much, if at all.

I beg to differ.  I *am* an old-time Emacs user, and I resisted customize when
it first appeared, because *most* of the things still didn't use it.  However,
as of a year ago, I assessed that customize had gotten to "critical mass", and
that 75% of my .emacs could be replaced by it.  So I have, and it's made
things simpler for me.

So, it just has to be complete enough and flexible enough.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
