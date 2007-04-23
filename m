From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 12:16:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704231212260.28339@xanadu.home>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
 <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
 <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg1DX-0005BL-FS
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 18:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXDWQQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbXDWQQk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 12:16:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25836 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbXDWQQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 12:16:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGY0094SL7Q9SQ0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Apr 2007 12:16:39 -0400 (EDT)
In-reply-to: <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45330>

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> As 'ident' conversion is stateless, I do not mind too much
> including it in v1.5.2-rc1.  On the other hand, the arbitrary
> 'filter' is quite contentious, although the character-code
> conversion example I gave myself might be a good enough reason
> for people to want it.  Undecided.

Like I said there are certainly plenty of good (and bad) reasons for 
using this facility, and many of them we might not imagine now.  Since 
the code is already written I think you should include it.


Nicolas
