X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk broken or user error?
Date: Tue, 14 Nov 2006 09:42:25 +1100
Message-ID: <17752.62673.685934.152224@cargo.ozlabs.ibm.com>
References: <m2irhkr467.fsf@ziti.local>
	<17752.60467.854884.206737@cargo.ozlabs.ibm.com>
	<m27ixzgex4.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 22:43:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <m27ixzgex4.fsf@ziti.local>
X-Mailer: VM 7.19 under Emacs 21.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31327>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjkWc-0004pq-8i for gcvg-git@gmane.org; Mon, 13 Nov
 2006 23:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933087AbWKMWnb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933090AbWKMWnb
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 17:43:31 -0500
Received: from ozlabs.org ([203.10.76.45]:51645 "EHLO ozlabs.org") by
 vger.kernel.org with ESMTP id S933087AbWKMWna (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 17:43:30 -0500
Received: by ozlabs.org (Postfix, from userid 1003) id 16A4A67F09; Tue, 14
 Nov 2006 09:43:30 +1100 (EST)
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon writes:

> Perhaps a similar fix is needed in other parts of the code.  

Sure, the change I asked you to test was just to verify what the
underlying problem was.

