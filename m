From: adam_kb <a-kyle@hotmail.com>
Subject: Log not displaying properly?
Date: Fri, 22 Apr 2011 20:25:13 -0700 (PDT)
Message-ID: <1303529113364-6298788.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 05:25:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDTTV-0005Ni-3F
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 05:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab1DWDZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 23:25:14 -0400
Received: from sam.nabble.com ([216.139.236.26]:55066 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab1DWDZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 23:25:13 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <a-kyle@hotmail.com>)
	id 1QDTT7-00057E-CA
	for git@vger.kernel.org; Fri, 22 Apr 2011 20:25:13 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171948>

I use github to store my projects and use git. Say for example I have project
X with Commits of 1,2,3,4,5 and 6.

So lets say these are my commands (for this instance I am the only commiter)

git push origin master (for 1,2,3 and 6)
git push -f origin master (for 4 and 5)

Up untill Commit 6 I could go git log and see the logs for all 5 pushes.
after the 6th commit I go git log and only see the logs for 1 ,2 and 6.

Why?

Whats going on?

Git hub shows me all the logs obviously but how do I make it display all 6
commits in the log?



--
View this message in context: http://git.661346.n2.nabble.com/Log-not-displaying-properly-tp6298788p6298788.html
Sent from the git mailing list archive at Nabble.com.
