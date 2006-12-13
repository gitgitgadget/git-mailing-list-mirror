X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding spell checker to GIT
Date: Wed, 13 Dec 2006 11:25:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131123320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com> 
 <200612051726.kB5HQO2t015777@laptop13.inf.utfsm.cl> 
 <b5a19cd20612121151g74bae55fjd022b6314ffcf6c8@mail.gmail.com> 
 <Pine.LNX.4.63.0612122126430.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <d22d265a0612130103o1efcbd87sb93be9c2dad71307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 10:25:35 +0000 (UTC)
Cc: Deepak Barua <dbbarua@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <d22d265a0612130103o1efcbd87sb93be9c2dad71307@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34201>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRIi-0004e2-6e for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932650AbWLMKZV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWLMKZV
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:25:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:54425 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932650AbWLMKZT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 05:25:19 -0500
Received: (qmail invoked by alias); 13 Dec 2006 10:25:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp006) with SMTP; 13 Dec 2006 11:25:17 +0100
To: Sasikumar Kandhasamy <ckmsasi@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Sasikumar Kandhasamy wrote:

> We all know that linux is already having some tool like *aspell*. But 
> this is not present in all the versions. This is one major disadvantage 
> of using existing tool.

The advantage is: It already solved most problems for that particular 
application, like getting all the words for the languages, providing a 
user interface which actually helps using it, organizing the data 
structures.

Besides, aspell is open source, just like Git. You can compile and install 
it.

Hth,
Dscho
