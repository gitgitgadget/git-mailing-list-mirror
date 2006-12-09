X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: doc bug?
Date: Sat, 09 Dec 2006 19:04:39 +0100
Message-ID: <457AFAB7.907@xs4all.nl>
References: <elc64k$t4i$1@sea.gmane.org> <2c6b72b30612090930o7b856223ub87746181f958b7c@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 18:04:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <2c6b72b30612090930o7b856223ub87746181f958b7c@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33825>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt6Z2-0001hD-FB for gcvg-git@gmane.org; Sat, 09 Dec
 2006 19:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759111AbWLISEd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 13:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759115AbWLISEd
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 13:04:33 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:1709 "EHLO
 smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758963AbWLISEc (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 13:04:32 -0500
Received: from [192.168.1.35] (cu-c-36d6f.adsl.wanadoo.nl [83.118.11.111])
 (authenticated bits=0) by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB9I4Ur5092720 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sat, 9 Dec 2006 19:04:30 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Jonas Fonseca <jonas.fonseca@gmail.com>
Sender: git-owner@vger.kernel.org

Jonas Fonseca escreveu:
>> is this a new problem?  I'm on FC6, with  asciidoc 7.0.2
> 
> The git-tools.txt document is not intended to be a man page

So why does the doc try make one for it? This is a bug, no?

-- 
