From: Jesse van den Kieboom <jesse@icecrew.nl>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 04 Feb 2009 12:50:28 +0100
Message-ID: <1233748228.7594.2.camel@wren>
References: <1233432317.26364.5.camel@wren>
	 <498877A7.3050308@drmicha.warpmail.net>
	 <d4bc1a2a0902031143u2f4beadek507910fe3a6052f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 12:52:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgIR-0001iG-4g
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 12:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZBDLud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 06:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbZBDLuc
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 06:50:32 -0500
Received: from novowork.com ([87.230.85.62]:43884 "EHLO novowork.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbZBDLuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 06:50:32 -0500
Received: from [128.178.246.242] (ls-in-242.epfl.ch [128.178.246.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by novowork.com (Postfix) with ESMTPSA id 1F1AE36709FC;
	Wed,  4 Feb 2009 12:50:30 +0100 (CET)
In-Reply-To: <d4bc1a2a0902031143u2f4beadek507910fe3a6052f@mail.gmail.com>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108338>

Op dinsdag 03-02-2009 om 11:43 uur [tijdzone -0800], schreef Stefan
Karpinski:
> On Tue, Feb 3, 2009 at 8:58 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> >
> > Not yet another one, please!
> >
> > I'm sorry, but that was my first thought. I lost count of how many
> > half-finished GUIs we have, using tcl/tk, gtk, qt, you-name-it-tk. I
> > still don't see any which provide a consistent, "modern", stable GUI for
> > viewing *and* committing, i.e. a replacement for gitk and git-gui.
> >
> > The latter two still seem to be the most feature rich choices, but they
> > suffer somewhat from their implementation language. Just look at the git
> > survey and you know why nobody wants to work on them.
> 
> For what it's worth, GitX (OS X only) does both history viewing and
> committing, and seems to be rapidly approaching the feature set of
> gitk and git-gui combined. Unfortunately, I seem to inevitably hate
> cross-platform GUI's---they never feel right or work slickly enough.
> Sad, but true.

This is the reason why I'm developing gitg as a separate application,
and not as a different front end for GitX.

> If GitX and this newer project could share a lot of code base, then
> maybe their co-development would be accelerated and both would end up
> being slick, native, full-fledged GUIs for git.

I try to follow the implementation of GitX very closely since it's the
basis of the development of gitg (it happens to be that I know the
developer of GitX very well).

-- 
Jesse van den Kieboom

Personal: http://www.icecrew.nl
Professional: http://www.novowork.com
