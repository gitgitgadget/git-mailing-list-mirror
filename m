From: walt <wa1ter@myrealbox.com>
Subject: Re: 'bad file' error updating from Linus
Date: Thu, 22 Sep 2005 17:56:34 -0700
Organization: none
Message-ID: <dgvjs3$4so$1@sea.gmane.org>
References: <dgu56t$d2p$1@sea.gmane.org> <509c8057050922054272b823fe@mail.gmail.com> <dgv8jv$amv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 23 03:00:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIbuH-0007H5-Kl
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 02:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVIWA7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 20:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVIWA7K
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 20:59:10 -0400
Received: from main.gmane.org ([80.91.229.2]:49833 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751140AbVIWA7J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 20:59:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EIbsu-00075M-V8
	for git@vger.kernel.org; Fri, 23 Sep 2005 02:57:52 +0200
Received: from adsl-69-234-234-116.dsl.irvnca.pacbell.net ([69.234.234.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 02:57:52 +0200
Received: from wa1ter by adsl-69-234-234-116.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 02:57:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-234-116.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20050922)
In-Reply-To: <dgv8jv$amv$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9157>

walt wrote:
[...]
> After I repeated the cg-update (successfully) I was still left with
> the 'bad file' error.  I tried 'cg-restore' and the error went away.

Oops -- correction!

After encountering the same problem on a different machine, I find
that 'cg-reset' is the one which fixed the error, not 'cg-restore'.

I believe that I tried both commands on the first machine, so I was
uncertain which one actually did the fix.
