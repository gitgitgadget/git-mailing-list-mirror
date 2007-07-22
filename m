From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Initial Chinese translation
Date: Sun, 22 Jul 2007 13:04:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221303160.14781@racer.site>
References: <11850629362012-git-send-email-xudong.guan@gmail.com>
 <7vhcnxtgvw.fsf@assigned-by-dhcp.cox.net> <20070722073519.GV32566@spearce.org>
 <7vhcnwsvzd.fsf@assigned-by-dhcp.cox.net> <20070722085338.GA18268@xguan-laptop>
 <Pine.LNX.4.64.0707221233330.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Xudong Guan <xudong.guan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICaBg-0002PQ-O0
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760646AbXGVMFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757261AbXGVMFI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:05:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:38006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760682AbXGVMFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:05:06 -0400
Received: (qmail invoked by alias); 22 Jul 2007 12:05:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 22 Jul 2007 14:05:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1966Q9xj0R6obZ6F3SinHjmpu1VceE27RRjg+Pfpt
	FmHW5AZ3Ma3Rv2
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707221233330.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53255>

Hi,

On Sun, 22 Jul 2007, Johannes Schindelin wrote:

> > >From 936787ddbdeaf0bcecbb1359179dae90c20418b0 Mon Sep 17 00:00:00 2001
> > From: Xudong Guan <xudong.guan@gmail.com>
> > Date: Sun, 22 Jul 2007 09:41:12 +0100
> > Subject: [PATCH] git-gui: renamed po/zh.po -> po/zh_CN.po
> 
> Thanks.  Applied.

Ooops.  I amended it, because msgformat seems to downcase the name in tcl 
mode.  So it is now called po/zh_cn.po.

I hope it did not inconvenience anybody that I did not do a brown-paper 
bag commit, but forced a push.

Ciao,
Dscho
