X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] Git Queues 0.10
Date: Tue, 14 Nov 2006 14:13:31 +0100
Message-ID: <4559C0FB.5010103@op5.se>
References: <20061114101037.GA8075@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 13:13:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061114101037.GA8075@filer.fsl.cs.sunysb.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31345>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjy6g-0002Hr-1c for gcvg-git@gmane.org; Tue, 14 Nov
 2006 14:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965599AbWKNNNi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 08:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965604AbWKNNNi
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 08:13:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:17888 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965599AbWKNNNi (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 08:13:38 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 16A7A6BE35; Tue,
 14 Nov 2006 14:13:36 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 295C36BE36; Tue, 14 Nov 2006 14:13:34 +0100 (CET)
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Sender: git-owner@vger.kernel.org

Josef Sipek wrote:
> Git Queues (aka. gq) is a series of bash scripts which add a Mercurial
> queues-like [1] functionality and interface to git.

gq-project.org

Might I suggest gitq or giq instead? gq is a fairly widespread and 
established tool already.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
