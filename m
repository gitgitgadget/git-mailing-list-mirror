From: Frans Pop <elendil@planet.nl>
Subject: Conflicting "-n" short options for git-pull?
Date: Sat, 15 Sep 2007 21:14:54 +0200
Message-ID: <200709152114.54985.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 21:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWdML-0007ag-OI
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 21:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbXIOTbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbXIOTbN
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 15:31:13 -0400
Received: from hpsmtp-eml13.kpnxchange.com ([213.75.38.113]:44389 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752200AbXIOTbM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 15:31:12 -0400
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Sep 2007 15:31:12 EDT
Received: from hpsmtp-eml01.kpnxchange.com ([213.75.38.101]) by hpsmtp-eml13.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 15 Sep 2007 21:14:55 +0200
Received: from faramir.fjphome.nl ([84.85.147.182]) by hpsmtp-eml01.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 15 Sep 2007 21:14:55 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-OriginalArrivalTime: 15 Sep 2007 19:14:55.0218 (UTC) FILETIME=[B304E520:01C7F7CC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58270>

Hello,

According to the man page for git-pull from git-core 1.5.3.1 (Debian 
package), two options are defined as having the short option "-n":

     -n, --no-summary
         Do not show diffstat at the end of the merge.
[...]
     -n, --no-tags
         By default, git-fetch fetches tags that point at objects that are
         downloaded from the remote repository and stores them locally. This
         option disables this automatic tag following.

Cheers,
Frans Pop
