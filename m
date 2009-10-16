From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 21:36:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910152118360.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
 <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 03:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MybpD-0002Ia-HO
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 03:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbZJPBh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbZJPBh0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 21:37:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17289 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbZJPBh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 21:37:26 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRL008Y3358KAC0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 21:36:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130446>

On Fri, 16 Oct 2009, Johannes Schindelin wrote:

> We, the old Gits need to change.  Not the many other people.
> 
> Remember: you do not know how exactly the clutch interacts with the 2nd 
> cylinder of the engine.  And you do not _need_ to.

Really, the detached HEAD concept can't be _that_ hard.  It is not like 
if we were asking our users to fully grok the blob/tree/commit hierarchy 
and delta compression heuristics to be able to work with Git.

> Neither should Git users need to.

What you're asking for, though, is more comparable to asking old Gits to 
give up on their clutch and manual gearbox because most American Git 
users are expecting automatic transmissions.  Maybe that's not the case 
in Germany, but over here automatic transmissions are by far the norm 
and a manual gearbox can be obtained only in limited cases if at all.


Nicolas
