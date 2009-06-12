From: Theodore Tso <tytso@mit.edu>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 13:51:06 -0400
Message-ID: <20090612175105.GD6417@mit.edu>
References: <20090612084207.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFAuN-0002y3-SW
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 19:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZFLRvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 13:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZFLRvI
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 13:51:08 -0400
Received: from THUNK.ORG ([69.25.196.29]:49248 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbZFLRvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 13:51:08 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MFAuB-0002nK-PG; Fri, 12 Jun 2009 13:51:07 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MFAuA-0005pp-23; Fri, 12 Jun 2009 13:51:06 -0400
Content-Disposition: inline
In-Reply-To: <20090612084207.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121437>

On Fri, Jun 12, 2009 at 08:42:07AM +0900, Nanako Shiraishi wrote:
> git provides options and configuration variables to easily handle
> the Signed-off-by tag line. It is used to certify that the sender
> certifies the patch with the Developer's Certificate of Origin.
> 
> I have read SubmittingPatches document and understand this
> convention is used by the Linux Kernel Project.
> 
> I was giving a git introduction to students in my lab, and this
> question came up from one of them. How widely is this convention
> used? Are there projects other than the Linux Kernel and git itself?

E2fsprogs uses the DCO convetion as well.

					- Ted
