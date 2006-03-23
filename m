From: Rob Landley <rob@landley.net>
Subject: Who do I report bugs in the git source web browser thing to?
Date: Thu, 23 Mar 2006 11:43:17 -0500
Message-ID: <200603231143.17762.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Thu Mar 23 17:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMStn-0004kj-BW
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 17:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWCWQmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 11:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWCWQmu
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 11:42:50 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:49800
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932481AbWCWQmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 11:42:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id k2NIS36b006674
	for <git@vger.kernel.org>; Thu, 23 Mar 2006 13:28:03 -0500
To: git@vger.kernel.org
User-Agent: KMail/1.8.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17861>

When I go to kernel.org, click the tiny C next to linus's name to get the git 
browser for the tree, click "tree", click the "usr" directory, and then click 
"history" next to the file gen_init_cpio.c, it says this file appeared out of 
thin air 59 minutes ago.

This is not the case.

>From this link:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;h=bc589b0ffba8941b7f7574b71ddec795e2217107;hb=b0e6e962992b76580f4900b166a337bad7c1e81b;f=usr

I wind up with this link:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;h=b0e6e962992b76580f4900b166a337bad7c1e81b;f=usr/gen_init_cpio.c

Which shows exactly one change.

Am I doing something wrong?

Rob
-- 
Never bet against the cheap plastic solution.
