From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 12:34:12 -0400
Message-ID: <CC669745-4434-478E-9A24-E474071578C6@silverinsanity.com>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site> <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com> <Pine.LNX.4.64.0707191642270.14781@racer.site> <6C96EBA9-CDCE-40EA-B0EC-F9195DBE83DB@silverinsanity.com> <Pine.LNX.4.64.0707191715000.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:34:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBYxM-0002Wl-CW
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 18:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762287AbXGSQeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 12:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765828AbXGSQeN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 12:34:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54225 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762287AbXGSQeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 12:34:12 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E74801FFC244;
	Thu, 19 Jul 2007 16:34:11 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0707191715000.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53006>


On Jul 19, 2007, at 12:17 PM, Johannes Schindelin wrote:

> Alas, we already have such a marker.  It is called ".gitignore",  
> and has
> been ignored by _you_.  There is _nothing_ wrong, from a technical
> standpoint, to call this marker ".gitignore", and it is _also_ not  
> wrong
> to put this marker into the file system _in addition_ to the index.
>
> So go and add your directories via that marker, and _be done with it_.

But this alters the content of the directory away from what I want it  
to be, namely empty.  You aren't addressing the concept of tracking  
an empty directory, you're just saying you won't do it.

~~ Brian
