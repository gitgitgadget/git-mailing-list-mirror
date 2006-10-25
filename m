X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bugreport: core-tutorial example outdated?
Date: Wed, 25 Oct 2006 19:23:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610251923020.3286@wbgn013.biozentrum.uni-wuerzburg.de>
References: <453F9BA5.3020104@anagramm.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 25 Oct 2006 17:24:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <453F9BA5.3020104@anagramm.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30080>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcmTp-00027z-UN for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932269AbWJYRXu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWJYRXu
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:23:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:14514 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S932269AbWJYRXt (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:23:49 -0400
Received: (qmail invoked by alias); 25 Oct 2006 17:23:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 25 Oct 2006 19:23:48 +0200
To: Clemens Koller <clemens.koller@anagramm.de>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 25 Oct 2006, Clemens Koller wrote:

> I just studied
> http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html
> to get more into the details of git. But the following commands:
> 
> $ git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
> $ git-cat-file "blob" 557db03
> 
> just bring up a
> 
> fatal: Not a valid object name 557db03de

Did you actually add a file with the content "Hello World\n"? If not, you 
should not be surprised.

Hth,
Dscho
