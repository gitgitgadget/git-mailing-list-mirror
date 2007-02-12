From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] A couple of small StGit improvements
Date: Mon, 12 Feb 2007 22:08:18 +0100
Message-ID: <20070212210628.28413.87407.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 22:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGiQh-0003QG-JQ
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 22:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408AbXBLVJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965409AbXBLVJk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 16:09:40 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:36915 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965408AbXBLVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 16:09:39 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7D09C43927;
	Mon, 12 Feb 2007 22:09:38 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 48BE71F01C;
	Mon, 12 Feb 2007 22:08:19 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39438>

Finally I should never have dropped --merged when copying pull.py to
rebase.py, I missed it today.  And shortcut commands are nice on
command line, but not within help strings.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
