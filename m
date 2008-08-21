From: Brian Loomis <brian@fullstorymedia.com>
Subject: Git Error for local refs
Date: Thu, 21 Aug 2008 07:58:12 -0600
Message-ID: <9C7F9C16-7A40-407A-A47A-6BEFDF5953FF@fullstorymedia.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 16:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWAwg-0008DC-7d
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706AbYHUOOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbYHUOOR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:14:17 -0400
Received: from s1.cableone.net ([24.116.0.227]:35664 "EHLO s1.cableone.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758353AbYHUOOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:14:15 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 10:14:15 EDT
Received: from [192.168.8.106] (unverified [24.117.99.28]) 
	by s1.cableone.net (CableOne SMTP Service s1) with ESMTP id 4603039-1872270 
	for <git@vger.kernel.org>; Thu, 21 Aug 2008 06:58:12 -0700
X-Mailer: Apple Mail (2.928.1)
X-Vpipe: Scanner said ok (av_avast)
X-NotAscii: charset=us-ascii;
X-IP-stats: Incoming Last 0, First 58, in=61, out=0, spam=0 ip=24.117.99.28
X-Originating-IP: 24.117.99.28
X-Abuse-Info: Send abuse complaints to abuse@cableone.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93152>

I'm getting the error trying to do a pull from a repos I set up on  
GitHub yesterday.

error: some local refs could not be updated; try running
'git remote prune origin' to remove any old, conflicting branches

I've run the  'git remote prune origin' but still get the error doing  
the pull.

Any ideas how to resolve this?  Google seems to show me nothing on  
this and I have also looked at the manual.

TIA

Brian Loomis
http://www.virtualrelations.us
(208) 639-2569 - 208 NEW BLOX
