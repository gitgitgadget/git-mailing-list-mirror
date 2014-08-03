From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Everday contents
Date: Sun, 3 Aug 2014 19:41:30 +0100
Organization: OPDS
Message-ID: <E675F06626AA430EB89D68FF67734824@PhilipOakley>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com><B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley><xmqqegxcdjzl.fsf@gitster.dls.corp.google.com><7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley><xmqqvbqm74v7.fsf@gitster.dls.corp.google.com><xmqqegx95bxc.fsf@gitster.dls.corp.google.com><35435A61F3C04DC8924B2E2329F9461E@PhilipOakley> <xmqqfvhdtrbj.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 20:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XE0ll-0007YN-Le
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbaHCSld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2014 14:41:33 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:31006 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252AbaHCSld (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Aug 2014 14:41:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhMXABGC3lNOl3lZPGdsb2JhbABagw1SV4cvgQTDXYdKBQECAQGBBxcFAQEBATg2g34FAQEEAQgBAS4eAQEhBQYCAwUCAQMVAQslFAEEGgYHAxQGEwgCAQIDAYgpDLVlkCKPTIM2gRwFilWEIoJmolY8Lw
X-IPAS-Result: AhMXABGC3lNOl3lZPGdsb2JhbABagw1SV4cvgQTDXYdKBQECAQGBBxcFAQEBATg2g34FAQEEAQgBAS4eAQEhBQYCAwUCAQMVAQslFAEEGgYHAxQGEwgCAQIDAYgpDLVlkCKPTIM2gRwFilWEIoJmolY8Lw
X-IronPort-AV: E=Sophos;i="5.01,793,1400022000"; 
   d="scan'208";a="710859169"
Received: from host-78-151-121-89.as13285.net (HELO PhilipOakley) ([78.151.121.89])
  by out1.ip01ir2.opaltelecom.net with SMTP; 03 Aug 2014 19:41:31 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254730>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>> Sent: Friday, July 25, 2014 11:08 PM
>> ...
>>>
>>> | Individual Developer (Participant)[[Individual Developer
>>> (Participant)]]
>>> | ------------------------------------------------------------------------
>>
>> ...
>>> | $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL
>>> <5>
>>
>> Would I be right that "ALL" can simply be dropped as something from
>> back then' (13 Dec 2005 v0.99.9-516-g44db136) that I'm ignorant of?
>
> The answer depends on the reason why you want to drop it from the
> example.
>
> That "ALL" is merely a branch name, like "master", etc.

That was the bit I was missing. I had it in my head that it was possibly 
some historic option as it was in caps.

>  I do not
> know how jgarzik names his published branches these days, but back
> then ALL there was something that contained all the topics he wanted
> others to look at.  And the description of <5> explains it to be
> fetching a "specific branch", so that needs to be reworded if we are

I eventually went with using a lower case 'dev' as a nominal branch 
name, and also named it in the updated <5>. However I hadn't actually 
checked if the repos is still active.

> to change the example to "from the default branch of a specific
> repository" or something.
>
>> ...
>>> | <5> fetch from a specific branch from a specific repository and
>>> merge.
>

Thanks.

Philip 
