From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Having keywords without value is not a global error.
Date: Fri, 26 Feb 2010 21:35:39 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002262135150.8908@vqena.qenxr.bet.am>
References: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz> <81b0412b1002260019r3d5268f2x4b48051409e0c8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463808000-1590399437-1267173343=:8908"
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkvne-0003Fl-3u
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 09:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935586Ab0BZInq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 03:43:46 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:44023 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935550Ab0BZInp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 03:43:45 -0500
Received: from idran.drake.org.nz (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 088E0170822;
	Fri, 26 Feb 2010 21:43:42 +1300 (NZDT)
In-Reply-To: <81b0412b1002260019r3d5268f2x4b48051409e0c8f5@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141114>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808000-1590399437-1267173343=:8908
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 26 Feb 2010, Alex Riesen wrote:

> On Fri, Feb 26, 2010 at 05:00, Steven Drake <sdrake@xnet.co.nz> wrote:
> > It is not a good Idea to give a config_error for _any_ keyword without a
> > value as it means that
> >
> >        [section]
> >                keyword
> >
> > sytle can not be using for setting bool type keyword.
> 
> Typo: sytle (style?)

Yes!!! 

-- 
Steven
---1463808000-1590399437-1267173343=:8908--
