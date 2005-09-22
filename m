From: walt <wa1ter@myrealbox.com>
Subject: Re: 'bad file' error updating from Linus
Date: Thu, 22 Sep 2005 14:44:34 -0700
Organization: none
Message-ID: <dgv8jv$amv$1@sea.gmane.org>
References: <dgu56t$d2p$1@sea.gmane.org> <509c8057050922054272b823fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 22 23:49:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIYv0-0000PT-KT
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 23:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVIVVrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVIVVrp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 17:47:45 -0400
Received: from main.gmane.org ([80.91.229.2]:14264 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751203AbVIVVrp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 17:47:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EIYtO-0008QJ-7V
	for git@vger.kernel.org; Thu, 22 Sep 2005 23:46:10 +0200
Received: from adsl-69-234-234-116.dsl.irvnca.pacbell.net ([69.234.234.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 23:46:10 +0200
Received: from wa1ter by adsl-69-234-234-116.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 23:46:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-234-116.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20050922)
In-Reply-To: <509c8057050922054272b823fe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9146>

porpen@gmail.com wrote:
> You aren't alone.  I had a look at http://www.kernel.org/git/  only to
> find that the 2.6 kernel has been taken off the list...  /me thinks
> Linus is pushing an update as I type...

I think it was a disk failure, but no matter -- it's fixed now.

For the benefit of future googlers with the same 'bad file' error:

After I repeated the cg-update (successfully) I was still left with
the 'bad file' error.  I tried 'cg-restore' and the error went away.
Very nifty!
