X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 13:23:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301322180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <456CB197.2030201@onlinehome.de>
  <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> 
 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>  <456DD76C.4010902@gmx.net>
  <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org>  <87bqmpvlxf.wl%cworth@cworth.org>
 <456E8147.9070304@gmx.net>  <Pine.LNX.4.63.0611301111310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0611300325r3a3fa8av141359c69d2377b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 12:30:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0611300325r3a3fa8av141359c69d2377b5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32730>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpl2a-0004HU-R9 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936403AbWK3M11 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936394AbWK3MXe
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:23:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:9644 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936392AbWK3MX3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:23:29 -0500
Received: (qmail invoked by alias); 30 Nov 2006 12:23:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 30 Nov 2006 13:23:27 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Nguyen Thai Ngoc Duy wrote:

> On 11/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > But here's an idea: tell the user that she has to tell git-commit which
> > files she wants committed. Yes! That's it. Just tell it the friggin'
> > files. And if you are a lazy bum, and want to commit _all_ modified
> > files, git has a nice shortcut for ya: "-a".
> 
> It reminds me Microsoft Office Assistant :-) Let's make "git assistant
> mode" that tries hard to guess user's desires and give them guidance.
> Once they get used to git, they can disable that mode and back to
> "plain git".

See git-gui from Shawn. It should really help new users with a graphical 
user interface.

Ciao,
Dscho
