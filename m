From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any
 bundle
Date: Thu, 1 Jan 2009 18:03:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011802350.30769@pacific.mpi-cbg.de>
References: <20081219205100.GA26671@coredump.intra.peff.net> <87prj7mz50.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Jan 01 18:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQyw-0005Xp-Pf
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 18:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbZAARDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756367AbZAARDD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 12:03:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:48851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756293AbZAARDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 12:03:01 -0500
Received: (qmail invoked by alias); 01 Jan 2009 17:02:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 01 Jan 2009 18:02:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+N/n1viXGNhozwa/k0EX900xpvpdl+gII73mOBBP
	3BKgcers/wIhHH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87prj7mz50.fsf_-_@jidanni.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104304>

Hi,

On Thu, 1 Jan 2009, jidanni@jidanni.org wrote:

> >>>>> "JK" == Jeff King <peff@peff.net> writes:
> 
> JK> AFAIK, there is no tool to try salvaging strings from an incomplete pack
> JK> (and you can't just run "strings" because the deltas are zlib
> JK> compressed). So if I were in the police forensics department, I think I
> JK> would read Documentation/technical/pack-format.txt and start hacking a
> JK> solution as quickly as possible.
> 
> Hogwash. Patch follows. Maybe even better methods are available.
> 
> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---

Just for the record: this is in so many ways not a commit message I want 
to have in git.git.  I hope it is not applied.

Ciao,
Dscho
