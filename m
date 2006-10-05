From: Jeff Garzik <jeff@garzik.org>
Subject: How to checkout a tag?
Date: Thu, 05 Oct 2006 06:47:49 -0400
Message-ID: <4524E2D5.3030907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 05 12:48:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVQle-0006Q5-JU
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 12:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWJEKrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 06:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWJEKrv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 06:47:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38107 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751653AbWJEKrv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 06:47:51 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GVQla-0005lJ-67
	for git@vger.kernel.org; Thu, 05 Oct 2006 10:47:50 +0000
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28354>


Sometimes I receive a kernel patch based off an older version of the 
kernel, for example a 2.6.18 patch when the current kernel is 2.6.19-rc1.

I would like to create a branch starting at 2.6.18, merge the patch, and 
then merge up to the current kernel.

How does one check out a tag, or create a branch based on a tag's 
starting point?

	Jeff
