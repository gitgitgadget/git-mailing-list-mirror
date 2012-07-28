From: Jeff King <peff@peff.net>
Subject: [PATCH] t: add missing executable bit to t7409
Date: Sat, 28 Jul 2012 11:18:29 -0400
Message-ID: <20120728151829.GA1903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel =?utf-8?B?R3Jhw7Fh?= <dangra@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 17:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv8ms-0002hB-Pj
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab2G1PSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 11:18:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40040 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab2G1PSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:18:33 -0400
Received: (qmail 31690 invoked by uid 107); 28 Jul 2012 15:18:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jul 2012 11:18:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2012 11:18:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202444>


Signed-off-by: Jeff King <peff@peff.net>
---
 0 files changed
 mode change 100644 => 100755 t/t7409-submodule-detached-worktree.sh

diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule-detached-worktree.sh
old mode 100644
new mode 100755
-- 
1.7.12.rc0.15.g2184f59
