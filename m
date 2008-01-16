From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Wed, 16 Jan 2008 01:54:12 -0500
Message-ID: <20080116065412.GP24004@spearce.org>
References: <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness> <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com> <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness> <c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com> <alpine.DEB.1.00.0801151709330.5289@eeepc-johanness> <c0f2d4110801151104j4c34dekc7d06dcfc89bfbe6@mail.gmail.com> <20080115201530.GA17239@efreet.light.src> <buo3asymfvh.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF2Ah-0004xx-Rd
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 07:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbYAPGyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 01:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYAPGyT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 01:54:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55959 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYAPGyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 01:54:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JF2A9-0007EK-Up; Wed, 16 Jan 2008 01:54:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E3A7120FBAE; Wed, 16 Jan 2008 01:54:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <buo3asymfvh.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70642>

Miles Bader <miles.bader@necel.com> wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> > Git currently uses C, shell, perl and tcl/tk. There would probably be some
> > resistance to adding more dependencies, but that would not apply to the
> > contrib directory (so useful things written in something else are likely to
> > end up there).
> 
> Is tcl/tk restricted to the GUI stuff?

Yes.  Currently the only users of Tcl (or Tk) within the core
Git distribution is gitk and git-gui.

-- 
Shawn.
