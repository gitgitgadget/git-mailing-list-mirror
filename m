From: Yann Dirson <ydirson@altern.org>
Subject: StGIT: stgitformatversion vs. stgit.formatversion
Date: Sat, 2 Jun 2007 21:16:41 +0200
Message-ID: <20070602191641.GB6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuZ5k-0004s9-Kf
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 21:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762912AbXFBTQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 15:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758490AbXFBTQn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 15:16:43 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:56947 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763637AbXFBTQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 15:16:42 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5D1845A152;
	Sat,  2 Jun 2007 21:16:41 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6D7E61F01B; Sat,  2 Jun 2007 21:16:41 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48950>

What about using branch.*.stgit.formatversion to store the version, to
be consistent with other stgit-specific per-branch settings ?

Bet regards,
-- 
Yann.
