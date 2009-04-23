From: ask4thunder <ask4thunder@gmail.com>
Subject: Is there a way to lock branches in GIT?
Date: Thu, 23 Apr 2009 14:43:00 -0700 (PDT)
Message-ID: <23204641.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 23:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx6il-0008D5-Sd
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 23:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbZDWVnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZDWVnE
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 17:43:04 -0400
Received: from kuber.nabble.com ([216.139.236.158]:44774 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbZDWVnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 17:43:03 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Lx6hA-0002gt-Uz
	for git@vger.kernel.org; Thu, 23 Apr 2009 14:43:00 -0700
X-Nabble-From: ask4thunder@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117390>


Hi GIT Gurus,

1. If there are 2 user are working and having their own clone and branches
(not master, other branches). and there is another parent clone with a
branch (not master). Can these 2 users merge to the parent clone branch at
the same time? or only one user will be able to merge first and then the
other. in other words, will the target branch be checkedout to that user
alone and other user cant checkout that branch or use the checked out
branch. 

2. Is there a way to lock branches, so that if a user want to merge his
changes to a parent branch of another clone, it can be unlocked for him
alone? Hope you can help me on this. 


Thanks 
ask4thunder


-- 
View this message in context: http://www.nabble.com/Is-there-a-way-to-lock-branches-in-GIT--tp23204641p23204641.html
Sent from the git mailing list archive at Nabble.com.
