From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Mon, 21 Jul 2008 00:29:29 +0200
Message-ID: <200807210029.31543.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 00:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhQT-00056u-El
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYGTW3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYGTW3p
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:29:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63815 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbYGTW3o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2008 18:29:44 -0400
Received: by ug-out-1314.google.com with SMTP id h2so199762ugf.16
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hbYdPmqBgh3ZpJwvu+h4pOouDIgIPsh/9F1K3S4cKyA=;
        b=KqbyfQT3GpKO2EwxsZrTOiJ+A28Iv9MjqZcXKEIjAtLorbcKTIwJWIqEJupUY+RwD+
         4s8Rp8Yv6xRs03mrThRLc8NG38DLRfaaFZ39sWN+kJriD+4/fowxq15nnbQu4LsrZzRX
         rnpysWKhahAovmvsxS5d5o2F0AN9Z4UWmoJ7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=icxvhgraSuv5sX0UdubWJuaM1mtqRlsTmnP63cqiWJG5IrL2dk4R/EjNKg67nVAErK
         oSRvJ+TfIr7nEnYaDT0KPEihZx0ypZrjnU3V5d0iBoJjpCEDOzaYR1y3PUCZMwqkHX0a
         CH5YcbDGLBd95NxoRlcbVAgVW1oO4X3m7/Fak=
Received: by 10.66.245.2 with SMTP id s2mr1221333ugh.80.1216592979752;
        Sun, 20 Jul 2008 15:29:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.215.213])
        by mx.google.com with ESMTPS id r38sm1624108ugc.49.2008.07.20.15.29.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jul 2008 15:29:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89248>

On Tue, 8 July 2008, Jakub Narebski wrote:

> I'd very much like to have (or perhaps to wrote) some sort of interim 
> progress report for Google Summer of Code 2008 projects on 
> http://git.or.cz/gitwiki/SoC2008Projects.  Therefore I'd like you to 
> expand and/or correct those mini-summaries below.

Here is a bit late summary of this thread (and of information gathered
elsewhere).  I'll try to add this information to wiki page in approx
two days from now... of course unless project student or mentor wouldn't
do it first.
 

1. GitTorrent
 
Student: Joshua Roys
Mentor: Sam Vilain

I never got more response than "it is going slower than I would like, 
[...] Other than that, it's going well, I think." from Joshua Roys.

Mailing list archives for gittorrent mailing list doesn't show anything 
interesting, either (last post is from 2007).
  http://lists.utsl.gen.nz/pipermail/gittorrent/

Besides canonical repository gitweb
  http://utsl.gen.nz/gitweb/?p=VCS-Git-Torrent
there is also mirror at
  http://repo.or.cz/w/VCS-Git-Torrent.git

There is some activity there... but no summary of it anywhere I could 
find. (I wonder if this was the project Johannes and Shawn were talking 
about of "going dark" in GSoC 2008 podcast 018...)


2. git-statistics
 
Student: Sverre Rabbelier
Mentor: David Symonds
 
There were some posts about how git-statistics can be used:
  http://thread.gmane.org/gmane.comp.version-control.git/81534
  http://thread.gmane.org/gmane.comp.version-control.git/82027
There is post with link to different git.git statictics:
  "[GitStats] Bling bling or some statistics on the git.git repository"
  http://thread.gmane.org/gmane.comp.version-control.git/88174

A short listing of metrics done:
* stats.py author -d: Shows file activity of a specific developer
  measured in how often they made a modification to a file and total
  lines added/removed (much like a diffstat, but now for a specific
  developer instead of one commit).
* stats.py author -f: Shows file activity of a specific file measured
  in how often they made a modification to a file, could be extended to
  also count changes like "author -d"
* stats.py branch -b: Shows which branch a specific file belongs to,
  for more information on this metric see below
* stats.py commit -v: Shows all commits that are reverted by the
  specified commit, will be extended to allow detection of partial
  reverts
* stats.py diff -e: Shows whether two specific commits introduce the
  same changes
* stats.py diff -e -n: ditto, but ignores what changes were made, only
  looks at the changed lines
* stats.py diff -e -i: ditto, but inverts the comparison, instead of
  comparing addition with addition and deletions with deletions, the
  additions of the first diff are compared with the deletions of the
  second diff, and vise versa. This way a revert is easily detected.
* stats.py index -t: Shows which commits touched the same paths as the
  staged changes


3. Gitweb caching
 
Student: Lea Wiemann
Mentor: John 'warthog' Hawley

Lea has chosen caching data and memcached as example (primary) caching 
engine, wrote Git::Repo object-oriented Perl interface to git, used
it in gitweb, and added caching to gitweb.

Additionally tests for old Git.pm (simple), Git::Repo and friends, and
Mechanize based gitweb test were added.  Mechanize tests detected a few
bugs in current gitweb code: using Git::Repo and adding caching didn't 
create any new errors.

Currently first round of patches were send, and second version 
incorporating comments from is in progress.  There is a test site
(live demo) up and running on one of the kernel.org machines:
  http://odin3.kernel.org/git-lewiemann/

You can find first version of patches in 'pu' branch.


4. Eclipse plugin push support
 
Student: Marek Zawirski
Mentor: Shawn O. Pearce

Thus far Marek has completed generation of packs, including delta
re-use from packs using either v1 or v2 index, including taking
advantage of the CRC inside the v2 index to accelerate a safe reuse.
This code permits jgit to write a valid pack.

The packing code does not (yet) search for a delta base, or create
a new delta for an undeltified object.  Packing loose objects packs
them as whole objects in the pack file, resulting in little to no
reduction over their loose object size.  This is not a limitation
of Java.  Marek and I simply decided that protocol support was more
important than really tight network transport at this point in time.

As a result of being able to create pack files Marek was able to
implement the client side of git-push for the native pack transfer
service, aka push over SSH, push to another local repository (by
forking 'git receive-pack') and push over anonymous git://.

Using Marek's pack generation code Shawn added support for push over
the dumb sftp:// and amazon-s3:// protocols, with the latter also
supporting transparent client side encryption.


5. git-merge builtin

Student: Miklos Vajna
Mentor: Johannes Schindelin

> In "What's cooking in git.git (topics)" Junio C Hamano wrote:
> 
>   It already is beginning to become clear what 1.6.0 will look like.
>   [...]
>   * git-merge will be rewritten in C.

It is already in git as 1c7b76b (Build in merge).  
In Documentation/RelNotes-1.6.0.txt you can find the following:
   "* git-merge has been reimplemented in C."
 

6. git-sequencer

Student: Stephan Beyer
Mentor: Christian Couder, Daniel Barkalow
 
It started with discussion over TODO file format:
  http://thread.gmane.org/gmane.comp.version-control.git/84230
 
Now there is prototype shell script implementation (which has some 
limitations because it is prototype) in "git sequencer prototype"
  http://thread.gmane.org/gmane.comp.version-control.git/86985
  http://thread.gmane.org/gmane.comp.version-control.git/88754

The latter thread includes migration of git-am, git-rebase, and 
interactive rebase to sequencer.  

> Stephan Beyer wrote:
>   I'm using sequencer-based git-am and git-rebase-i and also 
>   git-sequencer itself for around 2-3 weeks now. So, for me, it is
>   reality-proven [...]

There were some problems with sequencer based implementation of
"git am --rebasing", or sequencer based patch application driven
ordinary rebase, but I think there were resolved.

Stephen have started the builtin sequencer (but till now no patches
were sent to list: seems to be work in progress). 

Some performance benchmarks:
 * applying 45 patches with git-am 
   - 3 seconds using the original 
   - 8 seconds using the (scripted) sequencer-based one
 * rebasing 100 commits
   -  4.8 seconds using the original
   - 10.1 seconds using the (scripted) sequencer-based one
   -  1.7 seconds using builtin sequencer


SUMMARY:
========
From those projects, "git-merge builtin" did what it was meant to do 
already.  "Eclipse plugin push support" and "git-statistics" did 
minimum what it was meant to do already, and it looks like it would be 
finished before August 11.  "Gitweb caching" is after first round of 
patches, "git-sequencer" looks like already done; I don't know what is 
the state of "GitTorrent" project.

Please correct any mistakes in this summary / writeup.  Thanks in 
advance.
-- 
Jakub Narebski
Poland
