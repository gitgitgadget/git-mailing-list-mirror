From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a simple getpass() for MinGW
Date: Wed, 8 Apr 2009 04:56:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904080455220.10279@pacific.mpi-cbg.de>
References: <cover.1239154140u.git.johannes.schindelin@gmx.de> <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de> <7vfxgjub7c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNwf-0003ic-W2
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbZDHCxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZDHCxt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:53:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:33072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752120AbZDHCxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:53:49 -0400
Received: (qmail invoked by alias); 08 Apr 2009 02:53:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 08 Apr 2009 04:53:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xfMAbFgXxpFMUwsiPyoKagBgIrB4ltBR1ZewhCd
	OMnmgXthCMaGWo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxgjub7c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116027>

Hi,

On Tue, 7 Apr 2009, Junio C Hamano wrote:

> Thanks; should I take this directly or via Hannes's pull request?

Thanks for asking; Maybe Hannes has some alternative solution, so I'd like 
to have his take on things first.

Ciao,
Dscho "who really, really needs to sleep now"
