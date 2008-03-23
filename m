From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 19:07:35 +0000
Message-ID: <80eja1uumg.fsf@tiny.isode.net>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
            <20080323182102.GA22551@bit.office.eurotux.com>
            <20080323190017.GB16893@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>, Theodore Tso <tytso@MIT.EDU>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:08:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVYc-0004FM-47
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758422AbYCWTHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126AbYCWTHj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:07:39 -0400
Received: from rufus.isode.com ([62.3.217.251]:60310 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758422AbYCWTHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:07:39 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <R-aqdwBh6MZy@rufus.isode.com>; Sun, 23 Mar 2008 19:07:36 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Sun, 23 Mar 2008 19:07:35 +0000
X-Hashcash: 1:20:080323:mh@glandium.org::KzJHsdzSvyUjdPtv:002lhZ
X-Hashcash: 1:20:080323:luciano@eurotux.com::YrZ0GedgvhUc/TUK:0000000000000000000000000000000000000000007i6t
X-Hashcash: 1:20:080323:tytso@mit.edu::+MtA0PxXMZXVT/vS:00000nfE
X-Hashcash: 1:20:080323:hpa@zytor.com::TnYVDeQ4NOYBk+v1:00001mMn
X-Hashcash: 1:20:080323:git@vger.kernel.org::0VAurfApp5cbf75D:000000000000000000000000000000000000000000FvuA
In-Reply-To: <20080323190017.GB16893@glandium.org> (Mike Hommey's message of "Sun\, 23 Mar 2008 20\:00\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77945>

Mike Hommey <mh@glandium.org> writes:

> On Sun, Mar 23, 2008 at 06:21:02PM +0000, Luciano Rocha wrote:

[...]

>> I use git checkout path ...
>> 
>> Isn't that the same thing?
>
> Yes, it does the same. Note there is unfortunately no shorthand for
> git show $arbitrary_commit:$path > $path

Isn't that what 

      git checkout $arbitrary_commit -- $path

does?
