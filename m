X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user
 friendly.
Date: Sat, 9 Dec 2006 14:19:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612091418410.12895@woody.osdl.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612091517010.2630@xanadu.home> <7vpsas91e5.fsf@assigned-by-dhcp.cox.net>
 <elfbq4$tka$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 22:19:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <elfbq4$tka$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33842>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtAXY-00011m-Ke for gcvg-git@gmane.org; Sat, 09 Dec
 2006 23:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758492AbWLIWTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 17:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbWLIWTZ
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 17:19:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54591 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758492AbWLIWTY
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 17:19:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB9MJMID008650
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 9
 Dec 2006 14:19:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB9MJLOT005768; Sat, 9 Dec
 2006 14:19:21 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Sat, 9 Dec 2006, Jakub Narebski wrote:
> 
> I'm a bit uncomfortable about removing documentation to existing
> (if no-op) option. I'd rather it stay.

How about mentioning it at the very end, under a "HYSTERICAL RAISINS" 
header. That way it's documented, and people still know to ignore it.

