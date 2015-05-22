From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 07:59:56 +0100
Organization: OPDS
Message-ID: <6259B4241C4241D8A9104D3A49C36957@PhilipOakley>
References: <1432163517-22785-1-git-send-email-sbeller@google.com><9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley> <CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>,
	"Petr Baudis" <pasky@suse.cz>, "Heiko Voigt" <hvoigt@hvoigt.net>
To: "Stefan Beller" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 09:00:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvgw5-0001Cm-0r
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 09:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbbEVG75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:59:57 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:56555 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918AbbEVG74 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 02:59:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BzLAAC015VPKIJFlxcgxCBMoMfgy5twzAEBAKBPE0BAQEBAQEHAQEBAUEkG0EBAgKDVwUBAQEBAwgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiB+uW4ZUnXGBIYoZhQWCby+BFgWSfXmhOIEEZkMcgVM9MYJHAQEB
X-IPAS-Result: A2BzLAAC015VPKIJFlxcgxCBMoMfgy5twzAEBAKBPE0BAQEBAQEHAQEBAUEkG0EBAgKDVwUBAQEBAwgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiB+uW4ZUnXGBIYoZhQWCby+BFgWSfXmhOIEEZkMcgVM9MYJHAQEB
X-IronPort-AV: E=Sophos;i="5.13,474,1427756400"; 
   d="scan'208";a="592842948"
Received: from host-92-22-9-162.as13285.net (HELO PhilipOakley) ([92.22.9.162])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 22 May 2015 07:59:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269697>

From: "Stefan Beller" <sbeller@google.com>
> On Thu, May 21, 2015 at 1:03 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>>> +Submodules are not to be confused with remotes, which are meant
>>> +mainly for branches of the same project;
>>
>>
>> This use of 'branches' didn't work for me. "remotes are meant mainly 
>> for
>> branches of the same project" ?
>>
>
> Maybe
>
>    Submodules should not be confused with remote repositories, which 
> are
>    meant to track the same repository, just at another location; ...
>
> ? Though I'm not yet completely happy with that either.
>

I like that better. I was going to check what the git glossary said a 
remote was, but the commute to work beckons...

Philip 
