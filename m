From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4 0/3] Make 'git help everyday' work
Date: Sat, 11 Oct 2014 11:09:24 +0100
Organization: OPDS
Message-ID: <B8CF69B23B1745B19DA8CE566B7F2FD1@PhilipOakley>
References: <1412976337-2476-1-git-send-email-philipoakley@iee.org> <xmqqtx3b4iul.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 12:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XctcI-0005uA-3B
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 12:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbaJKKJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 06:09:28 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:59974 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978AbaJKKJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 06:09:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoQMABMBOVRZ8YyOPGdsb2JhbABggw6BK4c9gQTKPQQEAoECFwEBBQEBAQE4IBmDfgYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiDGyEI4YkESDNIEeBYsghlldjCOGc5FoPC+CSgEBAQ
X-IPAS-Result: AoQMABMBOVRZ8YyOPGdsb2JhbABggw6BK4c9gQTKPQQEAoECFwEBBQEBAQE4IBmDfgYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiDGyEI4YkESDNIEeBYsghlldjCOGc5FoPC+CSgEBAQ
X-IronPort-AV: E=Sophos;i="5.04,697,1406588400"; 
   d="scan'208";a="513197079"
Received: from host-89-241-140-142.as13285.net (HELO PhilipOakley) ([89.241.140.142])
  by out1.ip03ir2.opaltelecom.net with SMTP; 11 Oct 2014 11:09:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Thanks.
> 
> Looked alright from a cursory read; I tweaked s/10/-10/ where you
> gave examples of limiting output from "git log" before queuing.

That was my mis-reading. I'd even noticed that it looked 'different'
but just didn't see the leading '-' when checking the man page.
--
Thanks
Philip
