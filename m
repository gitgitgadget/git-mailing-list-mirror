From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git-svn updates from Ramkumar
Date: Thu, 15 Jan 2015 09:07:03 +0000
Message-ID: <20150115090703.GA12333@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 10:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBgOZ-0007Fw-57
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 10:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbbAOJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 04:07:06 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39223 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbAOJHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 04:07:03 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA6F1F453;
	Thu, 15 Jan 2015 09:07:03 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262469>

The following changes since commit 563d4e59bd167fe2eecc5480e3841d878b1c8c2b:

  Fifth batch for 2.3 cycle (2015-01-14 12:44:03 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git for-junio

for you to fetch changes up to a94655dcfedc6b266ba32a3d32b0d52a1ce6a928:

  git-svn: make it play nicely with submodules (2015-01-15 08:35:55 +0000)

----------------------------------------------------------------
Ramkumar Ramachandra (2):
      Git::SVN: handle missing ref_id case correctly
      git-svn: make it play nicely with submodules

 git-svn.perl    | 6 ++++++
 perl/Git/SVN.pm | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)
