From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Jun 2007 09:12:44 +0200
Organization: eudaptics software gmbh
Message-ID: <4670EA6C.C9559B61@eudaptics.com>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net> <7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	 <7vveepz8pr.fsf@assigned-by-dhcp.cox.net> <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	 <7vejl0546b.fsf@assigned-by-dhcp.cox.net> <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	 <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net> <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <Pine.LNX.4.64.0706132322210.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 09:11:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyjUL-00049z-Jy
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 09:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbXFNHLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 03:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXFNHLY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 03:11:24 -0400
Received: from main.gmane.org ([80.91.229.2]:44571 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXFNHLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 03:11:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HyjUI-0001gu-Bx
	for git@vger.kernel.org; Thu, 14 Jun 2007 09:11:22 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 09:11:22 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 09:11:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50173>

Johannes Schindelin wrote:
> Next plans are: make filter-branch a misnomer: actually be able to rewrite
> more than one branch in one go, writing the outcome to the refs/rewritten/
> namespace. IIRC that was Hannes' project, but I'll gladly step in there if
> need be.

Be my guest. Even though I said "my plan" in that post
http://article.gmane.org/gmane.comp.version-control.git/49292
this was meant as a proposal. I'm not working on the topic at the
moment.

-- Hannes
