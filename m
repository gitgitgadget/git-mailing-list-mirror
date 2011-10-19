From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Compiling on Windows
Date: Wed, 19 Oct 2011 22:46:34 +0100
Organization: OPDS
Message-ID: <2015B7F2CEAE4B449EA4EF744F9B8FD9@PhilipOakley>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com> <4E9E811C.10205@lyx.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Git MsysGit" <msysgit@googlegroups.com>, <git@vger.kernel.org>
To: "Andrew Ardill" <andrew.ardill@gmail.com>,
	"Vincent van Ravesteijn" <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdyC-0000cI-2n
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab1JSVqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:46:35 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:59922 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445Ab1JSVqf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 17:46:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhobADpEn05cHKAK/2dsb2JhbABEhHWFTZ01gQqBBgQDAQIBgV4BBAEBBAEIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBBoGBwkBDQYBEggCAQIDAYU3B4IpCAIGpCSSBIEwhVczYQSlVg
X-IronPort-AV: E=Sophos;i="4.69,374,1315177200"; 
   d="scan'208";a="358397568"
Received: from host-92-28-160-10.as13285.net (HELO PhilipOakley) ([92.28.160.10])
  by out1.ip05ir2.opaltelecom.net with SMTP; 19 Oct 2011 22:46:33 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183979>

From: "Vincent van Ravesteijn" <vfr@lyx.org>
> Op 18-10-2011 6:08, Andrew Ardill schreef:
>> Hi list, I have been searching for details on what is required to
>> compile on Windows, but haven't found anything conclusive. Perhaps
>> there is something on the wiki, but unfortunately it is down at the
>> moment.
>>
>> Can anyone point me in the right direction? I would like to be able to
>> compile and test topic branches, and perhaps even do some dev work on
>> my windows machine.
>
> I once wrote a little step-by-step tutorial on how to compile the native 
> Windows Git with MSVC (Express).
>
> http://blog.vfrconsultancy.nl/#post0

The blog post filled in a few gaps in the Msysgit README instructions about 
where to place the various downloads described.

>
> Be aware that git runs without apparent problems, but that all 
> functionality written in shell scripts can't be used.
>
> HTH,
>
> Vincent
> --

Many thanks, it saved me asking.
Philip 
