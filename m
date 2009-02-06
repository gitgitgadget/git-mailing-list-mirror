From: Gonzo <gonzo@gonsolo.de>
Subject: How to find out which gitignore blocks my git-add
Date: Fri, 06 Feb 2009 10:38:45 +0100
Message-ID: <498C0525.5040100@gonsolo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 11:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVNi2-0002It-M3
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZBFKLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 05:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbZBFKLv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:11:51 -0500
Received: from [78.31.64.233] ([78.31.64.233]:55029 "EHLO gonsolo.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbZBFKLv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:11:51 -0500
X-Greylist: delayed 1967 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Feb 2009 05:11:50 EST
Received: from p54bd4827.dip.t-dialin.net ([84.189.72.39] helo=[192.168.2.100])
	by localhost.localdomain with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <gonzo@gonsolo.de>)
	id 1LVNAi-00045C-IV
	for git@vger.kernel.org; Fri, 06 Feb 2009 10:38:52 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108671>

After doing a "git add file" I get the message:

"The following paths are ignored by one of your .gitignore files:
..."

Is there an easy way to find out which line in which gitignore file 
blocks this add?
Would this be a viable addition to "git add -v"?

g
