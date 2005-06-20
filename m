From: Jeff Garzik <jgarzik@pobox.com>
Subject: git droppings
Date: Sun, 19 Jun 2005 21:51:35 -0400
Message-ID: <42B62127.6010804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 20 03:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBMH-0000zw-Sj
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 03:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFTBvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 21:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFTBvk
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 21:51:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:40343 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261356AbVFTBvi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 21:51:38 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DkBRo-0000H1-QX
	for git@vger.kernel.org; Mon, 20 Jun 2005 01:51:38 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

'git commit' fails to clean up the following files

	.cmitmsg
	.editmsg

after it completes successfully.

	Jeff


