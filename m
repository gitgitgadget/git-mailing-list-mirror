From: manigandans <etc.mani@gmail.com>
Subject: Find the size of git push in pre-receive hook
Date: Fri, 4 Nov 2011 02:20:20 -0700 (PDT)
Message-ID: <1320398420796-6962141.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 10:20:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMFwo-0000VP-SB
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 10:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1KDJUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 05:20:22 -0400
Received: from sam.nabble.com ([216.139.236.26]:42391 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab1KDJUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 05:20:21 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <etc.mani@gmail.com>)
	id 1RMFwi-0007l8-QE
	for git@vger.kernel.org; Fri, 04 Nov 2011 02:20:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184764>

Hi,

I want to restrict the size of the push on the git remote repository. How
can I find the size of the push in pre-receive hook?

Thanks a lot in advance.

Best regards,
Manigandan S.


--
View this message in context: http://git.661346.n2.nabble.com/Find-the-size-of-git-push-in-pre-receive-hook-tp6962141p6962141.html
Sent from the git mailing list archive at Nabble.com.
