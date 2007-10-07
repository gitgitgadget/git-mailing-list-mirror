From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 8 Oct 2007 00:19:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080018270.4174@racer.site>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> 
 <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefQe-0003pc-9I
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861AbXJGXT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757860AbXJGXT3
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:19:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:37221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756182AbXJGXT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:19:29 -0400
Received: (qmail invoked by alias); 07 Oct 2007 23:19:26 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp058) with SMTP; 08 Oct 2007 01:19:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qqKcp9UWqTEIotf0Pi+aJH9CEjafSnGxe+Etk0q
	cmFJlsaIDxvmlA
X-X-Sender: gene099@racer.site
In-Reply-To: <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60248>

Hi,

On Sun, 7 Oct 2007, Elijah Newren wrote:

> So...how do I fix the reflog, and then repack to have a pack under 11MB 
> in size?

Just clone it.  The clone will be much smaller.

Ciao,
Dscho
