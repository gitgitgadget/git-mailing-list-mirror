From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 09:47:42 +0100
Organization: eudaptics software gmbh
Message-ID: <45BF062E.37A4327A@eudaptics.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <20070129223513.GA31372@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 09:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBoh4-0002jc-CJ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbXA3IuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXA3IuH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:50:07 -0500
Received: from main.gmane.org ([80.91.229.2]:45841 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbXA3IuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:50:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HBogk-0003YF-Fj
	for git@vger.kernel.org; Tue, 30 Jan 2007 09:50:02 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 09:50:02 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 09:50:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38140>

"Shawn O. Pearce" wrote:
> Last night I pushed out a number of changes to avoid cygpath when
> we don't have it in PATH (commit 20ddfcaa).  Were you testing with
> that version, or something earlier?

yes, I tested that version. The new incremental blame works, too.

-- Hannes
