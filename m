X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Adding spell checker to GIT
Date: Tue, 05 Dec 2006 18:08:01 +0100
Message-ID: <4575A771.3060007@op5.se>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 17:08:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33356>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrdmS-0007iC-AB for gcvg-git@gmane.org; Tue, 05 Dec
 2006 18:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968449AbWLERI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 12:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968467AbWLERI3
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 12:08:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:32835 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968449AbWLERI2 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 12:08:28 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
 by smtp-gw1.op5.se (Postfix) with ESMTP id 9D40E6BCBE; Tue,  5 Dec 2006
 18:08:27 +0100 (CET)
To: Deepak Barua <dbbarua@gmail.com>
Sender: git-owner@vger.kernel.org

Deepak Barua wrote:
> Hi All,
>         I am just thought of a idea to integrate a spell checker with
> git so that when we check in the code the code comments are spell
> checked before being put into the tree,maybe have a optimized
> dictionary search.
> what about this...? is it appropriate ...?
> 

Sounds like a worthy project for a pre-commit hook, imo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
