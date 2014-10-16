From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Thu, 16 Oct 2014 23:53:12 +0100
Organization: OPDS
Message-ID: <0F6BE26CD2B44C37A1E1BB0239655AC5@PhilipOakley>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 00:53:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XetvC-00067x-PP
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 00:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbaJPWxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 18:53:20 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:10971 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983AbaJPWxR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 18:53:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjEKAKNLQFROl33/PGdsb2JhbABbgw6DYVCFO8smgR0WAQEFAQEBATggG4N9BgEBBAgBARkVHwEsAgMFAgEDDQgFAgUhAgIUAQQaDQMUBgESCAIBAgMBiDG2fIZ/jkCBLJIfNoEeBZF/XZMMj16CJTwvgkoBAQE
X-IPAS-Result: AjEKAKNLQFROl33/PGdsb2JhbABbgw6DYVCFO8smgR0WAQEFAQEBATggG4N9BgEBBAgBARkVHwEsAgMFAgEDDQgFAgUhAgIUAQQaDQMUBgESCAIBAgMBiDG2fIZ/jkCBLJIfNoEeBZF/XZMMj16CJTwvgkoBAQE
X-IronPort-AV: E=Sophos;i="5.04,735,1406588400"; 
   d="scan'208";a="522739231"
Received: from unknown (HELO PhilipOakley) ([78.151.125.255])
  by out1.ip03ir2.opaltelecom.net with SMTP; 16 Oct 2014 23:53:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>
> This series is designed to implement the changes necessary to build 
> Git
> using Asciidoctor instead of AsciiDoc.
[..]
> Even with these patches, Asciidoctor warns about everyday.txt and
> user-manual.txt.  I'm not sending patches for these right now because
> I've seen recent series including those and don't want to cause a
> merge conflict.
>
Does the new version for giteveryday.txt and everyday.txt which 
graduated to master, 1cb3324 (Merge branch 'po/everyday-doc', 
2014-10-16) format OK?

i.e. does 'git help everyday' now correct the Asciidoctor warnings.

I don't have access to Asciidoctor (on MsysGit), but did make sure the 
header underlines were updated.
--
Philip 
