From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 20:55:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701302052230.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 02:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC4gw-0002hQ-Rb
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 02:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXAaBzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 20:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbXAaBzN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 20:55:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42074 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXAaBzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 20:55:12 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCP00JB2MNZZ940@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Jan 2007 20:55:12 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38221>

On Tue, 30 Jan 2007, Daniel Barkalow wrote:

>   warning: you are now browsing the history without a local branch. You 
>   will not be able to commit changes unless you create a new local branch 
>   with "git checkout -b <new_branch_name>".

This isn't true.  You can commit on top of a detached head.  In fact you 
can do almost anything.


Nicolas
