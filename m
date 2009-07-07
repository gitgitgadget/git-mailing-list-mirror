From: Yann Dirson <ydirson@altern.org>
Subject: [PATCHv2 0/4] First set of improvements to git-svn user doc
Date: Tue,  7 Jul 2009 15:02:13 +0200
Message-ID: <cover.1246971377.git.ydirson@altern.org>
References: <20090706222028.GB11043@dcvr.yhbt.net>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 15:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOAOt-0005xG-Cj
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbZGGNHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 09:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbZGGNHr
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:07:47 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:57023 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756592AbZGGNHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 09:07:46 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6C2039400FE;
	Tue,  7 Jul 2009 15:07:42 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 8A2A1940150;
	Tue,  7 Jul 2009 15:07:40 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 131551F0A2; Tue,  7 Jul 2009 15:02:19 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <20090706222028.GB11043@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122842>

This series is a minor update which should be better for inclusion:
I had missed a few recently-introduced dash-form of commands while
rebasing.  It also adds Acked-by: Eric to the series.

Yann Dirson (4):
  git-svn.txt: stop using dash-form of commands.
  git-svn.txt: make formatting more consistent.
  git-svn.txt: fix fetch flags incorrectly documented as init flags.
  git-svn.txt: fix description of fetch flags accepted by clone.

 Documentation/git-svn.txt |  347 ++++++++++++++++++++++-----------------------
 1 files changed, 169 insertions(+), 178 deletions(-)
