From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 0/17] Documentation fixes in response to my previous listing
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844841342-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVBO-0004R3-UM
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbVLHX2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVLHX2K
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:10 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:63181 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932722AbVLHX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:06 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep02.bredband.com with ESMTP
          id <20051208232804.VWXV17186.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:04 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 0BAF3ADFE5
	for <git@vger.kernel.org>; Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13385>

This is a series of patches that fix small issues with the documentation.
This includes missing option-aliases, missing options, and broken formatting.

        nikolai

---
 Documentation/git-am.txt                 |    2 +-
 Documentation/git-cherry-pick.txt        |    6 ++---
 Documentation/git-commit.txt             |   18 +++++++++-----
 Documentation/git-cvsimport.txt          |    2 +-
 Documentation/git-format-patch.txt       |   23 +++++++++++++----
 Documentation/git-http-fetch.txt         |    6 +++++
 Documentation/git-ls-remote.txt          |    2 +-
 Documentation/git-merge-index.txt        |    2 +-
 Documentation/git-pack-objects.txt       |    6 ++++-
 Documentation/git-prune.txt              |   10 +++++++-
 Documentation/git-read-tree.txt          |    2 +-
 Documentation/git-repack.txt             |    9 ++++++-
 Documentation/git-revert.txt             |    4 ++-
 Documentation/git-show-branch.txt        |    8 +++++-
 Documentation/git-tag.txt                |   40 +++++++++++++++---------------
 Documentation/git-update-server-info.txt |    2 +-
 Documentation/git-verify-pack.txt        |    4 ++-
 git-revert.sh                            |    2 +-
 pack-objects.c                           |    2 +-
 show-branch.c                            |    2 +-
 20 files changed, 101 insertions(+), 51 deletions(-)
