From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: MinGW port updated to 1.5.2
Date: Fri, 25 May 2007 10:26:13 +0200
Organization: eudaptics software gmbh
Message-ID: <46569DA5.4F0EBF9A@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 10:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrV7N-0002J7-AG
	for gcvg-git@gmane.org; Fri, 25 May 2007 10:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbXEYIZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 04:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbXEYIZc
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 04:25:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17675 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbXEYIZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 04:25:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HrV72-0003LD-4A
	for git@vger.kernel.org; Fri, 25 May 2007 10:25:29 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id E4D3554D
	for <git@vger.kernel.org>; Fri, 25 May 2007 10:25:27 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.036
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48345>

This minute I've pushed the MinGW port, which is now at 1.5.2 to:

gitweb:     http://repo.or.cz/w/git/mingw.git
pull/clone: git://repo.or.cz/git/mingw.git

In addition to the 1.5.2 features, the progress indicator is shown in
more places (most notably when "Counting objects"), and
GIT_EXTERNAL_DIFF works now.

-- Hannes
