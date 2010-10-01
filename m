From: "Neal Kreitzinger" <neal@rsss.com>
Subject: lost connection in middle of interactive rebase
Date: Thu, 30 Sep 2010 19:53:54 -0500
Message-ID: <i83bg4$rl6$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 02:54:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Ttb-0008Td-79
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 02:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab0JAAyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 20:54:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:49664 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab0JAAyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 20:54:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P1TtU-0008T6-JR
	for git@vger.kernel.org; Fri, 01 Oct 2010 02:54:36 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 02:54:36 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 02:54:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157725>

I use a terminal emulator in windows to connect to a remote linux box.  The 
git repos are on the linux box.  If my network connection drops during the 
middle of my interactive rebase, how do I recover?

v/r,
Neal 
