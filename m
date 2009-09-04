From: Nicolas Pitre <nico@cam.org>
Subject: Re: [JGIT PATCH (RESEND) 3/3] Fix DirCache.findEntry to work on an
 empty cache
Date: Thu, 03 Sep 2009 20:06:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909032003490.6044@xanadu.home>
References: <1251847010-9992-1-git-send-email-spearce@spearce.org>
 <1251847010-9992-2-git-send-email-spearce@spearce.org>
 <1251847010-9992-3-git-send-email-spearce@spearce.org>
 <200909040114.12980.robin.rosenberg@dewire.com>
 <20090903231910.GN1033@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 02:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjML6-00044q-0h
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 02:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbZIDAHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 20:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbZIDAH3
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 20:07:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZIDAH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 20:07:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPF00BOX6Z3ACM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Sep 2009 20:06:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090903231910.GN1033@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127672>

On Thu, 3 Sep 2009, Shawn O. Pearce wrote:

> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > > Signed-off-by: Shawn O. Pearce <sop@google.com>
> > > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > 
> > Is this a new policy?
> 
> Call it a new habit.  I send from my @spearce.org because that's my
> "public identity", but this was on work time, so I added an extra
> SOB line to indicate that yes, my employer is also OK with this.

You might as well simply use your Google SOB alone, even if your From is 
@spearce.org.  That's what I do with my Linux patches done on $day_job 
time.


Nicolas
