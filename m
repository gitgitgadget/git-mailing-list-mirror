From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 16:42:54 +0200
Message-ID: <20080624144254.GG5528@leksak.fem-net>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9kT-0001CX-PP
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbYFXOm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbYFXOm7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:42:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:48250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754680AbYFXOm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:42:58 -0400
Received: (qmail invoked by alias); 24 Jun 2008 14:42:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp004) with SMTP; 24 Jun 2008 16:42:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+jObFVjwSj9QX0lbuidyVPvlTKKjLWWbCcj0g+3V
	B9BdtlJczWgFl/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KB9jS-00017P-Eu; Tue, 24 Jun 2008 16:42:54 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806241515460.9925@racer>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86065>

Hi,

> So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

Are they intentionally undocumented to not raise confusion?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
