From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/3] cleanup "show" and friends
Date: Thu, 28 Jun 2007 23:43:59 +0200
Message-ID: <20070628214242.26983.99859.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 23:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I41nK-0002wS-03
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 23:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764725AbXF1VoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 17:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762391AbXF1VoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 17:44:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42448 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764003AbXF1VoP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 17:44:15 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0F82473B7;
	Thu, 28 Jun 2007 23:44:14 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id CDA7D1F084;
	Thu, 28 Jun 2007 23:43:59 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51131>

The following series implements the suggestion for #8453 outlined in
my previous mail, and adds a minor improvement for hidden patches.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
