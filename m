From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.txt: Mention that --whitespace cannot be used
 with interactive rebase.
Date: Thu, 12 Feb 2009 11:58:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902121156550.10279@pacific.mpi-cbg.de>
References: <20090212102119.1de19087@crow>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZHe-0001Vz-R4
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357AbZBLK5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 05:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755720AbZBLK5j
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:57:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:54295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753583AbZBLK5i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 05:57:38 -0500
Received: (qmail invoked by alias); 12 Feb 2009 10:57:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 12 Feb 2009 11:57:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+w1x//xg+qy0DQsmua86EGHAAA66Ry5beS4u0Zj
	YL8arngoPAV6Zz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090212102119.1de19087@crow>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109600>

Hi,

On Thu, 12 Feb 2009, Mark Burton wrote:

> 
> Signed-off-by: Mark Burton <markb@ordern.com>
> ---

Because it was not mentioned in the commit message, I only realized after 
writing a patch that rebase -i --whitespace already errors out.

Would be nice to have important information like that (I mean that it is 
already handled, not that I was stupid enough to write the patch) in the 
commit message, don't you agree?

Ciao,
Dscho
