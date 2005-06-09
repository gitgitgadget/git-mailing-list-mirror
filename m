From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 23:07:54 -0400
Message-ID: <42A7B28A.9010508@pobox.com>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 05:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgDKw-0007JL-6Y
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 05:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVFIDID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 23:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFIDID
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 23:08:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59091 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262255AbVFIDH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 23:07:59 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DgDOe-0004Mp-F2; Thu, 09 Jun 2005 03:07:56 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Comments? It would be good to have people test this and maybe even write a 
> few automated tests that it all works as expected..

I've got a few libata branches I have been putting off updating to the 
latest kernel, because of merge conflicts ('chs-support' and 'passthru' 
branches of libata-dev.git).

If this merge-gracefully stuff is all checked into git.git, I can 
definitely give it some real-world testing.

	Jeff


