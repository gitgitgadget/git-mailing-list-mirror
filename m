From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 23:33:38 -0400
Message-ID: <42BCD092.6050201@pobox.com>
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 25 05:27:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm1KG-0005OP-CK
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 05:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbVFYDdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 23:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbVFYDdx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 23:33:53 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30150 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263313AbVFYDdo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 23:33:44 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dm1QL-00077H-6X; Sat, 25 Jun 2005 03:33:43 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050622224003.GA21298@redhat.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave Jones wrote:
> On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
>  > 
>  > Things in git-land are moving at lightning speed, and usability has 
>  > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
>  > 
>  > 
>  > 
>  > 1) installing git
>  > 
>  > git requires bootstrapping, since you must have git installed in order 
>  > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
>  > have put together a bootstrap tarball of today's git repository.
>  > 
>  > Download tarball from:
>  > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> 
> <blatant self-promotion>
> daily snapshots (refreshed once an hour) are available at:
> http://www.codemonkey.org.uk/projects/git-snapshots/git/
> </blatant self-promotion>

I was about to link to this, but a problem arose:  your snapshots don't 
include the .git/objects directory.

Also, a git-latest.tar.gz symlink would be nice.

	Jeff


