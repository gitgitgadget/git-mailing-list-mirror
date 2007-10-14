From: Jeff King <peff@peff.net>
Subject: Re: Imports without Tariffs
Date: Sun, 14 Oct 2007 12:40:01 -0400
Message-ID: <20071014164001.GC27595@sigill.intra.peff.net>
References: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu> <20071013040712.GA27227@coredump.intra.peff.net> <1240801C-F4CC-4290-8C3D-2038F1957DF3@MIT.EDU> <20071013075723.GA27533@coredump.intra.peff.net> <814D00AE-B89A-45ED-A500-4643C825D0EB@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6Vi-0003au-Ey
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbXJNQkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbXJNQkE
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:40:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2582 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755920AbXJNQkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:40:03 -0400
Received: (qmail 13647 invoked by uid 111); 14 Oct 2007 16:40:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 14 Oct 2007 12:40:01 -0400
Received: (qmail 27763 invoked by uid 1000); 14 Oct 2007 16:40:01 -0000
Content-Disposition: inline
In-Reply-To: <814D00AE-B89A-45ED-A500-4643C825D0EB@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60867>

On Sat, Oct 13, 2007 at 07:04:52PM -0400, Michael Witten wrote:

> I can make a patch, but at the moment I'm swamped and I don't want to think
> about doing that.
>
> I'll get around to it eventually, I hope.
>
> Do I just submit the patch to this list? How do I know it will be used?

Yes, send a patch to the list and to Junio (the maintainer).  See
Documentation/SubmittingPatches for details.

> Frankly, I don't know how robust my idea is either, but it's simple
> enough not to have many problems lurking in the shadows.
>
> It would certainly be more useful than not.

Then submit a patch implementing it. :)

>> all of the data that goes into the commit hash as textual comments in
>> the CVS commit (committer name/time, author name/time). And then
> I considered this too, but this exposes what we're doing. We don't
> want the old farts to wonder what all these hash thingies are.

Heh. I like the idea of git secretly infiltrating institutions,
replacing CVS unbeknownst to management. It was the same for Linux in
the mid-90's ("our mail server is running on what!?").

-Peff
