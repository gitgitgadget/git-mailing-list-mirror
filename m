From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/3] Handful of cvsexportcommit patches
Date: Sat, 27 May 2006 18:36:41 +0200
Message-ID: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 18:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk1ky-0000P6-OK
	for gcvg-git@gmane.org; Sat, 27 May 2006 18:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWE0QfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 12:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWE0QfL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 12:35:11 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:25766 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964902AbWE0QfK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 12:35:10 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id B3F7D256C1;
	Sat, 27 May 2006 18:35:09 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fk1wq-0006uV-Ka; Sat, 27 May 2006 18:47:32 +0200
To: junkio@cox.net
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20860>

The following series contains a collection of cvsexportcommit changes I have at hand.
The support for creating directory files was only tested on a 1.0.7 code base, I'll
have to shake this one before being confident with it, but that will be done next week.
In the meantime, it may still be of interest for someone :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
