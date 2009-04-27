From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
	Mercurial
Date: Mon, 27 Apr 2009 13:31:33 -0700
Message-ID: <20090427203133.GG23604@spearce.org>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain> <4d8e3fd30904260123r35b6a348uab3ad22fde9daa3f@mail.gmail.com> <alpine.DEB.1.00.0904261206170.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0904261217510.10279@pacific.mpi-cbg.de> <loom.20090426T120010-583@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Blewitt <Alex.Blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 22:31:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyXUP-0002wd-N8
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 22:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZD0Ube (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZD0Ube
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 16:31:34 -0400
Received: from george.spearce.org ([209.20.77.23]:58589 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZD0Ubd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 16:31:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6DDDA38215; Mon, 27 Apr 2009 20:31:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20090426T120010-583@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117714>

Alex Blewitt <Alex.Blewitt@gmail.com> wrote:
> Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> > On Sun, 26 Apr 2009, Johannes Schindelin wrote:
> > > On Sun, 26 Apr 2009, Paolo Ciarrocchi wrote:
> > > > On 4/26/09, Jakub Narebski <jnareb <at> gmail.com> wrote:
> > > > 
> > > > > Perhaps it is time to restart work on _"smart" HTTP protocol_?
> > > > 
> > > > wasn't Shawn working on it?

Errh, uhm, yes, I had planned to work on it.  I failed to find
the time.  Gerrit Code Review and the necessary patches to JGit
have basically sucked up any time that I have, for anything.  Oh,
and so has "repo", the hack^W^W^W^tool Android uses to manage its
forrest of 140+ Git repositories.

> > > GIVE HIM A BREAK!
> > 
> > Sorry.  While it reflects exactly what I felt reading your mail, I should 
> > have phrased it like this:
> > 
> > 	Don't ask what Shawn can do for you.  Ask what you can do for 
> > 	Shawn.
> 
> It's something I raised a while ago with the eclipse.egit discussion; I'm happy
> to step forward and see  what I can do to improve the HTTP access, since I 
> think that's critical for adoption in organizations  who, through no fault of 
> the end user, are either not directly connected to the internet or have to go 
> via HTTP proxies due to firewall limitations.

I'm quite looking forward to this.  I'm thrilled to see another
person is interested in better HTTP support, and is trying to
work on it.

-- 
Shawn.
