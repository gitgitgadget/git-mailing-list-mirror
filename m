From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] grep: Add the option '--open-files-in-pager'
Date: Mon, 29 Mar 2010 19:13:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1003291912281.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de> <alpine.DEB.1.00.1003261149040.7596@pacific.mpi-cbg.de> <20100328040938.GA2017@progeny.tock>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1148985287-1269882788=:7596"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 19:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwIWj-0003Si-8q
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 19:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab0C2RNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 13:13:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:35642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754804Ab0C2RNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 13:13:09 -0400
Received: (qmail invoked by alias); 29 Mar 2010 17:13:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 29 Mar 2010 19:13:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kVVQYHvrkwROCpe11nLfZNbvTNYMvNhwE0YCW86
	JLWinJ0JHKWuoW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100328040938.GA2017@progeny.tock>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143501>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1148985287-1269882788=:7596
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 27 Mar 2010, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > diff --git a/builtin-grep.c b/builtin-grep.c
> > index 5d83d9b..233c772 100644
> 
> I couldn’t get this to apply to current master or maint, and searching 
> for blob 5d83d9b to find a more suitable merge base revealed that I 
> don’t actually have that object in my repo.  Is this patch available 
> already applied in a public git repo somewhere?

Yes, it is in 4msysgit.git's "grep-P" branch (still misnamed).

Ciao,
Dscho

--8323328-1148985287-1269882788=:7596--
