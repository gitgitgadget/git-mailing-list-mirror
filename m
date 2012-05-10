From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 19:03:19 +0100
Organization: OPDS
Message-ID: <F89882854A7D45E2843F6F1F7CB21DB4@PhilipOakley>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com> <7vzk9gm0wa.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Philippe Vaucher" <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 20:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSXhY-0001cc-3u
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab2EJSCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 14:02:51 -0400
Received: from out1.ip09ir2.opaltelecom.net ([62.24.128.245]:59148 "EHLO
	out1.ip09ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083Ab2EJSCu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 14:02:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4NAEYCrE9cHlGK/2dsb2JhbABEiz6nNAEBAoEdgQiCEAEEAQEFCAEBLh4BASELAgMFAgEDFQELJRQBBAgSBgcXBgESCAIBAgMBhTgHAYInCAMPsgANiVOKJW1BMiRNg2JjBIgwhUqTQIUDgmo
X-IronPort-AV: E=Sophos;i="4.75,565,1330905600"; 
   d="scan'208";a="514203295"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip09ir2.opaltelecom.net with SMTP; 10 May 2012 19:02:48 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197609>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Thursday, May 10, 2012 5:55 PM
> Philippe Vaucher <philippe.vaucher@gmail.com> writes:
>
>> Here's a patch removing the weird bits. I spoke about in my previous message.
>
> What's weird about them?  They are real messages issued exactly when they
> are described to be issued.
> --

Philippe,

The problem is surely that an explanatory line is needed to say that these are the diagnostic messages that occur in various cases. 
Its in 'ident.c'.

Philip 
