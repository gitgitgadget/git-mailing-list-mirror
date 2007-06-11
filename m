From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/4] Cleanups of the Series object.
Date: Mon, 11 Jun 2007 02:33:20 +0200
Message-ID: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXqa-0004M4-0A
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761527AbXFKAdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761092AbXFKAdQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:33:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46275 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760576AbXFKAdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 20:33:16 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 16323389D;
	Mon, 11 Jun 2007 02:33:15 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A93A71F08A;
	Mon, 11 Jun 2007 02:33:20 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49803>

These cleanups and under-the-hood evolutions are mostly driven by my
(still preliminar) work at allowing to work on several stacks at a
time using hydras.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
