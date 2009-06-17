From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 00:08:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH3Hn-0001LC-Fa
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 00:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbZFQWHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbZFQWHF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 18:07:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:53989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753345AbZFQWHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 18:07:05 -0400
Received: (qmail invoked by alias); 17 Jun 2009 22:07:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 18 Jun 2009 00:07:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jJIFmPAcjFJcv3T6w+NLapZqJhSiUoopt53fL8i
	MNvUbHoPJ8LMRG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090618063348.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121779>

Hi,

On Thu, 18 Jun 2009, Nanako Shiraishi wrote:

> When the commit log message begins with "squash to ...", and there

I do not like this at all.  It assumes that you never have valid commit 
messages starting with "squash to".

Ciao,
Dscho
