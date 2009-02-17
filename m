From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Google has renamed the imap folder
Date: Tue, 17 Feb 2009 11:16:18 -0800
Message-ID: <20090217191618.GL18525@spearce.org>
References: <200902171012.15755.johnflux@gmail.com> <7vprhg52ne.fsf@gitster.siamese.dyndns.org> <20090217185423.GK18525@spearce.org> <bd6139dc0902171104x55637f8fr87a9f56154a7b45a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVRz-0007cM-DL
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZBQTQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZBQTQT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:16:19 -0500
Received: from george.spearce.org ([209.20.77.23]:45104 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZBQTQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:16:18 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F3D2381FF; Tue, 17 Feb 2009 19:16:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bd6139dc0902171104x55637f8fr87a9f56154a7b45a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110440>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Feb 17, 2009 at 19:54, Shawn O. Pearce <spearce@spearce.org> wrote:
> > So there's your "Gmail insider", at least from my perspective,
> > I really can't confirm either way any better than you can.
> 
> In that case, doesn't it make sense for countries that are "Google
> Mail" branded rather than "Gmail" branded (I think Germany and the UK
> are good examples?) have the "[Google Mail]/Drafts" folder, and
> regular countries will keep using "[GMail]/Drafts"?

Doh, that may very well be the issue here.

I didn't realize Gmail was branded differently in some countries.
But I wouldn't be surprised if that happened.  And if it did, then
I'd expect it to follow through in everything, including the IMAP
folder names.

In which case, [Gmail]/Drafts is probably the more common one
seen in the wild by users, but a handful in the "other places"
may see [Google Mail]/Drafts.

-- 
Shawn.
