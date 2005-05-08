From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: cg-log patches
Date: Sun, 08 May 2005 21:00:07 +0200
Message-ID: <1115578807.8949.12.camel@pegasus>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
	 <1115574136.9031.147.camel@pegasus>
	 <1856.10.10.10.24.1115576809.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 20:54:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUqtM-0007Ow-66
	for gcvg-git@gmane.org; Sun, 08 May 2005 20:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEHS7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 14:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVEHS7q
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 14:59:46 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:61613 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261262AbVEHS7p
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 14:59:45 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48J11WX004779
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 21:01:02 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1856.10.10.10.24.1115576809.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Sean,

> > why don't you use diffstat for it? I think that it is more handy then
> > the list of modified files.
> 
> Is a good idea, but would be a fair bit harder to generate unfortunately. 
> Right now the blobs themselves don't have to be opened and inspected, just
> the commit trees.   Actually, i'm not sure exactly how you'd even go about
> generating a correct diffstat for commits that have multiple parents.

I am not a really good git expert, but maybe another option for it would
be fine.

However there is another thing that I am missing. With Bitkeeper I was
able to do something like "bk changes -umarcel" to list all changes done
by the user "marcel". I like to have something similar with cg-log. Any
ideas on how to do that?

Regards

Marcel


