From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 03:06:23 -0400
Message-ID: <42BA5F6F.9090406@pobox.com>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org> <42B9FF3A.4010700@pobox.com> <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 09:02:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLj9-0006Eg-KQ
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVFWHII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVFWHHn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 03:07:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29874 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262544AbVFWHGc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 03:06:32 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlLn7-00037q-MR; Thu, 23 Jun 2005 07:06:26 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> (Of course, since the rsync protocol doesn't know anything about git
> consistency, if the mirroring is half-way, you'll end up with something
> less than wonderful, and confusing. Details, details)

Would it make sense to add an fsck step to git-clone-script?

	Jeff


