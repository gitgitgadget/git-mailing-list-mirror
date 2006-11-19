X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Sun, 19 Nov 2006 16:45:38 +0100
Organization: At home
Message-ID: <ejpu4r$dsk$1@sea.gmane.org>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> <7v1wo0bb4z.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611191547460.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 19 Nov 2006 15:45:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31834>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gloqp-0000Ns-1u for gcvg-git@gmane.org; Sun, 19 Nov
 2006 16:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756720AbWKSPos (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 10:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756726AbWKSPos
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 10:44:48 -0500
Received: from main.gmane.org ([80.91.229.2]:65210 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1756720AbWKSPos (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 10:44:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GloqT-0000K1-MD for git@vger.kernel.org; Sun, 19 Nov 2006 16:44:37 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 16:44:37 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 19 Nov 2006
 16:44:37 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Sat, 18 Nov 2006, Junio C Hamano wrote:
> 
>> OOPS; sorry but the latter half is entirely untrue.  What's
>> there is half-done git-shortlog.  Scratch everything about
>> branch management please.
> 
> IMHO -shortlog needs support to read .mailmap, and maybe nods to throw out 
> the built-in mailmap which is totally specific to the Linux kernel 
> development.

If I remember correctly besides having built-in mailmap (at least in Perl
version quite easy modificable, and updateable via Inline::Files), it also
have built-in path shortening. And that part IIRC was not solved (although
there was some proposal).

The shallow clone work looks promising...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

