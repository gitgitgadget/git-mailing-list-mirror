From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 03 Jun 2007 17:06:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706031703140.12885@xanadu.home>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
 <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
 <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
 <7virac547s.fsf@assigned-by-dhcp.cox.net>
 <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuxHC-0004I8-5J
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbXFCVGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbXFCVGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 17:06:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38939 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbXFCVGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 17:06:08 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJ2007CYVY57PB0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 03 Jun 2007 17:06:05 -0400 (EDT)
In-reply-to: <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49035>

On Sat, 2 Jun 2007, Junio C Hamano wrote:

> * dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
>  - Enhance unpack-objects for live repo and large objects
> 
> I saw nobody other than Dana jump up and down and say we must
> have this, so I still parked this in 'pu' without merging it to
> 'next'.  Maybe a time for a quick poll?

I did provide a followup comment to this patch.  If the concerns I 
raised are addressed then I won't be against such a patch.


Nicolas
