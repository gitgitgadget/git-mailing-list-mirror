From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Mark Levedahl's gitk patches
Date: Mon, 25 Jun 2007 18:05:24 +0200
Organization: eudaptics software gmbh
Message-ID: <467FE7C4.5E421535@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2r3y-0008R7-TD
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 18:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXFYQFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbXFYQFN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 12:05:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37281 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbXFYQFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 12:05:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I2r3t-0000fl-TI; Mon, 25 Jun 2007 18:05:10 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9288229AB; Mon, 25 Jun 2007 18:05:09 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.031
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50904>

Is there a chance that we get Mark Levedahl's gitk patches into 1.5.3:

gitk - Allow specifying tabstop as other than default 8 characters.
    http://article.gmane.org/gmane.comp.version-control.git/47844

gitk - Update fontsize in patch / tree list
    http://article.gmane.org/gmane.comp.version-control.git/47845

gitk - Make selection highlight color configurable
    http://article.gmane.org/gmane.comp.version-control.git/47851

I'm mostly interested in the last one because the highlight color is
also a serious issue under MinGW.

-- Hannes
