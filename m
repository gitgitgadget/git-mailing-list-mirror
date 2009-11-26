From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/8] git-merge-file --ours, --theirs
Date: Thu, 26 Nov 2009 16:30:18 +0900
Message-ID: <20091126163018.6117@nanako3.lavabit.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> <7vy6ltdd2l.fsf@alter.siamese.dyndns.org> <20091126153726.6117@nanako3.lavabit.com> <7vvdgxbwav.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 08:30:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDYoC-0002B5-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 08:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZKZHaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 02:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZKZHaU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 02:30:20 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36210 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbZKZHaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 02:30:20 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id A57AA157543;
	Thu, 26 Nov 2009 01:30:26 -0600 (CST)
Received: from 6142.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id BY73N482CVP1; Thu, 26 Nov 2009 01:30:26 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=TDugPUMeDvFLz7ZkydQ0pt4H7CkTvssKhtybQBzB6UVIbPaO22gy74aAfCVggHR65i8XQ3N/UM1860g++MuFRECJMFeuUPPueryfqo0L7MFhbwvQgh9bg4Ap4BwJRe86zuRHPKUbPlAYdiPCmFvwCico36oQUexo6eptwcFAIZQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vvdgxbwav.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133773>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> In any case, where does Avery's credit go?  Is there a point in helping to
> polish others' patches?
>
> It is recoded on the Signed-off-by line.  When somebody passes a patch
> from somebody else, an S-o-b is added for DCO purposes, but it also leaves
> the "patch trail"---these people looked at the patch, spent effort to make
> sure it is suitable for inclusion by reviewing, polishing, and enhancing.
> A subsystem maintainer, or anybody who helps to polish others
> contribution, may not necessarily have his name as the "author" of the
> patch, and if the patch forwarding is done via e-mail, his name won't be
> on the "committer" line either.  But the contribution is still noted and
> appreciated, and the hint to pay attention to is by counting non-author
> S-o-b and Tested-by lines in the commit messages.

I understand. Thank you for a detailed explanation. 

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
