From: Csaba Henk <csaba-ml@creo.hu>
Subject: Re: import files w/ history
Date: Wed, 11 Mar 2009 00:11:34 +0000 (UTC)
Message-ID: <slrngre0d2.1t4t.csaba-ml@beastie.creo.hu>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu> <20090303130046.GA7867@coredump.intra.peff.net> <slrngr299k.1t4t.csaba-ml@beastie.creo.hu> <20090308001021.GA26167@coredump.intra.peff.net> <slrngr99ei.1t4t.csaba-ml@beastie.creo.hu> <20090310180353.GC26351@sigill.intra.peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 01:13:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhC4j-0005QU-Fa
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 01:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbZCKALw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 20:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbZCKALv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 20:11:51 -0400
Received: from main.gmane.org ([80.91.229.2]:40433 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZCKALu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 20:11:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LhC31-00060m-KG
	for git@vger.kernel.org; Wed, 11 Mar 2009 00:11:47 +0000
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 00:11:47 +0000
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 00:11:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112860>

On 2009-03-10, Jeff King <peff@peff.net> wrote:
> I think passing path limiters to filter-branch is just something that
> nobody ever really tried before. I think the solutions are, in order of
> decreasing easiness and increasing difficulty:
>
>   1. document the problem in Documentation/git-filter-branch.txt
>
>   2. create a failing test for it in the test suite
>
>   3. fix the failing test. ;)
>
> Do you want to try a patch for one (or more!) of those?

I'm eager to contribute... next month. I'm pretty much overwhelmed
now. (Accidentally I almost wrote "overclocked" instead of
"overwhelmed"... only if that were true!)

Regards,
Csaba
