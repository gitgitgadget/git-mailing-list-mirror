From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Sat, 26 Oct 2013 22:55:10 +0100
Organization: OPDS
Message-ID: <7B64920A599843F9A122740DFA7A402A@PhilipOakley>
References: <20131016223306.GN9464@google.com><1382732291-5701-1-git-send-email-boklm@mars-attacks.org><xmqq1u39j9hw.fsf@gitster.dls.corp.google.com><20131025225222.GL4589@mars-attacks.org> <xmqqsivphsel.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Vigier" <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Sat Oct 26 23:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaBpC-00047C-1I
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 23:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab3JZVzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 17:55:08 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:61627 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753842Ab3JZVzH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Oct 2013 17:55:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApAGABc5bFJOl3ep/2dsb2JhbABZgweJXbV0CoEfF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMVAwklFAEEGgYHFwYBEggCAQIDAYU4B4IYI7cuj1WDJoENA4kHhhKaeIE6gW07
X-IPAS-Result: ApAGABc5bFJOl3ep/2dsb2JhbABZgweJXbV0CoEfF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMVAwklFAEEGgYHFwYBEggCAQIDAYU4B4IYI7cuj1WDJoENA4kHhhKaeIE6gW07
X-IronPort-AV: E=Sophos;i="4.93,578,1378854000"; 
   d="scan'208";a="435908114"
Received: from host-78-151-119-169.as13285.net (HELO PhilipOakley) ([78.151.119.169])
  by out1.ip05ir2.opaltelecom.net with SMTP; 26 Oct 2013 22:55:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236767>

From: "Junio C Hamano" <gitster@pobox.com>
> Nicolas Vigier <boklm@mars-attacks.org> writes:
>
>> On Fri, 25 Oct 2013, Junio C Hamano wrote:
>>
>>> Nicolas Vigier <boklm@mars-attacks.org> writes:
>>>
>>> > Add the --sticked-long option to output the options in their long 
>>> > form
>>> > if available, and with their arguments sticked.
>>>
>>> Hmph, doesn't verb "stick" conjugate to "(present) stick (past) 
>>> stuck
>>> (pp) stuck"?
>>
>> Ah, yes it seems. I don't know if 'sticked' is also correct or not.
>>
>> However, 'sticked' is the word that is used in 
>> Documentation/gitcli.txt
>> and Documentation/technical/api-parse-options.txt.
>
> Yes, I know. That is why I brought it up before we inflict more
> damage to us.
> --

Isn't the origin of the description that it looks like a stick (cane), 
and 'sticked' is a modern verbing of that form? That's what I'd assumed 
anyway.

Googleing "Sticked option" only linked back to Git.

Philip 
