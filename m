From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] statplot: a tool for mining repository statistics.
Date: Fri, 2 Mar 2007 20:10:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022008550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070301072953.GA8730@spearce.org>
 <81b0412b0703010158i1a3963f4wabda2f72c1fd0bc4@mail.gmail.com>
 <20070301183004.GB8858@spearce.org> <es9qf4$cj0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-79230542-1172862606=:22628"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:10:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HND8w-00023Q-Gx
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbXCBTKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbXCBTKK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:10:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:41676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965069AbXCBTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:10:08 -0500
Received: (qmail invoked by alias); 02 Mar 2007 19:10:07 -0000
X-Provags-ID: V01U2FsdGVkX19DE0Ab+v5DLwaqZlNm4TZezwDHbpofxYUisbSmgN
	5oo422I3xWoAAW
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <es9qf4$cj0$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41235>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-79230542-1172862606=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 2 Mar 2007, Jakub Narebski wrote:

> Shawn O. Pearce wrote:
> 
> > Horribly simple code.  Maybe too dumb for inclusion in git.git.
> 
> Perhaps it would be better to include it (first) in contrib/ section, 
> then? It looks more like contrib, by the way, than something than should 
> be in git.git core...

It depends not only on libgit.a, but also on being a builtin. I actually 
_like_ writing builtins better than non-builtins, since the infrastructure 
is so simple.

If now only a unified option parser would appear out of the void, that'd 
be perfect.

Ciao,
Dscho

---1148973799-79230542-1172862606=:22628--
