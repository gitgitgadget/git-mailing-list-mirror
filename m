From: Petr Baudis <pasky@suse.cz>
Subject: Re: repo.or.cz renovated
Date: Mon, 17 Mar 2008 20:25:28 +0100
Message-ID: <20080317192528.GE10335@machine.or.cz>
References: <20080313231413.27966.3383.stgit@rover> <m3ve3nwtl3.fsf@localhost.localdomain> <20080317181015.GC10335@machine.or.cz> <7vhcf5b21n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbKyi-0000iu-L9
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 20:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbYCQTZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYCQTZb
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 15:25:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49446 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbYCQTZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 15:25:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 00B80204C053; Mon, 17 Mar 2008 20:25:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhcf5b21n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77457>

On Mon, Mar 17, 2008 at 12:09:24PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > My current plan is to have a [Search project] box at the front page,
> > together with direct link to 'show all'. Other than that, what makes
> > sense to display on the front page? I think recently added projects (age
> > < 1 week) for sure. I'm not so sure about recently changed projects -
> > maybe it is better to keep the front page cruft-free.
> 
> "More important projects"?
> 
> ;-) Ducks...

I'm all for that, get access to projects people are the most likely to
look for. Would it make sense to count accesses to index pages of each
project and then sort by that? Or sort by some activity index?

> How about asking project owners to categorize (tag) their own projects and
> show them in different categories?  Maybe many of them will start in
> "unsorted bin", but if you organize the top page in such a way that the
> link to unsorted bin is much less prominent than nicely sorted ones, that
> may give people incentive to put their project in a real category.

Actually, no reason to restrict tagging to project owners. This might be
interesting, but again the question is, does anyone really want to
browse the project list based on "show me all kernel-related projects"
or "show me all xorg-related projects", especially as we have forks and
it may not be reliable?

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
