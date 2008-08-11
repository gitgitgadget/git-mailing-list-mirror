From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Mon, 11 Aug 2008 12:08:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111207070.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vsktczebg.fsf@gitster.siamese.dyndns.org> <1218409804-1556-1-git-send-email-mlevedahl@gmail.com> <489FDC29.5090503@iksz.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, johan@herland.net
To: Balazs Nagy <js@iksz.hu>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUGX-0002C0-CP
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbYHKKDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYHKKDi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:03:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:52609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751184AbYHKKDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:03:37 -0400
Received: (qmail invoked by alias); 11 Aug 2008 10:03:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 11 Aug 2008 12:03:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oDo55AsboGuqy2KJEMPydzXUulXkgq3KABxuNDv
	MdB9qYU2XadwZZ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <489FDC29.5090503@iksz.hu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91923>

Hi,

On Mon, 11 Aug 2008, Balazs Nagy wrote:

> Sorry for being a bit late, but what if we would have --all for all 
> submodule commands instead of having another command?

and the foreach patch would go into which existing command, exactly?  "git 
--all"?  A new "git foreach --all"?

Just kidding,
Dscho
