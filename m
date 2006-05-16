From: Li Yang-r58472 <LeoLi@freescale.com>
Subject: newbie question
Date: Tue, 16 May 2006 15:03:27 +0800
Message-ID: <9FCDBA58F226D911B202000BDBAD467308146E@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
X-From: git-owner@vger.kernel.org Tue May 16 09:03:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fftal-0003Jn-RH
	for gcvg-git@gmane.org; Tue, 16 May 2006 09:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWEPHDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 03:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWEPHDh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 03:03:37 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:3065 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751596AbWEPHDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 03:03:36 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id k4G8J8IV007193
	for <git@vger.kernel.org>; Tue, 16 May 2006 02:19:08 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net [10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4G75kPN020955
	for <git@vger.kernel.org>; Tue, 16 May 2006 02:05:47 -0500 (CDT)
Received: by zch01exm40.ap.freescale.net with Internet Mail Service (5.5.2657.72)
	id <47PLX3YJ>; Tue, 16 May 2006 15:03:32 +0800
To: git@vger.kernel.org
X-Mailer: Internet Mail Service (5.5.2657.72)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20108>

I just starting to use git recently.  I have setup a public repository, and pushed cloned open source repository to it.  As most documents suggested, I need to run a repack on the public repository.  Normally git-repack is run in the source directory(the parent directory of .git).  Considering the public repository, there is no source directory and the *.git is the uppest level directory.  Where am I supposed to run the git-repack command?
