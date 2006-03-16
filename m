From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-reset and clones
Date: Thu, 16 Mar 2006 15:59:43 +0100
Message-ID: <44197D5F.4030808@op5.se>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org> <44197C04.5080400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jakma <paul@clubi.ie>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 16 15:59:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJtxA-0005DE-8m
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 15:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWCPO7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 09:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWCPO7p
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 09:59:45 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:52957 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751192AbWCPO7o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 09:59:44 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 62AB06BD21; Thu, 16 Mar 2006 15:59:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44197C04.5080400@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17640>

Andreas Ericsson wrote:
> 
>     git branch next-master ORIGIN

s/ORIGIN/ORIG_HEAD/

otherwise the advice still applies.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
