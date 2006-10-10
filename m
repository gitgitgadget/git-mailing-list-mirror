From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Mon, 9 Oct 2006 18:47:43 -0700 (PDT)
Message-ID: <20061010014743.80094.qmail@web31801.mail.mud.yahoo.com>
References: <egdge3$t12$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 12 05:15:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXr2J-0004mR-7v
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 05:15:07 +0200
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.6/8.13.1/GN) with ESMTP id k9A1luZw073334
	for <gcvg-git@gmane.org>; Tue, 10 Oct 2006 03:47:56 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWJJBrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 21:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWJJBrp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 21:47:45 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:30859 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964893AbWJJBrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 21:47:45 -0400
Received: (qmail 80096 invoked by uid 60001); 10 Oct 2006 01:47:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Sru5Ep9Qs8iyljLOsIYucpKbBsBGqQpFyaega/khDM+YLbH5C1TWGBavmB3CMRU1GsFzzID75YsAnK2y9E0a4FSyHUz/XRb7yeegG2XkYRUSpZizROJNIvZkFGse+LleZwm+oN6+GRvjkEylERLSSYmq0TuFU+MbmjKw+JMo1pQ=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 18:47:43 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <egdge3$t12$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Spam-Status: No, score=-0.2 required=4.0 tests=BAYES_40 autolearn=ham 
	version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on spamd1.kq.no
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28768>

--- Jakub Narebski <jnareb@gmail.com> wrote:
>  * Improve blame view, making use of --porcelain option to git-blame (for
>    later). Perhaps change blame view from table based one to div based one.

>    Use different colors for different commits (graph coloring problem).

Oh, no please no.

Why do you think I left the color list as a list?  I did try to use
more colors when I wrote it, and it was ugly as h3ll and very distracting
when doing real work.  So I ended up with the two color (shades) we have
now and this is what I submitted.

Also, any kind of "graph coloring problem" would make blame slow.

In any way, if you/someone does implement this "coloring" can you please
make it an option, because I'll never turn it on.  Thanks!

     Luben
