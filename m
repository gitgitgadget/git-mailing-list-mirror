From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 12:57:57 -0500
Message-ID: <1155923876.10054.205.camel@cashmere.sps.mot.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 20:04:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE8hK-0000hU-F8
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 20:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWHRSDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWHRSDv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 14:03:51 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:10416 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751454AbWHRSDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 14:03:50 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k7II3lQs016875;
	Fri, 18 Aug 2006 11:03:47 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7II3kis023344;
	Fri, 18 Aug 2006 13:03:46 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25687>

On Thu, 2006-08-17 at 23:09, Junio C Hamano wrote:
> As everybody has probably noticed already, I am terrible at
> maintaining "the current issues" list.  The most recent issue of
> this series was done when?  Back on May 4th this year.
> 
> Shame on me.

I continue to think you are doing a fabulous job nonetheless!

> 
> Here is a list of topics in the recent git traffic that I feel
> inadequately addressed, in no particular order.  I've commented
> on some of them to give people a feel for what my priorities
> are.  Somebody might want to rehash the ones low on my priority
> list to conclusion with a concrete proposal if they cared about
> them enough.

I have another:

git-daemon virtualization so that consistent HTTP and
native git protocols can appear to use consistent URLs
even in the face of HTTP configurations aliasing them
to somewhere else on the filesystem and for multiple
virtually hosted domain names.


Thanks,
jdl
