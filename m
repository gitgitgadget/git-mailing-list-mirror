From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 12:32:25 -0400
Message-ID: <42B59E19.1010202@pobox.com>
References: <42B59CF7.3080509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 19 18:27:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk2dG-0006ey-Sx
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 18:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVFSQca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 12:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVFSQca
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 12:32:30 -0400
Received: from mail.dvmed.net ([216.237.124.58]:24726 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262264AbVFSQc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 12:32:28 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dk2ih-00007t-9K
	for git@vger.kernel.org; Sun, 19 Jun 2005 16:32:27 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42B59CF7.3080509@pobox.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik wrote:
> I just checked in a change with 'git commit' (no arguments).  Two 
> strange things occurred:


FWIW you can see the problem yourself at

'fc4-fix' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

(just one change checked in, the change referenced in the previous email)

