From: Paul Mackerras <paulus@samba.org>
Subject: New version of gitk
Date: Thu, 12 May 2005 11:00:12 +1000
Message-ID: <17026.43676.670725.66502@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 12 02:56:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1zR-0001Ry-4x
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVELBD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 21:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVELBD0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 21:03:26 -0400
Received: from ozlabs.org ([203.10.76.45]:6613 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261286AbVELBDZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 21:03:25 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A887167A39; Thu, 12 May 2005 11:03:23 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have just put a new version of gitk at:

	http://ozlabs.org/~paulus/gitk-0.9

I'm pretty happy with the display side of it now.  When you select a
commit it displays the full diff below the commit comments in the
bottom-left pane, with the diff displayed nicely with red and green
backgrounds for the removed and added lines.  There is still plenty to
do in the areas of user preferences, menus, find facility, etc.

Paul.
