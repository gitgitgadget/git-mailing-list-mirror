From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: Storing Maintainers info around the kernel tree
Date: Thu, 16 Aug 2007 21:58:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708162156550.9927-100000@netrider.rowland.org>
References: <46C4FD57.3000101@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Salikh Zakirov <salikh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-pm@lists.linux-foundation.org>, <git@vger.kernel.org>
To: Rene Herman <rene.herman@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762657AbXHQB7W@vger.kernel.org Fri Aug 17 03:59:40 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762657AbXHQB7W@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILr7k-0000fj-79
	for glk-linux-kernel-3@gmane.org; Fri, 17 Aug 2007 03:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762657AbXHQB7W (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Aug 2007 21:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXHQB7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Aug 2007 21:59:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:1251 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752592AbXHQB7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Aug 2007 21:59:10 -0400
Received: (qmail 12709 invoked by uid 500); 16 Aug 2007 21:58:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2007 21:58:51 -0400
X-X-Sender: stern@netrider.rowland.org
In-Reply-To: <46C4FD57.3000101@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56037>

On Fri, 17 Aug 2007, Rene Herman wrote:

> On 08/16/2007 11:39 PM, Stefan Richter wrote:
> > Rene Herman wrote:
> 
> >> I personally don't think there's a whole lot wrong with more and more
> >> expecting people who submit patches (for whom this automation is
> >> intended) to be using git.
> > 
> > You mean "people who frequently submit patches for various different
> > subsystems".
> 
> Erm, I guess. Is that agreeing or disagreeing with me?

Don't forget also that the MAINTAINERS information is (or should be!)
used by people who want to submit bug reports, not just by people who
submit patches.  Bug reporters shouldn't need to use Git.

Alan Stern
