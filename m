From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git-svn: improve rebase/mkdirs performance
Date: Wed, 11 Nov 2015 20:57:41 +0000
Message-ID: <20151111205741.GA2591@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dair Grant <dair@feralinteractive.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:57:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwcSf-0006h4-D5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbbKKU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:57:42 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51497 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbbKKU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:57:41 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DAA202EF;
	Wed, 11 Nov 2015 20:57:41 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281202>

Hi Jeff/Junio, nothing urgent, please pull at your convenience.
Thanks.

The following changes since commit f34be46e47773d03e9d09641209121591a6b37c8:

  Eleventh batch for 2.7 (2015-11-05 15:26:08 -0800)

are available in the git repository at:

  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to 82625748223dd8977f6c1b8cfe53f7353399bd34:

  git-svn: improve rebase/mkdirs performance (2015-11-10 01:35:01 +0000)

----------------------------------------------------------------
Dair Grant (1):
      git-svn: improve rebase/mkdirs performance

 perl/Git/SVN.pm | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 8 deletions(-)

-- 
EW
