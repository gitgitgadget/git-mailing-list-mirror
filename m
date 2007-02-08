From: Kumar Gala <galak@kernel.crashing.org>
Subject: git-am and workflow question
Date: Wed, 7 Feb 2007 18:34:05 -0600
Message-ID: <FA0FC64E-75D2-4722-8BD9-F7E6C8C9AFA7@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 04:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEzeO-0007Vm-57
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 04:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbXBHDIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 22:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965678AbXBHDIl
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 22:08:41 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:45660 "EHLO
	nommos.sslcatacombnetworking.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965650AbXBHDIk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 22:08:40 -0500
X-Greylist: delayed 3426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Feb 2007 22:08:40 EST
Received: from [72.183.106.80] (helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.63)
	(envelope-from <galak@kernel.crashing.org>)
	id 1HEyl4-0007Ua-1P
	for git@vger.kernel.org; Wed, 07 Feb 2007 20:11:34 -0600
X-Mailer: Apple Mail (2.752.2)
X-PopBeforeSMTPSenders: kumar-chaos@kgala.com,kumar-statements@kgala.com,kumar@kgala.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39028>

I poked around the docs and mailing lists but didn't find an answer  
to my question some simple searches so I figured it might be easier  
to just post a query to the list.

So my problem is that I'm applying some patches from a mbox and want  
to be able to do some slight modifications before actually committing  
the change.  I was wondering how people solve this problem (if at all).

thanks

- kumar
