X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: error: Can't lock ref
Date: Mon, 11 Dec 2006 10:08:35 +0100
Message-ID: <457D2013.4060908@op5.se>
References: <457D0F97.6050801@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 09:08:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <457D0F97.6050801@jonmasters.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33981>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gth9N-0004ab-0I for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762662AbWLKJIh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 04:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762671AbWLKJIh
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:08:37 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36516 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762662AbWLKJIh (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 04:08:37 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 560026BCBF; Mon, 11 Dec 2006 10:08:35 +0100 (CET)
To: Jon Masters <jonathan@jonmasters.org>
Sender: git-owner@vger.kernel.org

Jon Masters wrote:
> Hi folks,
> 
> I've just pushed up a packed git repo:
> 
> http://www.kerneltools.org/pub/downloads/module-init-tools/devel/module-init-tools.git 
> 
> 
> Attempting to clone this repo using http generates the error in 
> $subject. Brief searching via Google suggests this is an appache 
> permissions problem - anyone got a trivially obvious apache config fix 
> before I go trawling through to figure out what's up?
> 

What does your apache error log say?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
