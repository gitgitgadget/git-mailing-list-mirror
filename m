From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntaxmean.
Date: Mon, 20 Aug 2007 11:55:52 +0200
Organization: eudaptics software gmbh
Message-ID: <46C96528.67A3FDAE@eudaptics.com>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 12:00:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN43m-0000KJ-8B
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 12:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXHTKAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 06:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXHTKAb
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 06:00:31 -0400
Received: from main.gmane.org ([80.91.229.2]:45095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbXHTKAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 06:00:30 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IN43G-0007hs-FU
	for git@vger.kernel.org; Mon, 20 Aug 2007 12:00:02 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 12:00:02 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 12:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56205>

Jeff King wrote:
> +               else if (!strncmp(name+1, "1:", 2)) {
> [etc.]

prefixcmp()?

-- Hannes
