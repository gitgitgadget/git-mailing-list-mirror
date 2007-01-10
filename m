From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Tue, 9 Jan 2007 23:15:17 -0500
Message-ID: <20070110041517.GC25265@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org> <20070108140305.GE32756@thunk.org> <20070109024125.GD1686@fieldses.org> <45A3564E.7080003@op5.se> <20070109165828.GB9153@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 05:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Us6-0002Ov-1r
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 05:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbXAJEPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 23:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbXAJEPW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 23:15:22 -0500
Received: from mail.fieldses.org ([66.93.2.214]:58229 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932718AbXAJEPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 23:15:22 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4Urt-00022i-Nc; Tue, 09 Jan 2007 23:15:17 -0500
To: Theodore Tso <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20070109165828.GB9153@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36476>

On Tue, Jan 09, 2007 at 11:58:28AM -0500, Theodore Tso wrote:
> If what we're going to do is a "git user's manual", I'd recommend
> keeping the 2-3 pages in the manual, and do it via a link to some
> other document.  One of the issues with the git documentation is that
> it's *too* branchy, and some the branches go off to some truly scary
> low-level implementation detail.  If we are going to assume that isn't
> going to change (and I am glad that the low-level details are
> documented, and am not advocating that they be deleted), then keeping
> a user-friendly QuickStart in the main document might not be a bad
> decision.

Sounds reasonable.

I'll probably set this aside a few days, then do some more work on it
this weekend.  (Patches welcomed, though--source is in the master branch
of git://linux-nfs.org/~bfields/git.git.)

--b.
