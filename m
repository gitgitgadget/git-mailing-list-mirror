From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: no luck with colors for branch names in gitk yet
Date: Fri, 5 Feb 2016 21:25:16 -0000
Organization: OPDS
Message-ID: <B88DD991725D43E19185D46EED20FDDF@PhilipOakley>
References: <CAC4O8c-MPwrJ2H+iHjQxk+XoX4_vPm80Lz1=wbuHHd2gsB8R0Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Britton Kerin" <britton.kerin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:25:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnsZ-0000E8-86
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbcBEVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:25:19 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:62280 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590AbcBEVZS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 16:25:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A7SgCKErVWPIGyYwJeGQEBAQELAQIBAQEBAYMKUm2HUIELqWyFeIMbI4VgBAQCgTZNAQEBAQEBBwEBAQFAASQbQQEBAQIBCASDaQYBAQQIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBAgSBgcDFAYTCAIBAgMBh3UDFgqwY4Ygg1gNhGkEe4UXhDeCN4R7K4EPBZZ1AYE6hBGGEYNOjRiGfYNvg1KERjwugSCDVoFSgzQBAQE
X-IPAS-Result: A2A7SgCKErVWPIGyYwJeGQEBAQELAQIBAQEBAYMKUm2HUIELqWyFeIMbI4VgBAQCgTZNAQEBAQEBBwEBAQFAASQbQQEBAQIBCASDaQYBAQQIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBAgSBgcDFAYTCAIBAgMBh3UDFgqwY4Ygg1gNhGkEe4UXhDeCN4R7K4EPBZZ1AYE6hBGGEYNOjRiGfYNvg1KERjwugSCDVoFSgzQBAQE
X-IronPort-AV: E=Sophos;i="5.22,402,1449532800"; 
   d="scan'208";a="657420011"
Received: from host-2-99-178-129.as13285.net (HELO PhilipOakley) ([2.99.178.129])
  by out1.ip04ir2.opaltelecom.net with SMTP; 05 Feb 2016 22:20:10 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285635>

From: "Britton Kerin" <britton.kerin@gmail.com>
> Someone suggested using color.branch.upstream, I tried like this and 
> variants
>
> [color "branch"]
>  local = red bold
>  upstream = red bold
>
> Doesn't seem to matter what I put in for upstream, including invalid
> colors, gitk just ignores it and does the dark green for local
> branches
> --
Alternate, try
https://github.com/oumu/mintty-color-schemes/blob/master/base16-mintty/base16-default.minttyrc
(or any of the other colour schemes) and copy them into your .minttyrc file
(works for me on g4w : git version 2.7.0.windows.1 )

--

Philip 
