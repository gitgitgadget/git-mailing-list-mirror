From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 14:02:37 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpqpjt.j03.sitaramc@sitaramc.homelinux.net>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
 <871vtudabm.fsf@iki.fi>
 <43d8ce650902190152t6162593x8d0920be0e6d7a6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 15:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9Vl-00064F-IM
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBSOCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbZBSOCw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:02:52 -0500
Received: from main.gmane.org ([80.91.229.2]:57545 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbZBSOCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:02:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1La9UI-0001o0-L4
	for git@vger.kernel.org; Thu, 19 Feb 2009 14:02:50 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 14:02:50 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 14:02:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110699>

On 2009-02-19, John Tapsell <johnflux@gmail.com> wrote:
> 2009/2/19 Teemu Likonen <tlikonen@iki.fi>:
>> I think it's better to use aliases for this kind of personal things:
>>
>>    git config --global alias.my-rebase "rebase -i HEAD~10"

perfectly reasonable

> I'm trying to make git more obvious and easier to use, rather than
> find any solution :-)

I'm sorry I don't know what is obvious about any specific
number, unless it is 42 ;-)

Seriously, forcing *some* default simply because some people
use it with that value does not make it obvious to anyone
but those few.  I'm not even arguing about the number; I'd
hate to have *any* number be the default.
