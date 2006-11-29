X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk with arguments fails on OSX
Date: Thu, 30 Nov 2006 08:16:18 +1100
Message-ID: <17773.63650.734073.958790@cargo.ozlabs.ibm.com>
References: <864psixpj6.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0611291609370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<86vekyw9ue.fsf@blue.stonehenge.com>
	<7vejrmou75.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 21:33:15 +0000 (UTC)
Cc: git@vger.kernel.org, merlyn@stonehenge.com (Randal L. Schwartz)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vejrmou75.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32670>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpX2y-0003ja-By for gcvg-git@gmane.org; Wed, 29 Nov
 2006 22:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758137AbWK2Vcs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758144AbWK2Vcs
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 16:32:48 -0500
Received: from ozlabs.org ([203.10.76.45]:40133 "EHLO ozlabs.org") by
 vger.kernel.org with ESMTP id S1758137AbWK2Vcr (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 16:32:47 -0500
Received: by ozlabs.org (Postfix, from userid 1003) id A45BB67B9F; Thu, 30
 Nov 2006 08:32:46 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano writes:

> The changes look sane to me.
> 
> Paul?  I prefer to be fed gitk changes through you, if you don't
> mind.

I just pushed a somewhat more comprehensive fix to my gitk.git repo on
master.kernel.org.  (Actually I had checked it in some time ago
locally but forgot to do the push, sorry.)

Regards,
