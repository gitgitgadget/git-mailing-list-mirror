From: Eric Raible <raible@gmail.com>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 19:52:05 +0000 (UTC)
Message-ID: <loom.20100623T214603-16@post.gmane.org>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>  <7vzkylejbf.fsf@alter.siamese.dyndns.org> <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>  <20100623183050.GA20842@coredump.intra.peff.net> <AANLkTin-MEBUYheTkFbeKIBj5peVV-sPa7hZSg-wMgBi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 23 21:52:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVze-0000di-9g
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab0FWTwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:52:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:45822 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405Ab0FWTwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:52:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ORVzZ-0000WW-B1
	for git@vger.kernel.org; Wed, 23 Jun 2010 21:52:13 +0200
Received: from 209-183-055-113.mobile.mymmode.com ([209-183-055-113.mobile.mymmode.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 21:52:13 +0200
Received: from raible by 209-183-055-113.mobile.mymmode.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 21:52:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 209.183.55.113 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149544>

Bruce Korb <bruce.korb <at> gmail.com> writes:

> P.S. Is it really so rare that someone would want this info that it should
> wind up being so obscure?  I now have a new alias:
> 
>    alias git-ls-staged="git diff --cached --name-only"

Both: gitk and "git gui" show this quite clearly.
