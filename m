From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Summer of Code 2008 project application draft: Pack v4
Date: Mon, 31 Mar 2008 13:06:48 +0200
Message-ID: <20080331110648.GA26579@bohr.gbar.dtu.dk>
References: <20080329205046.GA27926@bohr.gbar.dtu.dk> <20080331041217.GE10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 13:07:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgHrR-0003PE-LK
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 13:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYCaLGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 07:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYCaLGv
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 07:06:51 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:42006 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752372AbYCaLGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 07:06:51 -0400
Received: (qmail 8121 invoked by uid 5842); 31 Mar 2008 13:06:48 +0200
Content-Disposition: inline
In-Reply-To: <20080331041217.GE10274@spearce.org>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78580>

On Mon, Mar 31, 2008 at 12:12:17AM -0400, Shawn O. Pearce wrote:
> Peter Eriksen <s022018@student.dtu.dk> wrote:
> > Here is a draft of my application for the Google Summer of Code 2008.
> ...
> > The project goal is to rebase the code and ideas developed for the
> > version 4 of the git pack format, which showed good promise of making
> > packs smaller, and faster.
> 
> Have you had a chance to look at those patches yet?

Yes, more than a year ago, see e.g. 
http://thread.gmane.org/gmane.comp.version-control.git/43016
but I will need to refresh my memory.

> Or the code that they touch, but which has been heavily modified
> since then (like say builtin-pack-objects.c)?

No, I am not yet too familiar with all the newest changes. I obviously
would need to read that code carefully.

> I would hope that forward-porting those patches would only take
> us through to about the mid-term, and then finishing out the bulk
> of the series (like commit dict encoding, maybe dict of object ids
> used in trees) would be the remainder of the summer.  But that may
> be aggressive.

I will think a bit about this, and try to make a time line.

> To be successful I think the student working on
> this project needs to spend some time during the bonding period to
> understand the current pack v2 format and how the pack v4 format
> was going to address some of the shortcomings of v2.

Yes, since I basic understanding of the pack formats some time ago, it
should be possible to get up to speed fairly quickly in the bonding
period.

> To some extent I have left the design details about pack v4 off
> the ideas page hoping to draw students into explaining their own
> ideas for how to improve upon Git's pack data storage.

This would be nice of course, but my time is quite limited at the
moment, so this will not be possible for me yet. The reason why I
would like to participate this year is because my summer vacation this
year will be much earlier, and will fit very well into the GSoC window.

Thank you for comments.

Peter
