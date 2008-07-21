From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Suggestion: doc restructuring
Date: Mon, 21 Jul 2008 12:04:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807211202250.3305@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48806D03.30603@fastmail.fm> <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness> <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org> <48842FA8.5070309@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKsFz-00029V-IN
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbYGUKDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbYGUKDi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:03:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:56167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752372AbYGUKDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:03:37 -0400
Received: (qmail invoked by alias); 21 Jul 2008 10:03:35 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp056) with SMTP; 21 Jul 2008 12:03:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zVFZ1grDzAOHb7mnZQQQHi1Tl5+zj5aGant4HBc
	zraZUPPbxHLqI/
X-X-Sender: user@eeepc-johanness
In-Reply-To: <48842FA8.5070309@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89330>

Hi,

On Mon, 21 Jul 2008, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> 
> >  Side note, that was why I suggested us to first think about use cases 
> >  in our every day work that we still need to resort to the plumbing, 
> >  so that we can identify what that enhancement would consist of.
> 
> Half a year or so ago, there were some mailings to the list along the 
> lines of "what git commands do you use?", using the bash history and a 
> shell oneliner to dig out some crude intel.

Actually, I did not even like that approach back then.  Just because you 
happen to be an old-timer and use rev-parse and rev-list frequently does 
not mean that you _have_ to use it, or even _should_ use it, or that it 
would be good to teach your command lines to a newbie.

Ciao,
Dscho
