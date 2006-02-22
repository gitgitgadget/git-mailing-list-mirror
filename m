From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] nicer eye candies for pack-objects
Date: Wed, 22 Feb 2006 18:40:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602221835570.5606@localhost.localdomain>
References: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain>
 <7vy803kp1n.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602221733030.5606@localhost.localdomain>
 <Pine.LNX.4.64.0602221502410.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 00:40:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC3ap-0007lS-Lt
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 00:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWBVXkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 18:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWBVXkR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 18:40:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:3697 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030352AbWBVXkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 18:40:15 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV400K774F2M570@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Feb 2006 18:40:14 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602221502410.3771@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16624>

On Wed, 22 Feb 2006, Linus Torvalds wrote:

> Well, my thinking behind the original unpack-objects behaviour was that we 
> don't really care about the max 100 extra packets. 

Obviously, the "every percent" has at most 100 additional packets.

And if it updates too fast to be readable, that means it'll be over in a 
snap anyway.

So I don't have any objections left.


Nicolas
