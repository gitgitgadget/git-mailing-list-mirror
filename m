From: Paul Gardiner <paul@laser-point.co.uk>
Subject: Clean up after git-filter-branch
Date: Fri, 15 Feb 2008 08:51:41 +0000
Message-ID: <47B5529D.3080904@laser-point.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: osronline@glidos.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 10:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPwT5-0000eo-FZ
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbYBOJCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 04:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbYBOJCP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:02:15 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:3360
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764485AbYBOJCM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 04:02:12 -0500
X-Greylist: delayed 623 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2008 04:02:12 EST
X-Trace: 41259014/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.31
X-SBRS: None
X-RemoteIP: 62.241.162.31
X-IP-MAIL-FROM: paul@laser-point.co.uk
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAMvgtEc+8aIf/2dsb2JhbACuew
X-IP-Direction: IN
Received: from galaxy.systems.pipex.net ([62.241.162.31])
  by smtp.pipex.tiscali.co.uk with ESMTP; 15 Feb 2008 08:51:44 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by galaxy.systems.pipex.net (Postfix) with ESMTP id 61F04E000099;
	Fri, 15 Feb 2008 08:51:43 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73943>

What's the simplest clean up command after a git-filter-branch --all
to remove all the branches in refs/original, so that you can do
another git-filter-branch?

P.
