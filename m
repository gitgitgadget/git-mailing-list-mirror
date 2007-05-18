From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port status
Date: Fri, 18 May 2007 09:22:19 +0200
Organization: eudaptics software gmbh
Message-ID: <464D542B.DF175165@eudaptics.com>
References: <1179339879.31213.24.camel@bruno.nolaviz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 09:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hownb-0007F2-Hb
	for gcvg-git@gmane.org; Fri, 18 May 2007 09:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbXERHVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762000AbXERHVy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 03:21:54 -0400
Received: from main.gmane.org ([80.91.229.2]:47066 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756142AbXERHVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 03:21:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Howmc-0008Er-Fd
	for git@vger.kernel.org; Fri, 18 May 2007 09:21:50 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 09:21:50 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 09:21:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47574>

Alon Ziv wrote:
> What is the current status of the MinGW port?  Are there any plans to
> marge it into the Git main repository anytime soon?

Since I've now access to Windows outside normal work hours, I should be
able to advance the MinGW port 1.5.2 in the next weeks.

I plan to start over with the port, basing it on 'master' instead of
'next' as time permits. Until this work is complete, the current fork
will be updated with new git releases, of course. I may also decide to
give an installer priority over the rebasing work in order to broaden
the user base.

-- Hannes
