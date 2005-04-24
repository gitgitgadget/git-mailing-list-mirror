From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Old "sparse" archive converted..
Date: Sun, 24 Apr 2005 01:24:18 -0400
Message-ID: <426B2D82.5000906@pobox.com>
References: <Pine.LNX.4.58.0504231815350.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sparse mailing list <linux-sparse@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 07:19:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZX9-0000aG-WE
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVDXFYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVDXFYa
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:24:30 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:643 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S262263AbVDXFYY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 01:24:24 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPZbR-0001xj-Qy; Sun, 24 Apr 2005 05:24:24 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231815350.2344@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Ok, I expanded on "convert-cache" quite a bit, to the point where it could
> actually re-write "commit" and "tree" objects entirely, at which point it
> now became possible to convert the broken old sparse archive that had the
> wrong date format in its commit objects, and had the old flat-file format
> for the "tree" objects.
> 
> I updated the tree at
> 
> 	kernel.org:/pub/linux/kernel/people/torvalds/sparse.git

Any chance you could copy it to

	/pub/scm/linux/kernel/git/torvalds/sparse.git

?

	Jeff


