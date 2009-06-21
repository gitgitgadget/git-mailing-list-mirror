From: Yann Dirson <ydirson@altern.org>
Subject: [WIP PATCH 0/2] Some documentation improvements for git-svn
Date: Mon, 22 Jun 2009 00:48:39 +0200
Message-ID: <1245624521-30769-1-git-send-email-ydirson@altern.org>
References: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 00:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIVqT-0005jy-Qx
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 00:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbZFUWsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbZFUWsk
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 18:48:40 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58776 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbZFUWsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 18:48:39 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 0B97B9400AD;
	Mon, 22 Jun 2009 00:48:35 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1F2FB940067;
	Mon, 22 Jun 2009 00:48:33 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2812E1F0D4; Mon, 22 Jun 2009 00:49:07 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121997>

This is a first step towards improving the git-svn documentation, as
previously announced.  It is by far not complete, but I'd prefer to here
any objections to the way I change things before I have invested too
much time in this :)

Yann Dirson (2):
  git-svn: add some in-code documentation (options-related).
  git-svn user documentation update.

 Documentation/git-svn.txt |  463 ++++++++++++++++++++++++---------------------
 git-svn.perl              |    8 +
 2 files changed, 253 insertions(+), 218 deletions(-)
