X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Update git-diff documentation
Date: Thu, 14 Dec 2006 09:59:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140957590.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vr6v2aofs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 08:59:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6v2aofs.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34287>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GumR7-0003Hc-Rk for gcvg-git@gmane.org; Thu, 14 Dec
 2006 09:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932093AbWLNI70 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 03:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWLNI70
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 03:59:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34731 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932093AbWLNI7Z
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 03:59:25 -0500
Received: (qmail invoked by alias); 14 Dec 2006 08:59:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 14 Dec 2006 09:59:23 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Junio C Hamano wrote:

> -Show changes between two trees, a tree and the working tree, a
> -tree and the index file, or the index file and the working tree.
> -The combination of what is compared with what is determined by
> -the number of trees given to the command.
> +This command shows changes between four combinations of states.

I think the old explanation, while longer, is clearer.

I like the rest of your patch, though.

Ciao,
