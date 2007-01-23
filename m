From: Nicolas Pitre <nico@cam.org>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 16:52:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701231649520.3011@xanadu.home>
References: <200701231259.27719.andyparkins@gmail.com>
 <45B6076F.5060503@op5.se> <200701231314.53361.andyparkins@gmail.com>
 <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 22:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9TZP-0000Ye-Rz
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 22:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965495AbXAWVwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965496AbXAWVwn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 16:52:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54606 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965495AbXAWVwm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 16:52:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCC00E6TCRTF1E0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 23 Jan 2007 16:52:41 -0500 (EST)
In-reply-to: <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37575>

On Tue, 23 Jan 2007, Junio C Hamano wrote:

> And we might want to allow reflogs on detached HEAD someday,
> although I personally think it goes against what detached HEAD
> is -- it is of a very temporary nature.

Didn't we agree already that reflog with detached head was simply 
insane?


Nicolas
