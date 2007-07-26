From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [ANNOUNCE] GIT MinGW port updated to v1.5.3.rc2
Date: Thu, 26 Jul 2007 13:02:53 +0200
Organization: eudaptics software gmbh
Message-ID: <46A87F5D.C5BFC04B@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 13:02:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE17H-0004ug-93
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 13:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbXGZLCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 07:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbXGZLCm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 07:02:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45317 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945AbXGZLCl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 07:02:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IE178-0003AH-8g
	for git@vger.kernel.org; Thu, 26 Jul 2007 13:02:38 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id 3CADC6D9
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 13:02:38 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.362, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53817>

I've just pushed an update of the MinGW port to:

clone:	git://repo.or.cz/git/mingw.git
gitweb:	http://repo.or.cz/w/git/mingw.git

It is now at v1.5.3.rc2.

NOTE! This is only lightly tested, i.e. it passes (most of) the test
suite(*), but it hasn't been used in production, yet.

If you need a known working version, pick the state at the tags

mingw-v1.5.2.4-devel
mingw-v1.5.2.4

(You must fetch mingw-v1.5.2.4-devel explicitly; it is not on any
branch.)

(*) It does pass the tests of the important tools, so...

-- Hannes
PS: I'll be on vacation for a while, hence this hurried update.
