X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-clone: lose the traditional 'no-separate-remote'
 layout
Date: Sat, 16 Dec 2006 08:53:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612160846430.3557@woody.osdl.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <7vfybgjj7k.fsf@assigned-by-dhcp.cox.net>
 <7v3b7gji73.fsf@assigned-by-dhcp.cox.net> <7vvekci3ds.fsf_-_@assigned-by-dhcp.cox.net>
 <7virgci2ux.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 16:53:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7virgci2ux.fsf_-_@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34626>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvcnM-00066I-Hz for gcvg-git@gmane.org; Sat, 16 Dec
 2006 17:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161184AbWLPQxy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 11:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWLPQxy
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 11:53:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55286 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1161184AbWLPQxx
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 11:53:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBGGroID021805
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 16
 Dec 2006 08:53:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBGGroxV022650; Sat, 16 Dec
 2006 08:53:50 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sat, 16 Dec 2006, Junio C Hamano wrote:
> 
>  And this drops it; modulo bugs, I think this is about it for
>  v1.5.0 around this area.

Ahh, you said that yourself, and I hadn't even noticed that you already 
merged xdl_merge into master too.

So here's an "AOL high five": <me too>.

