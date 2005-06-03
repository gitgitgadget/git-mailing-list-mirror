From: "Adam Kropelin" <akropel1@rochester.rr.com>
Subject: Re: I want to release a "git-1.0"
Date: Thu, 2 Jun 2005 21:34:05 -0400
Message-ID: <012a01c567dc$542787b0$03c8a8c0@kroptech.com>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org> <00e101c567cc$80c0de80$03c8a8c0@kroptech.com> <Pine.LNX.4.58.0506021705520.1876@ppc970.osdl.org> <Pine.LNX.4.58.0506021745310.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 03:31:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De121-0001JD-0t
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 03:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVFCBef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 21:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVFCBef
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 21:34:35 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31982 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261478AbVFCBea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 21:34:30 -0400
Received: from mail.kroptech.com (cpe-24-93-20-125.rochester.res.rr.com [24.93.20.125])
	by ms-smtp-03.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id j531Y5P4019404;
	Thu, 2 Jun 2005 21:34:05 -0400 (EDT)
Received: from pia (pia.kroptech.com [192.168.200.3])
	by mail.kroptech.com (Postfix) with SMTP id 7189F11376E;
	Thu,  2 Jun 2005 21:49:31 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 2 Jun 2005, Linus Torvalds wrote:
>>
>> Yeah, I'll try to clarify.
>
> Adam, do you find the current version a bit more clear on this?

Absolutely. I especially like the new digression explaining that 
the --cached flag controls where file _content_ is fetched from and 
reinforcing that the index file always governs which files are involved 
in the diff.

Thanks!

--Adam

