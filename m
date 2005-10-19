From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-diff-tree rename detection for single file
Date: Wed, 19 Oct 2005 12:04:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510191203220.5288@localhost.localdomain>
References: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
 <7vu0fepn0x.fsf@assigned-by-dhcp.cox.net>
 <7virvujkcw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510182004100.3369@g5.osdl.org>
 <7virvuhylm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, David Ho <davidkwho@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 18:10:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESGTp-0002BO-NS
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 18:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVJSQHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVJSQHt
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 12:07:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9562 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751143AbVJSQHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 12:07:48 -0400
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IOM007HX7BUEZ30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Oct 2005 12:04:42 -0400 (EDT)
In-reply-to: <7virvuhylm.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10293>

On Tue, 18 Oct 2005, Junio C Hamano wrote:

> BTW, I really liked your example that piped multiple diff-trees
> together.  That is a neat trick.

Yeah.  Those should really be picked up to augment the documentation 
section.


Nicolas
