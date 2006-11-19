X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sun, 19 Nov 2006 17:30:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191729190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> <7v1wo0bb4z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611191547460.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <ejpu4r$dsk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 16:30:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ejpu4r$dsk$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31839>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlpZ6-0001EZ-Iu for gcvg-git@gmane.org; Sun, 19 Nov
 2006 17:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756759AbWKSQam (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756762AbWKSQam
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 11:30:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:63939 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756759AbWKSQal (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 11:30:41 -0500
Received: (qmail invoked by alias); 19 Nov 2006 16:30:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 19 Nov 2006 17:30:39 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 19 Nov 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Sat, 18 Nov 2006, Junio C Hamano wrote:
> > 
> > IMHO -shortlog needs support to read .mailmap, and maybe nods to throw out 
> > the built-in mailmap which is totally specific to the Linux kernel 
> > development.

See the 3 patches I just sent.

> If I remember correctly besides having built-in mailmap (at least in Perl
> version quite easy modificable, and updateable via Inline::Files), it also
> have built-in path shortening. And that part IIRC was not solved (although
> there was some proposal).

I do not understand. What paths are handled by git-shortlog?

Ciao,
Dscho
