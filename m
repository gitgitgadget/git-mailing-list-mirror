X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sun, 17 Dec 2006 15:54:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612171550510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de> 
 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com> 
 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de> 
 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
 <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 14:54:33 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34694>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvxPG-0004ZN-At for gcvg-git@gmane.org; Sun, 17 Dec
 2006 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752753AbWLQOyX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 09:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbWLQOyX
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 09:54:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:32951 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752751AbWLQOyW
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 09:54:22 -0500
Received: (qmail invoked by alias); 17 Dec 2006 14:54:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 17 Dec 2006 15:54:21 +0100
To: Stefano Spinucci <virgo977virgo@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 17 Dec 2006, Stefano Spinucci wrote:

> I just tried to use git writing to my FAT32 formatted usb stick.
> 
> On windows XP, I compiled git with and without NO_D_TYPE_IN_DIRENT, but 
> after the following actions I always got the error "fatal: Unable to 
> write new index file" or "fatal: unable to create '.git/index': File 
> exists":

Come to think of it, I probably never tried to actually _commit_ on 
FAT32... Sorry.

I will not be able to test this scenario until Tuesday, though. Sorry 
again!

Ciao,
