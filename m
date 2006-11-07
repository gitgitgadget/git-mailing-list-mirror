X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk feature request..
Date: Wed, 8 Nov 2006 09:12:13 +1100
Message-ID: <17745.1213.22769.420355@cargo.ozlabs.ibm.com>
References: <452A37FB.60507@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 22:13:23 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <452A37FB.60507@adelaide.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31094>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhZBh-0007DT-Bp for gcvg-git@gmane.org; Tue, 07 Nov
 2006 23:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753519AbWKGWMt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 17:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbWKGWMo
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 17:12:44 -0500
Received: from ozlabs.org ([203.10.76.45]:34756 "EHLO ozlabs.org") by
 vger.kernel.org with ESMTP id S1753519AbWKGWMV (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 17:12:21 -0500
Received: by ozlabs.org (Postfix, from userid 1003) id A7D4B67D6E; Wed,  8
 Nov 2006 09:12:20 +1100 (EST)
To: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Sender: git-owner@vger.kernel.org

Pierre Marc Dumuid writes:

> I was adviced on the IRC channel to send my feature requests here...

Best to cc me as well on gitk feature requests, since I don't always
keep up with the git mailing list very well.

> I have two feature requests:
> 1. a bugzilla to place feature requests.
> 2. All the stored "views" that can be created and placed under the 
> "view" menu should be unique for each repository.

Good idea.  Junio, is there a canonical place under .git where gitk
should put such things?

