X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH]: Pass -M to diff in request-pull
Date: Mon, 04 Dec 2006 09:49:20 -0800 (PST)
Message-ID: <20061204.094920.95061481.davem@davemloft.net>
References: <20061203.231700.55509531.davem@davemloft.net>
	<7v3b7wrrcr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612040843540.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 17:49:51 +0000 (UTC)
Cc: junkio@cox.net, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612040843540.3476@woody.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33208>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrHwk-0006xZ-Bm for gcvg-git@gmane.org; Mon, 04 Dec
 2006 18:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935336AbWLDRth (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 12:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935193AbWLDRth
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 12:49:37 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net
 ([74.93.104.97]:45229 "EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
 by vger.kernel.org with ESMTP id S935336AbWLDRtg (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 12:49:36 -0500
Received: from localhost (localhost [127.0.0.1]) by sunset.davemloft.net
 (Postfix) with ESMTP id 099C8AE46D1; Mon,  4 Dec 2006 09:49:21 -0800 (PST)
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 4 Dec 2006 08:45:28 -0800 (PST)

> On Mon, 4 Dec 2006, Junio C Hamano wrote:
> > David Miller <davem@davemloft.net> writes:
> > >
> > > Linus recommended this, otherwise any renames cause the
> > > diffstate output to be rediculious in some circumstances :)
> > 
> > Thanks, but "rediculious"?
> 
> Kernel dewalopers can't speel. We all knew that.
> 
> At least we don't do 1337-sp33k.

