From: Kumar Gala <galak@kernel.crashing.org>
Subject: git-send-email and --suppress-from
Date: Tue, 26 Jun 2007 16:14:10 -0500
Message-ID: <0B037893-D512-4ECF-B269-C002528C749B@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 23:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3IMa-0001nw-Kq
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236AbXFZVOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbXFZVOO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 17:14:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:37720 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbXFZVOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 17:14:14 -0400
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l5QLECCe030171
	for <git@vger.kernel.org>; Tue, 26 Jun 2007 16:14:13 -0500
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50975>

I was wondering if its intentional that if --from address doesn't  
match the address in the mbox that its added to the CC even if -- 
suppress-from is set?

- k
