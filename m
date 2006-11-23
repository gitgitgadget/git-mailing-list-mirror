X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 23:39:10 +0000
Message-ID: <4566311E.7040206@shadowen.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz> <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:39:24 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32177>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOA2-0004Uv-N4 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755370AbWKWXjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbWKWXjQ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:39:16 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:58384 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1755370AbWKWXjP
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:39:15 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GnO9C-0001cY-O3; Thu, 23 Nov 2006 23:38:26 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
>> and --use-immingled-remote can be used to get the original behaviour;
>> it is also implied by --bare.
> 
> What's immingled?

Had me reaching for the dictionary too.  Seems to mean the same as
intermingled which would be my choice ...

