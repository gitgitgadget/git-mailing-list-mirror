From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to git checkout a orgin(unstage) version file in another directoy?
Date: Thu, 17 Feb 2011 13:30:31 +0000 (UTC)
Message-ID: <loom.20110217T142701-926@post.gmane.org>
References: <loom.20110217T074533-358@post.gmane.org> <4D5CDBAD.4050700@drmicha.warpmail.net> <loom.20110217T110820-459@post.gmane.org> <4D5D1603.6040208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 14:30:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq3wY-0008MY-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 14:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab1BQNao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 08:30:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:48978 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab1BQNan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 08:30:43 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pq3wQ-0008JA-2g
	for git@vger.kernel.org; Thu, 17 Feb 2011 14:30:42 +0100
Received: from 218.107.217.218 ([218.107.217.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 14:30:42 +0100
Received: from zhangchunlin by 218.107.217.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 14:30:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 218.107.217.218 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167085>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> So, you don't really want to "checkout" the file. You only want its
> contents without updating the index. (My brain is apparently too
> git-rotted already to even think of the possibility that you didn't mean
> "our checkout" by "checkout").
Yes,I am a git newbie,a little bit misunderstanding about the git-checkout.
> 
> Jonathan gave you the perfect solution for what you want.
Anyway,your answer make me more familiar about git cli usage.
> 
> Michael
> 
