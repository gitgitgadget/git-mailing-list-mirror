From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Tutorial problem a/a a/b
Date: Thu, 28 Jul 2005 16:15:13 -0500
Message-ID: <1122585313.12374.16.camel@localhost.localdomain>
References: <1122582005.12374.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 28 23:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyFpC-0002SX-Ie
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 23:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVG1VS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVG1VQa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 17:16:30 -0400
Received: from zealot.progeny.com ([216.37.46.162]:63153 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262296AbVG1VPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 17:15:15 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP id 4E8BA636A4
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:15:14 -0500 (EST)
To: git@vger.kernel.org
In-Reply-To: <1122582005.12374.6.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-07-28 at 15:20 -0500, Darrin Thompson wrote:
> In the tutorial the user is instructed to create two files: a and b.
> 
> Then when the user diffs the files, they see this:
> 
> diff --git a/a b/a
> 
> That really confused somebody and I had to untangle their brain. :-) I
> don't have a patch for it, but thought I'd point out: perhaps a and b
> aren't the best example filenames given git's diff format. :-D
> 

Note: I've been fielding a few questions while some Progeny folks get up
to speed on git.

I had to explain what was meant by <tree-ish> in some usage messages.
Perhaps those should be spelled out as "tree, tag, or commit id"?

[Sorry this is a whine and not a patch.]

--
Darrin
