From: funeeldy <Marlene_Cote@affirmednetworks.com>
Subject: git checkout no longer warning about uncommitted/untracked files!
Date: Mon, 23 May 2011 10:29:57 -0700 (PDT)
Message-ID: <1306171797211-6395441.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 19:30:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOYx9-0005eU-Lr
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 19:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab1EWR36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 13:29:58 -0400
Received: from sam.nabble.com ([216.139.236.26]:46526 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab1EWR35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 13:29:57 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <Marlene_Cote@affirmednetworks.com>)
	id 1QOYx3-0001fA-79
	for git@vger.kernel.org; Mon, 23 May 2011 10:29:57 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174255>

I found some other posts that seem to indicate that this is the right place
to file bug reports for git.  If this is wrong, please let me know the
proper method.
We are using git version 1.7.3.  We just noticed that git checkout no longer
warns about uncommitted/untracked files and just deletes them!!!  I had a
developer lose a lot of work today because 
they were not committing regularly (which they will do now), and because I
told them to perform the checkout believing that it would do as it has
always done, and warn about their modified and untracked new files.
I believe this is a bug.  Is it fixed in a later release already?  If so,
which release?  You guys really need to get a bug tracking system like Jira
to allow the git user community to file bugs and feature requests!!!!
Thanks for your help.

--
View this message in context: http://git.661346.n2.nabble.com/git-checkout-no-longer-warning-about-uncommitted-untracked-files-tp6395441p6395441.html
Sent from the git mailing list archive at Nabble.com.
