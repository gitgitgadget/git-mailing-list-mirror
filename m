From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 11:46:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006121139290.2689@bonsai2>
References: <20100605005116.GA8774@progeny.tock> <alpine.DEB.1.00.1006051810300.1732@bonsai2> <20100612075542.GB2918@burratino>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-71040509-1276336000=:2689"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 11:46:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONNIf-0000E6-L4
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 11:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab0FLJqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 05:46:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:57585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753478Ab0FLJqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 05:46:42 -0400
Received: (qmail invoked by alias); 12 Jun 2010 09:46:40 -0000
Received: from pD9EB0BD4.dip0.t-ipconnect.de (EHLO noname) [217.235.11.212]
  by mail.gmx.net (mp005) with SMTP; 12 Jun 2010 11:46:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ztlVeXwVzXhD0Oqmr8rzEIb3YFrZI2fbo5zbR61
	G+ja886ZDwQU2z
X-X-Sender: gene099@bonsai2
In-Reply-To: <20100612075542.GB2918@burratino>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148998>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-71040509-1276336000=:2689
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 12 Jun 2010, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Fri, 4 Jun 2010, Jonathan Nieder wrote:
> 
> >> Johannes Schindelin (2):
> >>   grep: Add the option '--open-files-in-pager'
> >>   grep -O: allow optional argument specifying the pager (or editor)
> >
> > Last time I tried, it also needed the patch "Unify code paths of threaded 
> > greps". Don't know if that one made it in already.
> 
> Thanks for the pointer, but I can’t seem to find any such patch.  Maybe
> it was squashed into Fredrik’s patch (5b594f4)?

Nope, the patch is still there, even after a rebase.

In any case, the stuff is available in 4msysgit.git, and working (I was 
sick and tired of maintaining two different forks, and it was costing me 
too much time and work anyway, so I made 4msysgit.git's devel my main 
branch).

Thanks,
Johannes

--8323329-71040509-1276336000=:2689--
