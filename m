From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: clone --bare vs push
Date: Mon, 03 Jan 2011 23:29:27 -0600
Message-ID: <4D22B037.9010408@gmail.com>
References: <AANLkTi=+cRqD_CDFyaYj8uWOxUA1+5Dgr_pv1guaaT40@mail.gmail.com> <AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com> <ifu8d2$t61$1@dough.gmane.org> <20110104045839.GA8225@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Levend Sayar <levendsayar@gmail.com>, git@vger.kernel.org,
	Neal Kreitzinger <neal@rsss.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 06:30:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZzTf-0004Q2-H1
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 06:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab1ADFaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 00:30:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:60023 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab1ADFaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 00:30:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PZzT7-00046l-1T
	for git@vger.kernel.org; Tue, 04 Jan 2011 06:30:01 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 06:30:01 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 06:30:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110104045839.GA8225@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164479>

On 1/3/2011 10:58 PM, Jonathan Nieder wrote:
> Neal Kreitzinger wrote:
>
>> you can also use the file:// url format to create a complete copy and not
>> use hardlinks.  see git-clone manpage.
>>
>> e.g. git clone --bare file:///fullpathto/X y.git
>
> Thanks, that's useful; cc-ing Levend.
>
> [Side note: I wrote in the past:
>
> | In traditional newsgroups it seems to be most common to just reply to
> | the author by mail or follow-up to the group, so I wouldn't feel too
> | bad.
>
> but probably that was unclear of me.  The convention on _this_ list[1] is
> to reply to all participants in a thread, so new participants do not
> need to subscribe if they don't want to.  Thunderbird (e.g.) seems to
> be good at doing that for what it's worth.]
>
> [1] at least as I perceive it; please feel free to correct me if I
> have misunderstood

This is a "reply all" from thunderbird.  This looks like it is doing the 
cc correctly...

v/r,
Neal
