From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: Re: [PATCH 3/2] core.whitespace: documentation updates.
Date: Sat, 15 Dec 2007 22:48:33 -0500
Message-ID: <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kV4-0003Cm-Fm
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbXLPDst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758812AbXLPDss
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:48:48 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56275 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756817AbXLPDsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:48:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kUZ-0004Ew-Qx; Sat, 15 Dec 2007 22:48:39 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68431>

I wrote before:
> On Thu, Dec 06, 2007 at 01:04:56AM -0800, Junio C Hamano wrote:
> > "J. Bruce Fields" <bfields@fieldses.org> writes:
> > > OK, I will go wild, but... very slowly.
> >
> > How wild are you these days ;-)?  I know December is a busy time for
> > everybody, and I ended up doing this myself while I was writing up the
> > API documentation for gitattributes.
> 
> Wow, thanks!  Yes, I haven't done a thing on this.
> 
> > -- >8 --
> > [PATCH] Use gitattributes to define per-path whitespace rule
> >  
> > The `core.whitespace` configuration variable allows you to define what
> > `diff` and `apply` should consider whitespace errors for all paths in
> > the project (See gitlink:git-config[1]).  This attribute gives you
> > finer
> > control per path.
> 
> That looks like what I'd hoped for.
> 
> I'll set aside some time this weekend to play around with it.

Erm, well, some weekend anyway.  You can also pull the following from

	git://linux-nfs.org/~bfields/git.git master

if you'd like.

--b.
