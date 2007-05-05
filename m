From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/2] Improving patchlogs
Date: Sat, 05 May 2007 16:00:18 +0200
Message-ID: <20070505135830.5194.90861.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkMhO-0007qT-79
	for gcvg-git@gmane.org; Sat, 05 May 2007 18:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423395AbXEEQBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 12:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423283AbXEEQBC
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 12:01:02 -0400
Received: from postfix1-g20.free.fr ([212.27.60.42]:49941 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423395AbXEEQBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 12:01:00 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 9CDCAF27B80
	for <git@vger.kernel.org>; Sat,  5 May 2007 16:02:00 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9F1945F26B;
	Sat,  5 May 2007 16:00:59 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 76B0C1F15F;
	Sat,  5 May 2007 16:00:18 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46258>

This is a first pass on recording missing history in the patchlogs, as
described in a former email.  At least "sync" still has unrecorded
(merge) information.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
