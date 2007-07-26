From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Thu, 26 Jul 2007 15:01:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261459570.14781@racer.site>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
 <7vmyxj8wza.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE3uF-0000M9-87
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 16:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbXGZOB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 10:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871AbXGZOB1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 10:01:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:57411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753255AbXGZOB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 10:01:27 -0400
Received: (qmail invoked by alias); 26 Jul 2007 14:01:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 26 Jul 2007 16:01:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p6m45o/npFl4/l8ZOr+SmJf9a9v+r9ibRIfkTVO
	ziB5hfUaIWbDED
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyxj8wza.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53832>

Hi,

On Thu, 26 Jul 2007, Junio C Hamano wrote:

> This seems to break t1020 and t1500, probably among other
> things.

It does, yes.  I only realised that when I woke up.

Will fix.  In the meantime, you guys can discuss the merits of my patch 
series.  Am I the only one who finds the new version much easier to read, 
much like the pre-work-tree version?

Ciao,
Dscho
