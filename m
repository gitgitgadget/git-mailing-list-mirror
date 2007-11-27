From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Tue, 27 Nov 2007 16:18:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271617350.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-198899251-1196180281=:27959"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWk=?= Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 17:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix38m-0006r7-SU
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbXK0QSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 11:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbXK0QSI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:18:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:39458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752372AbXK0QSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 11:18:07 -0500
Received: (qmail invoked by alias); 27 Nov 2007 16:18:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 27 Nov 2007 17:18:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZwjRiAH4ZZl38Yrfon43Q7sAWrAcNjFSnEcvWEo
	Uu3wuTxNXw5Tnr
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127160423.GA22807@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66235>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-198899251-1196180281=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 Nov 2007, Nguyễn Thái Ngoc Duy wrote:

>  Both configure and make-only ways should work now

I thought your plan was to put the non-porcelain into the libexecdir only?

Ciao,
Dscho
---1463811741-198899251-1196180281=:27959--
