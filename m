From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Sun, 4 Oct 2009 23:09:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
References: <4AC8F22F.5070101@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-537560836-1254690543=:4985"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 23:11:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuYM8-00010a-OW
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 23:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbZJDVH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 17:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758080AbZJDVH3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 17:07:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:39712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758069AbZJDVH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 17:07:29 -0400
Received: (qmail invoked by alias); 04 Oct 2009 21:06:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 04 Oct 2009 23:06:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XbykgdI4Xs56WKVbG4thSG56MgekpdNBsKFcVPw
	TlnJg4AAbKsDAH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4AC8F22F.5070101@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129519>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-537560836-1254690543=:4985
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 4 Oct 2009, Björn Gustavsson wrote:

> Make it easier to edit just the commit message for a commit
> using 'git rebase -i' by introducing the "amend" command.

I thought that we had a discussion about this and that the consensus was 
that "amend" would be misleading.  Maybe you can find that thread in 
GMane?

Ciao,
Dscho
--8323328-537560836-1254690543=:4985--
