From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 18:56:11 +0200
Message-ID: <20080808165611.GA2025@leksak.fem-net>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080808153624.GA28716@neumann> <20080808160252.GA8541@leksak.fem-net> <alpine.DEB.1.00.0808081829160.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080808163341.GA20211@leksak.fem-net> <alpine.DEB.1.00.0808081849250.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRVHO-0007gG-Sr
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYHHQ4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYHHQ4P
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:56:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:32958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750965AbYHHQ4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:56:15 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:56:13 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp020) with SMTP; 08 Aug 2008 18:56:13 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX182QvVsMPA2TrU4cpiPw6fw2a5EKUMORroMZ13T1m
	+bfrypjSJot3IY
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KRVG7-0000Wy-As; Fri, 08 Aug 2008 18:56:11 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808081849250.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91695>

Hi,

Johannes Schindelin wrote:
> P.S.: And I do not think it is clean to say that one test depends on the 
> other.  Because they do not.  They depend on not being run concurrently.

Ah ok, you're right here.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
