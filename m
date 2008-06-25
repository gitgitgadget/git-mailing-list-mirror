From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Ship sample hooks with .sample suffix
Date: Wed, 25 Jun 2008 08:51:40 +0200
Message-ID: <1214376700.4861eafc43b36@webmail.eunet.at>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site> <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com> <7v3an2bh3b.fsf@gitster.siamese.dyndns.org> <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com> <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org> <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org> <7vod5q8c25.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOsO-0007CQ-5K
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYFYGvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbYFYGvo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:51:44 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:55858 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYFYGvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:51:43 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp5.srv.eunet.at (Postfix) with ESMTPS id 09C3513A4C9;
	Wed, 25 Jun 2008 08:51:40 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m5P6peTL021138;
	Wed, 25 Jun 2008 08:51:40 +0200
Received: from cm56-163-160.liwest.at (cm56-163-160.liwest.at [86.56.163.160]) 
	by webmail.eunet.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Wed, 25 Jun 2008 08:51:40 +0200
In-Reply-To: <7vod5q8c25.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 86.56.163.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86244>

Zitat von Junio C Hamano <gitster@pobox.com>:
> I am very tempted to pull MinGW series directly to 'master', or at least
> to 'next', perhaps after dropping 31d6632.  What's your confidence level
> on the series?  I think we should give this series extra priority so that
> any potential issues with other series (like dr/ceil) that do pathname
> traversal will become more apparent sooner rather than later.

I am very confident in the series as far as using it on Windows is concerned.
But I must admit that I have started to use it on Linux only recently.
Therefore, cooking it in 'next' for a few days is probably not a mistake.

-- Hannes
