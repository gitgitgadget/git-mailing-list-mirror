X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH]: Pass -M to diff in request-pull
Date: Mon, 4 Dec 2006 08:45:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612040843540.3476@woody.osdl.org>
References: <20061203.231700.55509531.davem@davemloft.net>
 <7v3b7wrrcr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 16:45:53 +0000 (UTC)
Cc: David Miller <davem@davemloft.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v3b7wrrcr.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33202>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrGwo-0005kR-9B for gcvg-git@gmane.org; Mon, 04 Dec
 2006 17:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937125AbWLDQph (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937126AbWLDQph
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 11:45:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37617 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937125AbWLDQpg
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 11:45:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB4GjUjQ024006
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 4
 Dec 2006 08:45:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB4GjTNa026593; Mon, 4 Dec
 2006 08:45:29 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Junio C Hamano wrote:
> David Miller <davem@davemloft.net> writes:
> >
> > Linus recommended this, otherwise any renames cause the
> > diffstate output to be rediculious in some circumstances :)
> 
> Thanks, but "rediculious"?

Kernel dewalopers can't speel. We all knew that.

At least we don't do 1337-sp33k.

