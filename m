From: Brian Loomis <brianloomis1@mac.com>
Subject: Git Errors for local refs
Date: Thu, 21 Aug 2008 08:12:42 -0600
Message-ID: <63013335-CBB4-43E5-9538-204828805849@mac.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 16:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWAvG-0007ZQ-4O
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbYHUOMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbYHUOMo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:12:44 -0400
Received: from s2.cableone.net ([24.116.0.228]:33398 "EHLO s2.cableone.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509AbYHUOMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:12:44 -0400
X-Greylist: delayed 895 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 10:12:43 EDT
Received: from [192.168.8.106] (unverified [24.117.99.28]) 
	by s2.cableone.net (CableOne SMTP Service s2) with ESMTP id 4550181-1872270 
	for <git@vger.kernel.org>; Thu, 21 Aug 2008 07:12:43 -0700
X-Mailer: Apple Mail (2.928.1)
X-Vpipe: Scanner said ok (av_avast)
X-NotAscii: charset=us-ascii;
X-IP-stats: Incoming Last 0, First 104, in=497, out=0, spam=0 ip=24.117.99.28
X-Originating-IP: 24.117.99.28
X-Abuse-Info: Send abuse complaints to abuse@cableone.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93151>

I'm getting the error trying to do a pull from a repos I set up on  
GitHub yesterday.

error: some local refs could not be updated; try running
'git remote prune origin' to remove any old, conflicting branches

I've run the  'git remote prune origin' but still get the error doing  
the pull.

Any ideas how to resolve this?  Google seems to show me nothing on  
this and I have also looked at the manual.

I've run the git fsck and git gc but still seem to get these.

TIA

Brian Loomis
