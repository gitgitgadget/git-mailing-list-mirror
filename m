From: David Brown <git@davidb.org>
Subject: git-svn and hierarchal branches.
Date: Sun, 30 Sep 2007 00:07:54 -0700
Message-ID: <20070930070754.GA10264@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:08:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbsuL-0004kY-6X
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 09:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbXI3HH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 03:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbXI3HH4
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 03:07:56 -0400
Received: from mail.davidb.org ([66.93.32.219]:44359 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbXI3HHz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 03:07:55 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IbsuA-0002oD-Ue
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 00:07:54 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59525>

I'm trying to use git-svn to track the 'Tango' SVN repository
   <http://www.dsource.org/projects/tango/wiki/Download>

Their layout is mostly standard, except that they have an extra hierarchy
in the branch directory (branch/user1, branch/user2, branch/D1_0 for a
release).

Is this something I can easily track with git-svn, or am I best trying to
do it manually?

Thanks,
David
