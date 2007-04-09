From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Sun, 08 Apr 2007 22:33:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704082229290.28181@xanadu.home>
References: <46197814.5010909@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 04:34:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hajhs-0004DX-Dx
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 04:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXDICdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 22:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXDICdy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 22:33:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10178 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbXDICdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 22:33:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG7001LQLSHGD83@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Apr 2007 22:33:53 -0400 (EDT)
In-reply-to: <46197814.5010909@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44026>

On Sun, 8 Apr 2007, Dana How wrote:

> After reviewing others' comments,  this latest patchset
> touches 2/3 fewer files and 1/6 fewer lines,  and
> introduces no behavior not seen elsewhere in git.

I'm starting to like it, but...

I have some extensive changes that touch the same area more or less.  
And so far I think it might be easier to rebase your changes on top of 
mine rather than the other way around.

So I'd like if my changes would be merged first and then yours to be 
applied afterwards.  They still have some issues left anyway.

I'm trying to format my changes now and send them tonight.


Nicolas
