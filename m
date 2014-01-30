From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Jan 2014, #06; Wed, 29)
Date: Thu, 30 Jan 2014 20:33:41 -0000
Organization: OPDS
Message-ID: <6C9DB1233C5E408C88C52DED04D222B2@PhilipOakley>
References: <xmqqr47qig41.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 30 21:33:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8yIy-0003uT-J0
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 21:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbaA3Udk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 15:33:40 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:42758 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468AbaA3Udk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jan 2014 15:33:40 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Avw4AAS26lICYJ0F/2dsb2JhbABZgwxIA4NFhT60YAECAQiBBBd0giAFAQEBAQIBCAEBGRUeAQEmBgIDBQIBAxUFAgUhAgIUAQQaBgcXBgESCAIBAgMBh2wMq1igVBeBKY4OgkE1gRQBA48pmx6DLTw
X-IPAS-Result: Avw4AAS26lICYJ0F/2dsb2JhbABZgwxIA4NFhT60YAECAQiBBBd0giAFAQEBAQIBCAEBGRUeAQEmBgIDBQIBAxUFAgUhAgIUAQQaBgcXBgESCAIBAgMBh2wMq1igVBeBKY4OgkE1gRQBA48pmx6DLTw
X-IronPort-AV: E=Sophos;i="4.95,752,1384300800"; 
   d="scan'208";a="452946714"
Received: from host-2-96-157-5.as13285.net (HELO PhilipOakley) ([2.96.157.5])
  by out1.ip02ir2.opaltelecom.net with SMTP; 30 Jan 2014 20:33:35 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241279>

From: "Junio C Hamano" <gitster@pobox.com>
>
> * po/everyday-doc (2014-01-27) 1 commit
> - Make 'git help everyday' work
>
> This may make the said command to emit something,

My initial intention ;-)

>      but the source is
> not meant to be formatted into a manual pages to begin with, and
> also its contents are a bit stale.

True. Your $gmane240286/focus=240334 noted that the top 20 commands has 
probably changed as well.

>    It may be a good first step in
> the right direction, but needs more work to at least get the
> mark-up right before public consumption.
>
> Will hold.
>

OK. Probably a slow-time excercise for me. Other contributions welcome.

Philip.
