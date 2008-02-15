From: Paul Gardiner <osronline@glidos.net>
Subject: Clean up after git-filter-branch
Date: Fri, 15 Feb 2008 09:02:46 +0000
Message-ID: <47B55536.1010900@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: osronline@glidos.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 10:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPwTy-0000uE-8d
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933496AbYBOJC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 04:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933456AbYBOJCz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:02:55 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:3810
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933407AbYBOJCw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 04:02:52 -0500
X-Trace: 41266778/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.31
X-SBRS: None
X-RemoteIP: 62.241.162.31
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAE/ktEc+8aIf/2dsb2JhbACueg
X-IP-Direction: IN
Received: from galaxy.systems.pipex.net ([62.241.162.31])
  by smtp.pipex.tiscali.co.uk with ESMTP; 15 Feb 2008 09:02:49 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by galaxy.systems.pipex.net (Postfix) with ESMTP id 23A17E000087;
	Fri, 15 Feb 2008 09:02:48 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73944>

What's the simplest clean up command after a git-filter-branch --all
to remove all the branches in refs/original, so that you can do
another git-filter-branch?

P.
