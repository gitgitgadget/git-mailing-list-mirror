From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: What broke snapshots now?
Date: Sat, 09 Jul 2005 09:37:47 -0400
Message-ID: <42CFD32B.8060108@pobox.com>
References: <1120907336.8058.293.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 15:39:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrFXF-0007PX-Jo
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 15:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGINiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVGINiH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 09:38:07 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7602 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261390AbVGINiC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 09:38:02 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DrFWh-0007xf-Hw; Sat, 09 Jul 2005 13:37:53 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1120907336.8058.293.camel@baythorne.infradead.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> Does git on master.kernel.org need to be updated to handle packed
> objects?

Yes.

It's always fun when the on-disk format of the upstream 2.6.x kernel 
repo changes without notice :/

	Jeff
