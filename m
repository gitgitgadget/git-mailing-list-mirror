From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Mon, 28 Jan 2013 21:19:17 -0000
Organization: OPDS
Message-ID: <2CAD0EB4A81B49E6AAF06BB29A4C8E05@PhilipOakley>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com><5F78436DB1994B6DA686EC1BFA96B54E@PhilipOakley> <CAJDDKr4BT_1YnnfJv-YFHOpWhYpuA_5CMRw_hPTiowMr49RLKQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"John Keeping" <john@keeping.me.uk>
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzw6z-0008AB-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab3A1VTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:19:08 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:59355 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754311Ab3A1VTG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 16:19:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhgKAD7qBlFcHKA3/2dsb2JhbABEhkaFPbFTA3wXc4IZBQEBBQgBARkVHgEBIQsCAwUCAQMOBwECAgIFIQICFAEECBIGBxcGEwgCAQIDAYduAxOtcYheDYlVgSOKbYEfgmMyYQONfoY5jQyFEoJ3
X-IronPort-AV: E=Sophos;i="4.84,554,1355097600"; 
   d="scan'208";a="407217691"
Received: from host-92-28-160-55.as13285.net (HELO PhilipOakley) ([92.28.160.55])
  by out1.ip05ir2.opaltelecom.net with SMTP; 28 Jan 2013 21:19:03 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214875>

From: "David Aguilar" <davvid@gmail.com>
Sent: Monday, January 28, 2013 9:16 AM
> On Mon, Jan 28, 2013 at 12:20 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "David Aguilar" <davvid@gmail.com>
>> Sent: Monday, January 28, 2013 12:52 AM
>>
>>> This is round two of this series.
>>> I think this touched on everything brought up in the code review.
>>> 4/4 could use a review as I'm not completely familiar with the
>>> makefile dependencies, though it seems to work correctly.
>>
>>
>> Does this 4/4 have any effect on the Msysgit / Git for Windows 
>> documentation
>> which simply refers [IIRC] to HTML documenation made by Junio?
>>
>> That is, how easy is it to create a 'default' set of docs, rather 
>> than
>> personalised documenation. Or have I misunderstood how it is working?
>
> It doesn't have any effect on Msysgit. The resulting documentation
> lists all available tools, on all platforms.
>
That's useful to know. I must have misunderstood one of the earlier 
messages suggesting it would also list all the users other (non typical) 
installed mergetools and hence add them into the documentation.

Philip 
