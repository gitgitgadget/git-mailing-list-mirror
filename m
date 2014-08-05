From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Everyday contents (was Re: What's cooking in git.git (Jul 2014, #04; Tue, 22))
Date: Tue, 5 Aug 2014 22:00:17 +0100
Organization: OPDS
Message-ID: <FB81543A687C4375BF4E3005464EE38A@PhilipOakley>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com><B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley><xmqqegxcdjzl.fsf@gitster.dls.corp.google.com><7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley><xmqqvbqm74v7.fsf@gitster.dls.corp.google.com><xmqqegx95bxc.fsf@gitster.dls.corp.google.com><xmqqvbqezs64.fsf@gitster.dls.corp.google.com> <xmqqzjfiof72.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XElqe-0004rW-I0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 23:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbaHEVAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 17:00:40 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:54372 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136AbaHEVAk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2014 17:00:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhIgAKBF4VMCYJRxPGdsb2JhbABbgw1jAUWHLoEEywMFAQIBAQyBChcFAQEBATg2g34GAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiDWzVpAOF4wdgy81gwGBHAWKWYcIliCKSSuBRzwv
X-IPAS-Result: AhIgAKBF4VMCYJRxPGdsb2JhbABbgw1jAUWHLoEEywMFAQIBAQyBChcFAQEBATg2g34GAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiDWzVpAOF4wdgy81gwGBHAWKWYcIliCKSSuBRzwv
X-IronPort-AV: E=Sophos;i="5.01,807,1400022000"; 
   d="scan'208";a="642695105"
Received: from host-2-96-148-113.as13285.net (HELO PhilipOakley) ([2.96.148.113])
  by out1.ip06ir2.opaltelecom.net with SMTP; 05 Aug 2014 22:00:17 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254828>

From: "Junio C Hamano" <gitster@pobox.com>
> Continued: this message covers the last part.
> 
> | Repository Administration[[Repository Administration]]
> | ------------------------------------------------------
> | 
> | A repository administrator uses the following tools to set up
> | and maintain access to the repository by developers.
...

Thanks for this final part. 

I'd just updated the original patch and split it into three steps:
1. update the everday text in it's current place,
2. tweak the Makefile for the Obsolete_Html list ready for next patch
3. swap over to the giteveryday file nameing and fix the linked docs.

I'll add in your guidance on the last part to my patch 1.

Many thanks.
--
Philip
