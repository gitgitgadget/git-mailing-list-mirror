From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Fix typo in git-am: s/Was is/Was it/
Date: Tue, 24 Apr 2007 10:24:58 +0200
Organization: eudaptics software gmbh
Message-ID: <462DBEDA.C5506745@eudaptics.com>
References: <462D5004.1080607@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgGNC-0000Yq-Dh
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 10:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbXDXI1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbXDXI1N
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 04:27:13 -0400
Received: from main.gmane.org ([80.91.229.2]:36237 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031061AbXDXIZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 04:25:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HgGKV-0000OE-1e
	for git@vger.kernel.org; Tue, 24 Apr 2007 10:24:55 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 10:24:55 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 10:24:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45429>

Josh Triplett wrote:
> -                       echo "Patch is empty.  Was is split wrong?"
> +                       echo "Patch is empty.  Was it split wrong?"

The same typo is in two more places, all introduced in 87ab79923.

-- Hannes
