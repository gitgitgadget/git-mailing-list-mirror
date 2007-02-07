From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 23:45:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702062337090.20138@iabervon.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
 <20070206164441.GA4949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 05:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEegN-0005jA-KP
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 05:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965634AbXBGEpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 23:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965639AbXBGEpR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 23:45:17 -0500
Received: from iabervon.org ([66.92.72.58]:1356 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965634AbXBGEpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 23:45:16 -0500
Received: (qmail 27930 invoked by uid 1000); 6 Feb 2007 23:45:14 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2007 23:45:14 -0500
In-Reply-To: <20070206164441.GA4949@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38887>

On Tue, 6 Feb 2007, Shawn O. Pearce wrote:

> What about this language?
> 
> 	The time of the change is specified by `<time>` as the number of
> 	seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> 	written in base-10 notation using US-ASCII digits.  The committer's
> 	timezone is specified by `<tz>` as a positive or negative offset
> 	from UTC.  For example EST (which is typically 5 hours behind GMT)
> 	would be expressed in `<tz>` by ``-0500'' while GMT is ``+0000''.

EST is always 5 hours behind GMT. During the summer, EST is still 5 hours 
behind GMT, but the clocks which use ET are set to EDT (-0400) instead. 

	-Daniel
*This .sig left intentionally blank*
