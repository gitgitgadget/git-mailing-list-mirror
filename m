From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 02:25:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807170218280.4318@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com> <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com> <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness> <20080716224954.GL2167@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 17 02:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJHJU-0007FM-Pc
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 02:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759637AbYGQAY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 20:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759636AbYGQAY1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 20:24:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:40278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754776AbYGQAY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 20:24:26 -0400
Received: (qmail invoked by alias); 17 Jul 2008 00:24:24 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp057) with SMTP; 17 Jul 2008 02:24:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199RzJ3d/R9w56MngiKPxjvny8eBfeK26bNtFM52/
	kVu/iNS3pjJOOQ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080716224954.GL2167@mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88789>

Hi,

On Wed, 16 Jul 2008, Theodore Tso wrote:

> I've already said I agree with you, but maybe it would be helpful if you 
> focused the discussion a little more with a concrete suggestion about 
> how we could improve the user-visible documentation.

Well, I was not sure if I was full of shot or not.

> So a concrete suggestion might be to move the list of plumbing commands 
> from the top-level git man page to a "git-plumbing" man page.

I think that would not help much.

As I replied to Dimitry, I could imagine that moving the plumbing into its 
own manual section would be a way.

> I'll note that the git user manual is pretty good about avoiding the use 
> of git plumbing commands.  It's not until Chapter 9, "Low Level Git 
> Commands" that it start going into the plumbing.  (There are a couple of 
> mentions of git rev-parse before chapter 9, but that's about it that I 
> could find).

Well, rev-parse is one of my pet peeves this day.  rev-parse is _nothing_ 
but plumbing.

> Was there other git documentation where you think there is too many 
> references to git plumbing?

Actually, the problem arose with a few "tutorials" on the web, and their 
creators violently arguing for their ways (and me being more and more 
uncertain if they are wrong or me).

And then I saw people on IRC doing the same thing.  Realizing that the 
recipients of the "help" were more confused than before, and just typed 
what was written (they would probably even have typed "rm -rf $HOME") 
because they had given up trying to understand.

Ciao,
Dscho
