From: Theodore Tso <tytso@mit.edu>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 23:00:09 -0400
Message-ID: <20090613030009.GF24336@mit.edu>
References: <20090612084207.6117@nanako3.lavabit.com> <20090612175105.GD6417@mit.edu> <7vfxe52bk3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 05:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFJTs-0003eW-C6
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 05:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZFMDAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 23:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZFMDAS
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 23:00:18 -0400
Received: from thunk.org ([69.25.196.29]:55040 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbZFMDAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 23:00:17 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MFJTY-0004o0-4J; Fri, 12 Jun 2009 23:00:12 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MFJTV-0001Kg-O2; Fri, 12 Jun 2009 23:00:09 -0400
Content-Disposition: inline
In-Reply-To: <7vfxe52bk3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121480>

On Fri, Jun 12, 2009 at 05:59:40PM -0700, Junio C Hamano wrote:
> >
> > E2fsprogs uses the DCO convetion as well.
> 
> True; I do not know if it counts as "other than the Kernel project"
> in the original question, though.

It depends on how you define "the Kernel project", I suppose.
E2fsprogs is built on a wide variety of platforms, including the GNU
Hurd, FreeBSD, Solaris, and others.  So is it part of the "[Linux]
Kernel project"?

I suppose util-linux-ng might be a closer call (it also uses the DCO
convention) as it is pretty well Linux-specific.  The developer
community of util-linux-ng is primarily not composed of kernel
developers, however, although there is some overlap.

BTW, some of the X.org git repositories also seem to be using DCO,
although its usage seems to be a bit spotty.

					- Ted
