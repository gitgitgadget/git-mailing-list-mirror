X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding spell checker to GIT
Date: Tue, 12 Dec 2006 21:27:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122126430.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com> 
 <200612051726.kB5HQO2t015777@laptop13.inf.utfsm.cl>
 <b5a19cd20612121151g74bae55fjd022b6314ffcf6c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 20:27:53 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b5a19cd20612121151g74bae55fjd022b6314ffcf6c8@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34143>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuEE3-0002ag-Qz for gcvg-git@gmane.org; Tue, 12 Dec
 2006 21:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932333AbWLLU1l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 15:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWLLU1l
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 15:27:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:54233 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932333AbWLLU1k
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 15:27:40 -0500
Received: (qmail invoked by alias); 12 Dec 2006 20:27:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp047) with SMTP; 12 Dec 2006 21:27:38 +0100
To: Deepak Barua <dbbarua@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Deepak Barua wrote:

>                  what you are suggesting seems fine to me but the
> thing is should i write a GIT plugin where cani get info to write
> one...?

For a start, you might want to read Documentation/hooks.txt. Then you want 
to inspect templates/hooks--pre-commit.

Hth,
Dscho
