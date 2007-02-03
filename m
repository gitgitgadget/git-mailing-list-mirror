From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Minor stgit touches
Date: Sat, 03 Feb 2007 17:04:15 +0100
Message-ID: <20070203160257.32054.17787.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 17:05:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNO8-0007XJ-RJ
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946473AbXBCQFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 11:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992429AbXBCQFM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:05:12 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:60071 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946473AbXBCQFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:05:11 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id DB4B3553C;
	Sat,  3 Feb 2007 17:05:09 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 972161F07F;
	Sat,  3 Feb 2007 17:04:15 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38569>

Here is one bugfix, and the addition of a notice to the user when we
fallback to "origin" as a parent because of the lack of config
parameters.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
