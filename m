From: Yann Dirson <ydirson@altern.org>
Subject: [SGIT PATCH 0/3] Assorted fixes
Date: Thu, 07 Jun 2007 00:01:36 +0200
Message-ID: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3Zf-0007yu-1J
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbXFFWBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbXFFWBf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:01:35 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60862 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXFFWBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:01:35 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 69A2C5A1E6;
	Thu,  7 Jun 2007 00:01:34 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3682D1F019;
	Thu,  7 Jun 2007 00:01:37 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49322>

This fixes the issue reported by Andrey Borzenkov, and robustifies
another testcase to catch any similar issue.

Also updates stg-whatchanged, which for some reason had been left
broken.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
