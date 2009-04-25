From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 14:55:36 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0904251445030.2147@iabervon.org>
References: <m24owgqy0j.fsf@boostpro.com>  <200904240051.46233.johan@herland.net>  <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>  <200904242230.13239.johan@herland.net>  <alpine.LNX.2.00.0904241655090.2147@iabervon.org> 
 <20090424213848.GA14493@coredump.intra.peff.net>  <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>  <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>  <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
 <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxn40-0006IA-Aj
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbZDYSzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 14:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZDYSzh
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 14:55:37 -0400
Received: from iabervon.org ([66.92.72.58]:45093 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbZDYSzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 14:55:37 -0400
Received: (qmail 23981 invoked by uid 1000); 25 Apr 2009 18:55:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2009 18:55:36 -0000
In-Reply-To: <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117572>

On Fri, 24 Apr 2009, Michael Witten wrote:

> > And the term is already in use for this particular case,
> > and it doesn't mean anything else at all (since, of course, the crypto
> > thing is "SHA-1", not "sha1"), and it's short (which is important for
> > making it easy to look at usage help).
> 
> What happens when SHA-1 is shown to be broken or there is a better
> alternative? Then we'll see "sha1 for historical reasons"... bleh!

Why do you think SHA-1 has anything to do with it? Git's sha1s could just 
as easily be 160 bits of a SHA-256 hash and there wouldn't be any 
user-visible difference. The term doesn't imply any particular significant 
connection to a particular algorithm. It could be like "pencil lead", 
which has never been made of lead, but is called that for no particularly 
important reason.

	-Daniel
*This .sig left intentionally blank*
