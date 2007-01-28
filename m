From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 19:17:48 -0800
Message-ID: <86mz43hmar.fsf@blue.stonehenge.com>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<20070127201640.GA25637@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701271432450.25027@woody.linux-foundation.org>
	<20070127235238.GA28706@coredump.intra.peff.net>
	<20070128023958.GF9897@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 28 04:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB0YH-0002P1-7w
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 04:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXA1DRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 22:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXA1DRu
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 22:17:50 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:26260 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371AbXA1DRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 22:17:49 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B24A31DEAF3; Sat, 27 Jan 2007 19:17:48 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.5; tzolkin = 7 Chicchan; haab = 18 Muan
In-Reply-To: <20070128023958.GF9897@thunk.org> (Theodore Tso's message of "Sat, 27 Jan 2007 21:39:58 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38015>

>>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:

Theodore> For emacs users, it would even be better to tie it into emacs.  That
Theodore> way you're already at the line number looking at the source code
Theodore> when you start wondering, "who the f*ck created this mess?".  The
Theodore> way I'd design it would to have emacs split the window vertically,
Theodore> and place the blame information in a buffer whose scrolling was
Theodore> synchronized with the main window.

vc-annotate can do the window already, although not the rest.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
