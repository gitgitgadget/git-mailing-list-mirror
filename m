From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH 0/7] guilt patches, including git 1.8 support
Date: Wed, 16 Jan 2013 10:04:59 -0500
Message-ID: <20130116150458.GA21612@poseidon.cudanet.local>
References: <20130116022606.GI12524@google.com>
 <20130116032606.GA6052@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>,
	Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvUeU-0007Ar-3o
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 16:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab3APPLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 10:11:21 -0500
Received: from josefsipek.net ([64.9.206.49]:1654 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab3APPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 10:11:21 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2013 10:11:21 EST
Received: from poseidon.cudanet.local (208-44-138-156.dia.static.qwest.net [208.44.138.156])
	by josefsipek.net (Postfix) with ESMTPSA id 3B8941184B;
	Wed, 16 Jan 2013 10:05:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130116032606.GA6052@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213757>

On Tue, Jan 15, 2013 at 10:26:06PM -0500, Theodore Ts'o wrote:
> On Tue, Jan 15, 2013 at 06:26:06PM -0800, Jonathan Nieder wrote:
> > Hi Jeff and other guilty parties,
> > 
> > I collected all the guilt patches I could find on-list and added one
> > of my own.  Completely untested, except for running the regression
> > tests.  These are also available via git protocol from
> > 
> >   git://repo.or.cz/guilt/mob.git mob
> 
> Jonathan, thanks for collecting all of the guilt patches!  Your repro
> was also very much really useful since I hadn't grabbed the latest
> patches from jeffpc's repo before it disappeared after the kernel.org
> security shutdown.  

I had repo.or.cz mirroring all along.  :)

> Jeff, do you need some help getting your repro on kernel.org
> re-established?

Yes and no.  I was hoping to find some time to restore all the web content
on my server, and start using repo.or.cz as the public git repo.  With that
said, I have only two sigs for my gpg key.  (Guilt isn't really related to
linux...)

Thanks,

Jeff.

-- 
Only two things are infinite, the universe and human stupidity, and I'm not
sure about the former.
		- Albert Einstein
