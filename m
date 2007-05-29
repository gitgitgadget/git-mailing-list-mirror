From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: What's new in git-gui.git
Date: Tue, 29 May 2007 09:46:54 +0200
Organization: eudaptics software gmbh
Message-ID: <465BDA6E.C56EC2EB@eudaptics.com>
References: <20070528224949.GC7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 09:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HswPf-0000Y2-Md
	for gcvg-git@gmane.org; Tue, 29 May 2007 09:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbXE2HqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 03:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXE2HqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 03:46:16 -0400
Received: from main.gmane.org ([80.91.229.2]:56777 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbXE2HqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 03:46:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HswP8-00056I-33
	for git@vger.kernel.org; Tue, 29 May 2007 09:46:06 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 09:46:06 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 09:46:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48671>

"Shawn O. Pearce" wrote:
>  - Preserve author during amend

... and author date - at least if no additional changes were staged.
(Quite often I just want to tweak the commit message, mostly after
dissecting a topic branch.)

-- Hannes
