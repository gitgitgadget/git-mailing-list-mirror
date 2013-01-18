From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Question re. git remote repository
Date: Fri, 18 Jan 2013 23:10:34 -0000
Organization: OPDS
Message-ID: <2F1BADBEC6D84C95AE8AE6BB898D3E03@PhilipOakley>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com> <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com> <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz> <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca> <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301181833.r0IIXNGb027544@smtpb02.one-mail.on.ca> <alpine.DEB.2.02.1301181127590.21503@nftneq.ynat.uz> <7v622uqjch.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1301181320070.21503@nftneq.ynat.uz>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Lang, David" <David.Lang@uhn.ca>,
	"'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	<git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "David Lang" <david@lang.hm>
X-From: git-owner@vger.kernel.org Sat Jan 19 00:10:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwL4k-0002g5-3s
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 00:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab3ARXJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 18:09:57 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:40326 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753252Ab3ARXJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 18:09:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAMXU+VBcHIm8/2dsb2JhbABEjAKyNxdzghkFAQEFCAEBLh4BASELAgMFAgEDFQECCSUUAQQaBgcXBhMIAgECAwGIDLw7jHiDYGEDiCyFUZhYgnU
X-IronPort-AV: E=Sophos;i="4.84,495,1355097600"; 
   d="scan'208";a="415714589"
Received: from host-92-28-137-188.as13285.net (HELO PhilipOakley) ([92.28.137.188])
  by out1.ip02ir2.opaltelecom.net with SMTP; 18 Jan 2013 23:09:54 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213948>

From: "David Lang" <david@lang.hm>
Sent: Friday, January 18, 2013 9:27 PM
> On Fri, 18 Jan 2013, Junio C Hamano wrote:
>
>> David Lang <david@lang.hm> writes:
>>
>>> What I would do is to have each developer have their own local copy
>>> that they are working on.
>>>

If you have a third machine to host the bare 'master' repo that would 
provide additional security/backup to touy local machines.

[...]
>
> Junio, is there a really good place we should be pointing David where 
> the different workflows are described and explained?

`git help workflows` perhaps.

Philip 
