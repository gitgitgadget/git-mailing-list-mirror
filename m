From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 00:22:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010019450.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <490B7FD3.8060003@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:16:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3EX-0005mr-Gq
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYJaXPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYJaXPi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:15:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:60672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751368AbYJaXPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:15:37 -0400
Received: (qmail invoked by alias); 31 Oct 2008 23:15:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 01 Nov 2008 00:15:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X9TohovvXYQD4OZL9/4ZQdwavfKi2aKbNzWwpnX
	dMxvvJqOrrd4Co
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <490B7FD3.8060003@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99670>

Hi,

On Fri, 31 Oct 2008, Andreas Ericsson wrote:

> Apart from that, please consider reading Ulrich Drepper's musings on
> library design at http://people.redhat.com/drepper/goodpractice.pdf

I do not know if I want to trust a person that has shown a certain 
eagerness to ignore good library design by breaking the well-established 
dont-change-apis-on-minor-versions idiom, and instead of listening to 
users that have problems as a consequence rather ignore them.

Instead, let's build on the knowledge of people we have learnt to trust, 
on this list.

Thank you,
Dscho
