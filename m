From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 16:33:05 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngln7m1.7bm.sitaramc@sitaramc.homelinux.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
 <alpine.LNX.1.00.0812302143210.19665@iabervon.org>
 <alpine.LNX.1.00.0812302236190.19665@iabervon.org>
 <gjfnsb$5ph$4@ger.gmane.org>
 <alpine.LNX.1.00.0812311103000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 17:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI41o-0007IR-LE
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 17:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbYLaQdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 11:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbYLaQdT
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 11:33:19 -0500
Received: from main.gmane.org ([80.91.229.2]:38408 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756025AbYLaQdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 11:33:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LI40Q-0007DO-5M
	for git@vger.kernel.org; Wed, 31 Dec 2008 16:33:14 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 16:33:14 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 16:33:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104281>

On 2008-12-31, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> $ git checkout .                    // tidy up current commit
>> $ git checkout <version>     // roll back

> Either that, or:
>
> $ git checkout <version>
> $ git checkout .
>
> (it doesn't matter whether you get rid of the local modifications and 
> deletions before switching, or switch first, and then get rid of any 
> remaining local modifications and deletions)
>
> You may also want:
>
> $ git clean

I think "git checkout -f <version>" will do *all* of that.
