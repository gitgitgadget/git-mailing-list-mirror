From: "Zorba" <cr@altmore.co.uk>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 00:48:37 -0000
Message-ID: <gj96pl$885$4@ger.gmane.org>
References: <gj7mmo$fvk$4@ger.gmane.org> <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 01:51:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH6LW-0006F6-O0
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 01:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYL2AtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 19:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYL2AtF
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 19:49:05 -0500
Received: from main.gmane.org ([80.91.229.2]:55102 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbYL2AtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 19:49:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LH6JZ-0006uk-RR
	for git@vger.kernel.org; Mon, 29 Dec 2008 00:49:01 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 00:49:01 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 00:49:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104064>

Hi Sitaram!

Thanks for clearing that one up.

Also, I did wonder about HEAD and head. One can move, the other doesn't! 
(well, acually it does - head moves "forward", as the tip of the branch 
grows)

you gotta love it
:-)

Thanks for your other post/reply too - I will be getting back to you on that 
one

Conor

"Sitaram Chamarty" <sitaramc@gmail.com> wrote in message 
news:slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net...
> On 2008-12-28, Zorba <cr@altmore.co.uk> wrote:
>> Under "Examining an old version without creating a new branch" subsection 
>> in
>> chapter1
>>
>> to aid my understanding, could the statement:
>>
>> "The HEAD then refers to the SHA1 of the commit instead of to a branch, 
>> and
>> git branch shows that you are no longer on a branch:"
>>
>> be restated more explicitly as:
>>
>> "The HEAD then refers to the SHA1 of the commit instead of to a branch 
>> head,
>> and git branch shows that you are no longer on a branch head:"
>
> Sure, but I prefer "tip"; reduces confusion between "head"
> and "HEAD" in spoken descriptions (I teach internal classes
> on git occasionally, once even on a conf call!)
>
> The git glossary makes no mention of "tip", so this is
> probably "unblessed" :-)
> 
