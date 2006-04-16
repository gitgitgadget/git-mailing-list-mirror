From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Updated testcases for stgit pull with merge
Date: Sun, 16 Apr 2006 22:31:12 +0200
Message-ID: <20060416203112.10082.9844.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 22:31:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVDuW-0000Ia-Vc
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 22:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDPUbi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 16:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDPUbi
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 16:31:38 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:10195 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750793AbWDPUbh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 16:31:37 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D32D67312E;
	Sun, 16 Apr 2006 22:31:36 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FVE3X-0005DN-FM; Sun, 16 Apr 2006 22:41:15 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18801>

In the previous series, patch 7 mostly demonstrate that I have
missed the appearance of the --merged flag in stgit 0.9 push and pull
commands.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
