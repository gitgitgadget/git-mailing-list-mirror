From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 9/9] Windows: Do not compile git-shell
Date: Fri, 25 Jul 2008 06:43:52 +0200
Message-ID: <285D4249-DF1F-4C2A-B7D8-6A74A8A7AED7@zib.de>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-4-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-5-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-7-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-8-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-9-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-10-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 06:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMFAk-0001Cu-Ty
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 06:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYGYEnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 00:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYGYEnv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 00:43:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:63365 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbYGYEnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 00:43:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6P4hUPB017342;
	Fri, 25 Jul 2008 06:43:35 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9350b.pool.einsundeins.de [77.185.53.11])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6P4hRJF029691
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 25 Jul 2008 06:43:29 +0200 (MEST)
In-Reply-To: <1216667998-8879-10-git-send-email-johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89997>

Junio,
Do you plan to apply this patch anytime soon?  Currently,
building on MSYS fails when it comes to compiling git-shell.
I am waiting for this patch to either pop up in your or
Hannes' master.  I need this patch before I can push new
4msysgit branches (next, devel).  Should I apply it directly
in 4msysgit?

This patch is not related to the rest of the exec-path series.

	Steffen
