From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 03:01:15 +0200
Message-ID: <20080717010115.GD18558@leksak.fem-net>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <20080716220946.GC18558@leksak.fem-net> <alpine.DEB.1.00.0807170120170.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 03:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJHt3-0006Fu-SR
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 03:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759105AbYGQBB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 21:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759207AbYGQBB1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 21:01:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:46484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759066AbYGQBB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 21:01:26 -0400
Received: (qmail invoked by alias); 17 Jul 2008 01:01:24 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp062) with SMTP; 17 Jul 2008 03:01:24 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/ekToyE2beBaY4PcSHCitdWbgn1mfIkdP5UuzNQP
	0d5zH6bP+rTqm2
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJHrv-0005x1-G2; Thu, 17 Jul 2008 03:01:15 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807170120170.4318@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88795>

Hi,

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 17 Jul 2008, Stephan Beyer wrote:
> 
> > I also think that for a user it is totally irrelevant if it is plumbing 
> > or porcelain she is using, as long as it works. I mean, if I tought 
> > someone using git, I'd never use the words "porcelain" or "plumbing".
> 
> So you would say that remembering the name "rev-parse" is just as easy as 
> remembering "show"?

"show" is an intuitional name, "rev-parse" is not.[1]
But that wasn't my point. The point was, that it is not important to a
user whether the tool is called "plumbing" or "porcelain"; that these
terms have no value for the user, if she just wants to get a job done.

Of course, "usually" porcelain is more helpful and as I've said (or
at least tried to say), I don't think there is any plumbing that's
useful for a git beginner.

Regards,
  Stephan

Footnote:
 1. A further comment about the intuitionality or "remembering":
    git-apply is plumbing and has an intuitional name (hence easy to
    remember), git-am is porcelain and does not have one.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
