From: Csaba Henk <csaba-ml@creo.hu>
Subject: Re: Is rebase always destructive?
Date: Mon, 1 Dec 2008 17:37:43 +0000 (UTC)
Message-ID: <slrngj8884.2srb.csaba-ml@beastie.creo.hu>
References: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu> <20081201121140.GB32415@mail.local.tull.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 18:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Cjq-0003kt-0B
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYLARhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYLARhx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:37:53 -0500
Received: from main.gmane.org ([80.91.229.2]:36906 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbYLARhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:37:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L7CiT-0006iL-Mp
	for git@vger.kernel.org; Mon, 01 Dec 2008 17:37:49 +0000
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:37:49 +0000
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:37:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102069>

On 2008-12-01, Nick Andrew <nick@nick-andrew.net> wrote:
> On Mon, Dec 01, 2008 at 11:41:39AM +0000, Csaba Henk wrote:
>> I can't see any option for rebase which would yield this cp-like
>> behaviour. Am I missing something?
>
> How about this:
>
> git checkout topic
> git branch keepme
> git rebase master

OK, thanks guys, now I'm enlightened (a little bit more than before).

Regards,
Csaba
