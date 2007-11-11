From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/6] push: mention --verbose option in documentation
Date: Sun, 11 Nov 2007 15:14:42 +0100
Message-ID: <FAB11CE3-B834-45A9-9D29-A37C302A9E1D@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de> <11947897083381-git-send-email-prohaska@zib.de> <51B9B630-85F7-42BA-BCFF-4374A2527733@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 15:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDZJ-00061K-DR
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbXKKONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbXKKONb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:13:31 -0500
Received: from mailer.zib.de ([130.73.108.11]:58895 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbXKKONa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:13:30 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABEDQP8022867;
	Sun, 11 Nov 2007 15:13:26 +0100 (CET)
Received: from [192.168.178.21] (brln-4db11614.pool.einsundeins.de [77.177.22.20])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABEDOEw001580
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Nov 2007 15:13:25 +0100 (MET)
In-Reply-To: <51B9B630-85F7-42BA-BCFF-4374A2527733@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64464>


On Nov 11, 2007, at 3:10 PM, Steffen Prohaska wrote:

>
> On Nov 11, 2007, at 3:01 PM, Steffen Prohaska wrote:
>
>> From: Steffen Prohaska <gitster@pobox.com>
>
> This is obviously wrong. I have no clear idea how this happend.
> I remember I took the topic branch sp/push-refspec from pu and
> started to refactor. I used 'rebase' and 'rebase -i' a couple
> of times and now I have my name with Junios email address.
>
> I'll investigate how this could happen.

The Author line was already wrong in Junio's pu branch, commit
f31447f5f06200305393ca16e2eb9485e65dcccc,  and I carried this
over without noticing.

	Steffen
