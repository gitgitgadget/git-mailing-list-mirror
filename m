From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Gitbox
Date: Thu, 14 Apr 2011 16:15:11 +0200
Organization: terreActive AG
Message-ID: <4DA7016F.5070308@terreactive.ch>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com> <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com> <4DA654D4.5040104@medialab.com> <32803572.1897.1302789371873.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Perkins <cperkins@medialab.com>,
	Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <daniel.paul.searles@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Drew Northup <drew.northup@maine.edu>, oleganza@gmail.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Searles <dsearles@medialab.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 16:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QANLQ-0006vu-DM
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 16:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828Ab1DNOQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 10:16:23 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:56454 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab1DNOQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 10:16:22 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <32803572.1897.1302789371873.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171519>

On 04/14/2011 03:55 PM, Martin Langhoff wrote:
> On Wed, Apr 13, 2011 at 9:58 PM, Chris Perkins <cperkins@medialab.com> wrote:
>> Let's look at this at a slighty different way. Let's say someone writes
>> a GUI wrapper for Git, bundles it with Git, and then offers for sale a
>> new proprietary SVC system. They list off all the wonderful features
>> that it has.  On the back page of their website is a small 'Licenses'
>> disclosure and the source code to Git comes with the download buried in
>> a subdirectory.  None of the users realize the software is using Git.
>>
>> Is that a violation of the GPL? I would say that it absolutely is.
> 
> It absolutely is not. Lots of companies do this, and it is perfectly
> kosher -- either bundle the src somewhere or offer a link to download
> the source somewhere.
> 
> While IANAL, and specifically not _your_ lawyer, I have been in this
> field for >10 years, and studied law @ masters level on software
> licensing. You are reading the GPL wrong, and you're not aware of
> widespread industry practices around it.
> 
> Anyone who is curious about this gitbox thing, and interested in
> *facts* instead of fiction, could advance our knowledge with a simple
> procedure:
> 
>  - Download the "free" version (or payfor the paid version!). It's a
> zipfile, no need to hurt any Macs.
> 
>  - See if it includes the src or a link to download the src -- it will
> probably be in a corner of the documentation or license. Maybe there's
> an offer to provide the src in a different way, but a download link is
> the usual trick.
> 
>  - Does the link work? Can you effectively get the src?
> 
>  - Does the src match the binaries you got?

Excellent answer; it would be great to know in detail what would be an
effective (and efficient, if possible) procedure for validating GPL
compliance. Something like a cartoon guide to the GPL for developers
and/or users. I don't even know if my own GPL'ed projects are within the
letter of the law here.

-- 
Victor
