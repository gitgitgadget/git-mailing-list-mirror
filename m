From: Paul Mackerras <paulus@samba.org>
Subject: gitk now uses git-diff-tree --cc
Date: Tue, 7 Feb 2006 21:23:59 +1100
Message-ID: <17384.30015.458661.756886@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 11:35:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6QBb-0000I2-G7
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 11:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWBGKes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 05:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWBGKes
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 05:34:48 -0500
Received: from ozlabs.org ([203.10.76.45]:12446 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964943AbWBGKes (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 05:34:48 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1658F68A02; Tue,  7 Feb 2006 21:34:46 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15690>

Junio,

I have pushed out the changes to gitk to make it use git-diff-tree
--cc, and display its output with colorization.  It's now 400 lines
shorter. :)  Perhaps you could pull the new version into your git
repository?

Thanks,
Paul.
