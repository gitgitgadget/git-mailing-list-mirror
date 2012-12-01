From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v2 0/4] git-svn: More docs for branch handling in
Date: Sat, 1 Dec 2012 02:08:30 +0100
Message-ID: <cover.1354324110.git.Sebastian.Leske@sleske.name>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 12:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Teko4-0008E1-4s
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 12:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab2LALAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 06:00:04 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:54814 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2LALAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 06:00:03 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 76B9F1F549C3;
	Sat,  1 Dec 2012 11:59:29 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tekn9-00040B-2n; Sat, 01 Dec 2012 11:59:27 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210960>

Updated version of my documentation patch for git-svn. Thanks to Michael
J Gruber and Eric Wong for helpful comments.

Sebastian Leske (4):
  git-svn: Document branches with at-sign(@).
  Recommend use of structure options for git svn.
  git-svn: Expand documentation for --follow-parent
  git-svn: Note about tags.

 Documentation/git-svn.txt |   84 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 6 deletions(-)

-- 
1.7.10.4
