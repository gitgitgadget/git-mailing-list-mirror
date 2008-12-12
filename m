From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: [PATCH] Fix t7606 on Cygwin: for some reasont it does not recognize a "." in PATH
Date: Fri, 12 Dec 2008 14:01:14 +0000 (UTC)
Message-ID: <loom.20081212T135919-571@post.gmane.org>
References: <81b0412b0812120428mc85ae84r260b722022dc3449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 15:02:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB8bL-0008Vo-0K
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 15:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbYLLOBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 09:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758173AbYLLOBY
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 09:01:24 -0500
Received: from main.gmane.org ([80.91.229.2]:44888 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757842AbYLLOBX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 09:01:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LB8a2-0006k4-1H
	for git@vger.kernel.org; Fri, 12 Dec 2008 14:01:22 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 14:01:22 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 14:01:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/528.5 (KHTML, like Gecko) Iron/0.4.155.0 Safari/528.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102897>

Alex Riesen <raa.lkml <at> gmail.com> writes:

> 
> The test uses the dot to add custom merge strategies
> ---
>  t/t7606-merge-custom.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Attachment (0001-Fix-t7606-on-Cygwin-it-does-not-recognize-a-.-in.patch): 
application/octet-stream, 759 bytes

Any special reason why you sent this as an (normally frowned-upon) attachment ?

For me, however, this would be the way to go to be able to download the patch 
without any hassle. (see my other post).

Regards,
  Stefan
