From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 15:57:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311553510.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <200710311537.30384.johan@herland.net> <Pine.LNX.4.64.0710311503120.4362@racer.site>
 <200710311621.09845.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InFxP-0008Bc-DX
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878AbXJaP57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757759AbXJaP57
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:57:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:52499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757339AbXJaP56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 11:57:58 -0400
Received: (qmail invoked by alias); 31 Oct 2007 15:57:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 31 Oct 2007 16:57:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+guMcfs3ig4N8KvgC+CYcj8hFAmKtEFPssPp4hH6
	3rLuWoOu0kKB56
X-X-Sender: gene099@racer.site
In-Reply-To: <200710311621.09845.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62847>

Hi,

On Wed, 31 Oct 2007, Johan Herland wrote:

> Well, to a certain degree (and depending on your level of paranoia), 
> you're always responsible for the code entering your own repo, and you 
> could always set up a hook disallowing ".gitgrafts" (or whatever it 
> would be called) from entering your repo.

Yeah, right.  And you could also stay in an oxygen tent the whole time to 
avoid being infected with some virus.

Seriously, your proposal does not make any sense.  If you have to set up a 
hook to get the _sane_ behaviour, something is really wrong.  So I do not 
really understand why you brought up this idea here and now.

I understand that you wanted to end this discussion, but I could _not_ let 
your statement stand uncorrected.

Ciao,
Dscho
