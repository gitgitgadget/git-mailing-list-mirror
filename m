From: David Brown <git@davidb.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 08:56:08 -0700
Message-ID: <20071016155608.GA10603@old.davidb.org>
References: <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andreas Ericsson <ae@op5.se>, barkalow@iabervon.org,
	raa.lkml@gmail.com, Johannes.Schindelin@gmx.de,
	tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhomX-0001Qx-4n
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750AbXJPP4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933684AbXJPP4W
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:56:22 -0400
Received: from mail.davidb.org ([66.93.32.219]:54586 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933371AbXJPP4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 11:56:21 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1Ihom8-0002my-V3; Tue, 16 Oct 2007 08:56:08 -0700
Mail-Followup-To: Eli Zaretskii <eliz@gnu.org>,
	Andreas Ericsson <ae@op5.se>, barkalow@iabervon.org,
	raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
Content-Disposition: inline
In-Reply-To: <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61201>

On Tue, Oct 16, 2007 at 02:25:21AM -0400, Eli Zaretskii wrote:

>On the other hand, what packages have 100K files?  If there's only one
>-- the Linux kernel -- then I think this kind of performance is for
>all practical purposes unimportant on Windows, because while it is
>reasonable to assume that someone would like to use git on Windows,
>assuming that someone will develop the Linux kernel on Windows is --
>how should I put it -- _really_ far-fetched ;-)

Oh, I wish others could think this clearly.  Quoting a serious line off of
a task list at an unnamed company:

   - Make Linux kernel compile under windows.

I don't think it will move past just being a wish list item, but there seem
to be people that think it should be done.

Admittedly, they don't want developers doing it on windows, but want to
integrate kernel building into a windows-heavy build and release process.

David
