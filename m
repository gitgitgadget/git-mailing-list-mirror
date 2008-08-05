From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/6] Misc. documentation cleanups
Date: Mon,  4 Aug 2008 19:47:10 -0700
Message-ID: <1217904436-1989-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCb1-0006ne-0a
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbYHECrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757192AbYHECrS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:18 -0400
Received: from george.spearce.org ([209.20.77.23]:45366 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbYHECrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:18 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9916838438; Tue,  5 Aug 2008 02:47:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1852538368;
	Tue,  5 Aug 2008 02:47:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91409>

After the JavaGit announcement today it was pointed out to me that
our top-level documentation in egit.git is not accurate with our
current project state.

This is a first attempt at getting things current.  Its likely not
complete and we should do more before we ship the next release.

Shawn O. Pearce (6):
  Updated egit INSTALL document to mention Eclipse 3.4.0
  Rename INSTALL to EGIT_INSTALL
  Mark completed items (commit, fetch, push, graphic log) in TODO file
  Remove outdated warnings from the README
  Remove the "jgit is slow" remark from README
  Remove the "windows isn't supported" remark from README

 INSTALL => EGIT_INSTALL |    4 +-
 README                  |   53 +-------------------------------------
 TODO                    |   66 -----------------------------------------------
 3 files changed, 3 insertions(+), 120 deletions(-)
 rename INSTALL => EGIT_INSTALL (96%)
