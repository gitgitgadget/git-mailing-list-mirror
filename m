From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] StGit testcases for new issues
Date: Wed, 14 Mar 2007 22:34:54 +0100
Message-ID: <20070314213020.13492.24840.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRb7a-0006uK-Bn
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbXCNVe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbXCNVe4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:34:56 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58704 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422665AbXCNVez (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:34:55 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 673B78207;
	Wed, 14 Mar 2007 22:34:54 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 1E5031F094;
	Wed, 14 Mar 2007 22:34:54 +0100 (CET)
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42236>

Here are testcases for the 2 issues involving stack deletion and the
branch that happens to be named "master", that I just reported in the
gna! tracker.

It is probably not a good idea to apply them to stgit's master, but it
could be useful to setup a (rewinding) branch to hold such testcases.
Maybe having testcases readily available would help/encourage people
to step into the project and start to contribute by a bugfix ?

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
