From: Alex Blewitt <Alex.Blewitt@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and  Mercurial
Date: Sun, 26 Apr 2009 12:02:28 +0000 (UTC)
Message-ID: <loom.20090426T120010-583@post.gmane.org>
References: <200904260703.31243.chriscool@tuxfamily.org>  <m363grq13i.fsf@localhost.localdomain> <4d8e3fd30904260123r35b6a348uab3ad22fde9daa3f@mail.gmail.com> <alpine.DEB.1.00.0904261206170.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0904261217510.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 12:34:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly385-0006XN-MH
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 14:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbZDZMFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 08:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbZDZMFH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 08:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52008 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbZDZMFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 08:05:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ly36V-000884-6v
	for git@vger.kernel.org; Sun, 26 Apr 2009 12:05:03 +0000
Received: from server.bandlem.com ([217.155.97.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 12:05:03 +0000
Received: from Alex.Blewitt by server.bandlem.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 12:05:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.155.97.60 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117645>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> 
> Hi,
> 
> On Sun, 26 Apr 2009, Johannes Schindelin wrote:
> 
> > On Sun, 26 Apr 2009, Paolo Ciarrocchi wrote:
> > 
> > > On 4/26/09, Jakub Narebski <jnareb <at> gmail.com> wrote:
> > > 
> > > > Perhaps it is time to restart work on _"smart" HTTP protocol_?
> > > >
> > > 
> > > 
> > > wasn't Shawn working on it?
> > 
> > GIVE HIM A BREAK!
> 
> Sorry.  While it reflects exactly what I felt reading your mail, I should 
> have phrased it like this:
> 
> 	Don't ask what Shawn can do for you.  Ask what you can do for 
> 	Shawn.

It's something I raised a while ago with the eclipse.egit discussion; I'm happy
to step forward and see  what I can do to improve the HTTP access, since I 
think that's critical for adoption in organizations  who, through no fault of 
the end user, are either not directly connected to the internet or have to go 
via HTTP proxies due to firewall limitations.

Alex
