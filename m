From: ask4thunder <ask4thunder@gmail.com>
Subject: How to sync changes in GIT to ClearCase or How to get the list of
 files changed in GIT for a specific branch
Date: Thu, 23 Apr 2009 11:59:20 -0700 (PDT)
Message-ID: <23197522.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 21:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4AI-0002Cv-OL
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbZDWS7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZDWS7V
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:59:21 -0400
Received: from kuber.nabble.com ([216.139.236.158]:36787 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZDWS7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:59:21 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Lx48m-00049s-AC
	for git@vger.kernel.org; Thu, 23 Apr 2009 11:59:20 -0700
X-Nabble-From: ask4thunder@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117364>


Hi Everyone, 

Thanks for looking into this thread.

This is a help on GIT to ClearCase sync and am using UNIX session and not
Windows

I am intending to use ClearCase in the background and GIT in the front.
For syncing files from ClearCase to GIT i 
checkout the git branch
use rsync command to get the changed files in ClearCase
and then i do the 'git add' and 'git commit'

This works out well, but i want to get a list of files changed in GIt so
that i can bring that to ClearCase and checkout and checkin files.

Can someone provide me the commands to

1. Get list of files changed in GIT, after i do commit?
2. Get list of files changed in GIT after commit, but files changed after a
tag (baseline).
3. Sync these files to ClearCase?


Hope you gurus can help me....am in desperate need of these commands. 
Appreciate your help  in this.

Thanks
ask4thunder

-- 
View this message in context: http://www.nabble.com/How-to-sync-changes-in-GIT-to-ClearCase-or-How-to-get-the-list-of-files-changed-in-GIT-for-a-specific-branch-tp23197522p23197522.html
Sent from the git mailing list archive at Nabble.com.
