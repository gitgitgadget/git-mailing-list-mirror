From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Introduce %<branch> as shortcut to the tracked
 branch
Date: Wed, 18 Mar 2009 23:46:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Andreas Gruenbacher <agruen@suse.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4Xu-0008RC-1P
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798AbZCRWom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758513AbZCRWol
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:44:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:53373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755445AbZCRWol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:44:41 -0400
Received: (qmail invoked by alias); 18 Mar 2009 22:44:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 18 Mar 2009 23:44:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q9GNx+FxqoGmhtYy+DSdD6BNLAyF8dgoBaMxvwY
	cxBaUkVZq4GRqa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113697>

Hi,

On Wed, 18 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Suggested by Pasky.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the longer term who suggested matters much less than why such a 
> feature is desirable, how it is used, and without it what is impossible 
> and/or cumbersome.  What's the motivation behind this?
> 
> You do not have to explain it to me, but you should explain it to the 
> history that records this commit, and to the users who read doccos.

And that's not all... Documentation updates and tests for % and %<branch> 
are missing, too.

My main motivation to make this patch was to see how fast I could come up 
with something working that does not hurt my eyes.

But I do not have time to do more today: My main project as well as Git 
got accepted into the Google Summer of Code program, so I am even more 
swamped than usually.

So... if anybody feels like it, I would be very thankful for a proper 
commit message, documentation and tests...

Ciao,
Dscho
