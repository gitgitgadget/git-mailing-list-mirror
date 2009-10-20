From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] import-tars: Add support for tarballs compressed with
 lzma, xz
Date: Tue, 20 Oct 2009 11:56:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910201155260.4985@pacific.mpi-cbg.de>
References: <1256029177-22503-1-git-send-email-ingmar@exherbo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: Ingmar Vanhassel <ingmar@exherbo.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 11:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0BPr-0004d0-HQ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 11:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbZJTJx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 05:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbZJTJx6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 05:53:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751690AbZJTJx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 05:53:57 -0400
Received: (qmail invoked by alias); 20 Oct 2009 09:54:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 20 Oct 2009 11:54:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kn7Vk9/HkB0ypJRgWZcqaPIj+6uG/BBn7MGcfgS
	OBYM/eObA7UOt4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1256029177-22503-1-git-send-email-ingmar@exherbo.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130782>

Hi,

On Tue, 20 Oct 2009, Ingmar Vanhassel wrote:

> Signed-off-by: Ingmar Vanhassel <ingmar@exherbo.org>

Nice!  Maybe you want to mention in the commit message that it handles 
also .txz and .tlz, for convenience.  (I was looking specifically for that 
support in the patch, fully prepared to suggest to add it...)

Ciao,
Dscho
