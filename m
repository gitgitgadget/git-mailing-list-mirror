From: Nicolas Pitre <nico@cam.org>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 10:25:51 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706141014320.5651@xanadu.home>
References: <18031.64456.948230.375333@lisa.zopyra.com>
 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
 <7vps3zascu.fsf@assigned-by-dhcp.pobox.com> <4670F6FD.4060704@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 16:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyqGw-00015g-6b
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 16:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXFNOZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXFNOZ7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 10:25:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30172 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbXFNOZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 10:25:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJM00INDQR3IR80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Jun 2007 10:25:51 -0400 (EDT)
In-reply-to: <4670F6FD.4060704@midwinter.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50201>

On Thu, 14 Jun 2007, Steven Grimm wrote:

> You can view this in terms of being a leg up for people who *do* want to use
> git, but are in environments where they are unable to convince or force
> everyone else to adopt git-style workflows. I think it's telling that almost
> all the discussions about this kind of feature are of the form, "I'm trying to
> convince my team to use git, and they find it no good because of X." It's the
> person trying to sell git to the group, presumably so they can use it
> themselves without having to go through a CVS or Subversion or p4 gateway,
> that this stuff really helps. That the rest of the team will benefit down the
> road too is nice but probably not the immediate selfish personal goal of the
> people who are asking for this kind of feature.

Personally, I think there is a point where it isn't worth trying to 
convert the world.  If people consider GIT bad and unwilling to use it 
because of X or Z then they probably better stay with CVS.  There is a 
limit to how backward bending should GIT do to accomodate everyone, 
especially if it is about compromize in its usage model just to make 
life easier for people who want to preserve their inferior work flow.

This being said, I don't claim to have a particular opinion about the 
issue discussed in this thread.  Simply that things should be decided on 
a technical basis and be justified with good arguments.  Saying that "I 
can't convince my co-workers to use GIT if it doesn't do X" is _not_ a 
good argument.


Nicolas
