From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/3] Update to stgit parent tracking
Date: Fri, 02 Feb 2007 00:47:54 +0100
Message-ID: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClfc-0001Zq-Cf
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbXBAXsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbXBAXsq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:48:46 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:59958 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbXBAXsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:48:45 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 8E711554F;
	Fri,  2 Feb 2007 00:48:44 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id E23961F07F;
	Fri,  2 Feb 2007 00:47:54 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38433>

The following series brings a couple of improvements to parent- and
remote-handling stuff, including addressing the FIXME you pointed to
in your reply.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
