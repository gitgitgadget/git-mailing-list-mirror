From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Mon, 21 Jan 2008 07:42:01 +0100
Message-ID: <209F2074-DD8D-429A-95AA-6FB484852E4E@zib.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <m3tzlbl6he.fsf@roke.D-201> <7vk5m6by9f.fsf@gitster.siamese.dyndns.org> <7bfdc29a0801202155o471db5c7v38e1a587115abf36@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Imran M Yousuf <imyousuf@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 07:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGqLk-0004mv-8O
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 07:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbYAUGlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 01:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbYAUGlK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 01:41:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:60252 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159AbYAUGlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 01:41:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0L6f0mU026573;
	Mon, 21 Jan 2008 07:41:00 +0100 (CET)
Received: from [192.168.178.21] (brln-4db939bb.pool.einsundeins.de [77.185.57.187])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0L6ex2r021301
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 21 Jan 2008 07:40:59 +0100 (MET)
In-Reply-To: <7bfdc29a0801202155o471db5c7v38e1a587115abf36@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71229>


On Jan 21, 2008, at 6:55 AM, Imran M Yousuf wrote:

> On Jan 19, 2008 3:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Here is an update to the list I sent earlier.  Topics that I
>>>> thought may deserve attention, discussion and eventual inclusion
>>>> but are not 1.5.4 material.
>>>>
>>>> I think some of them actually have a slight chance of being
>>>> 1.5.4 material, if interested parties present good enough
>>>> arguments that they are actually good and safe bugfixes.
>>>
>>>>  * submodule subcommand parser fix for "git submodule add init
>>>>    update" (Imran M Yousuf and me)
>>>
>>> Isn't it a bugfix, and shouldn't it for this reason be in 1.5.4?
>>
>> Yeah, I tend to agree.  I was waiting for an Ack or failure
>> report from Imran, as I turned the table around.
>
> Sorry I forgot to mention it earlier, your patches worked fine :),
> thank you once again for the help.

I read through the patch and it looks good.

I think the documentation should be slightly adjusted.  Patch follows
as a reply to this mail.

	Steffen
