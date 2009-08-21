From: Andrew Keller <andrew@kellerfarm.com>
Subject: git-daemon via launchd
Date: Fri, 21 Aug 2009 13:40:29 -0400
Message-ID: <D49DB51B-4D25-44CC-B09C-2598EC7FCEE9@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mea1q-0002dh-H9
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 21:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbZHUTng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 15:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbZHUTne
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 15:43:34 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:59593 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932070AbZHUTnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 15:43:33 -0400
X-Greylist: delayed 7382 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2009 15:43:33 EDT
Received: from c-208-53-115-13.customer.broadstripe.net ([208.53.115.13] helo=[192.168.0.102])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1MeY6E-0001HS-UB
	for git@vger.kernel.org; Fri, 21 Aug 2009 13:40:26 -0400
X-Mailer: Apple Mail (2.936)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126743>

Is it possible to configure launchd to run git-daemon based on an  
incoming connection, rather than having git-daemon listen for  
connections?

Thanks,
Andrew Keller
