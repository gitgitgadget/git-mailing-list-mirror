From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 15/15] Treat "diff --combined" the same as "diff --cc"
Date: Sat, 13 Dec 2008 00:11:37 +0100
Message-ID: <200812130011.37854.robin.rosenberg.lists@dewire.com>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org> <1229049981-14152-15-git-send-email-spearce@spearce.org> <1229049981-14152-16-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 00:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBHC4-0001jz-Oo
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 00:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbYLLXLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 18:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYLLXLn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 18:11:43 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:60997 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877AbYLLXLm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 18:11:42 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A979500521C0B9; Sat, 13 Dec 2008 00:11:39 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1229049981-14152-16-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102964>


The source for CombinedFileHeader would be nice. 

Btw, I moved the patches to the test-rsrc directory to make it possible
to run the unit tests throuh maven.

-- robin
