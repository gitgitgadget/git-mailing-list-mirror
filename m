From: Alejandro Riveira <ariveira@gmail.com>
Subject: Weird message when pulling git version 1.6.6.rc1.39.g9a42
Date: Tue, 8 Dec 2009 22:05:35 +0000 (UTC)
Message-ID: <hfmijf$dl1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 23:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI8Fv-0004B6-7H
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 23:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966674AbZLHWJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 17:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966669AbZLHWJq
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 17:09:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:41821 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966672AbZLHWJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 17:09:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NI8EZ-0003ES-TJ
	for git@vger.kernel.org; Tue, 08 Dec 2009 23:08:39 +0100
Received: from 92.red-88-24-230.staticip.rima-tde.net ([88.24.230.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 23:08:39 +0100
Received: from ariveira by 92.red-88-24-230.staticip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 23:08:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 92.red-88-24-230.staticip.rima-tde.net
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134916>

$ git pull
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 5 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
   6035ccd..a252e74  master     -> origin/master
Updating 6035ccd..a252e74
Fast-forward (no commit created; -m option ignored) # what is this ??
 net/sctp/sysctl.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
