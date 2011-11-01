From: photoshop_nerd <JBreuer@consumercredit.com>
Subject: checking out later commits from rolled back state
Date: Tue, 1 Nov 2011 07:36:47 -0700 (PDT)
Message-ID: <1320158207959-6951892.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 15:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLFSP-0001lI-Fa
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 15:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab1KAOgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 10:36:49 -0400
Received: from sam.nabble.com ([216.139.236.26]:40203 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab1KAOgs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 10:36:48 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <JBreuer@consumercredit.com>)
	id 1RLFSK-0004Q2-0M
	for git@vger.kernel.org; Tue, 01 Nov 2011 07:36:48 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184567>

Hello, I a m relatively new to git, and my question pertains to moving back
and forth through the history of my commits.

Here is how I open a previous commit:

1)$ git log

2) (get sha1 hash of previous commit)

3)$ git checkout <hash of my previous commit>

the problem is that once I am working with that commit, git log only shows
the hash tags up to the time that the commit was made, but not any of the
later commits. Is there a way to get the hash tags of my later commits when
I am in that rolled back state?

--
View this message in context: http://git.661346.n2.nabble.com/checking-out-later-commits-from-rolled-back-state-tp6951892p6951892.html
Sent from the git mailing list archive at Nabble.com.
