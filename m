X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Feature request: git-pull -e/--edit
Date: Tue, 21 Nov 2006 10:19:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611211018040.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <git2eran@tromer.org> <200611201709.kAKH9or1012062@laptop13.inf.utfsm.cl>
 <4561FDA9.6060807@tromer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 09:20:29 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4561FDA9.6060807@tromer.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31978>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmRng-0004XX-T8 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 10:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966927AbWKUJUH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 04:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966926AbWKUJUH
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 04:20:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:54144 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S966927AbWKUJUC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 04:20:02 -0500
Received: (qmail invoked by alias); 21 Nov 2006 09:20:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 21 Nov 2006 10:20:00 +0100
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 20 Nov 2006, Eran Tromer wrote:

> On 2006-11-20 19:09, Horst H. von Brand wrote:
> >>
> >>   A------------F master
> >>    \          /
> >>     B--C--D--E
> >>
> >> Yes, E and F have identical trees.

There has been only _one_ line of history, so why introduce what was not 
there?

It sounds more like you do not trust "E" to be something especially 
useful, but in that case you should not merge it to begin with.

Ciao,
