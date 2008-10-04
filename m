From: Christian Couder <chriscool@tuxfamily.org>
Subject: GitTogether topics status (4th of October)
Date: Sat, 4 Oct 2008 18:16:40 +0200
Message-ID: <200810041816.41026.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 18:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km9na-0005Q8-Ud
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 18:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYJDQNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 12:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYJDQNr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 12:13:47 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:57490 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbYJDQNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 12:13:46 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 229DB3EA114;
	Sat,  4 Oct 2008 18:13:39 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 5DD193EA0EB;
	Sat,  4 Oct 2008 18:13:38 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97472>

Hi,

As can be seen on the GitTogether page on the wiki: 

http://git.or.cz/gitwiki/GitTogether

the planned speakers/topics changed a lot during the last weeks and are now:

- Johannes Schindelin (Google Tech Talk, 1 hour):
	Contributing with Git (or: all your rebase are belong to us)

- Shawn O. Pearce (Talk + Brainstorm, 1 hour):
	Introduce the secret bundle project

- Shawn O. Pearce (Talk + Debate, 0.5 hour):
	JGit, where is it going?

- Shawn O. Pearce (Talk + Plan Hacking, 1 hour):
	Pack v4, what's stopping you?

- Sam Vilain (?):
	GitTorrent, Git as a DB backend, perl.git conversion

- Junio C Hamano (Talk, 1 hour):
	Git Chronicle, Recent Additions to Git

- Scott Chacon (Talk/Discussion, 1 hour):
	Linkable library, Scriptability

- Scott Chacon (Hack Session(proposed)):
	Architecting / Building a usable linkable library

- Scott Chacon (Lightning Talk, 10 min):
	iGitHub - git daemon and repository browser on the iPhone

- Tom Preston-Werner (Talk/Discussion, 1 hour)
	Git ideas from GitHub

- ? (Talk/Discussion, 1 hour):
	New git homepage hammering out

- ? (Talk/Discussion, 1 hour):
	Git GUI that even a designer would use

There are still many things that are not clear or undecided. So more input 
is welcome.

The topics suggested on the wiki are:

 * GitTorrent: current state, security considerations, future direction
 * Submodules: how to make a UI for this important feature that is intuitive 
and complete
 * PackV4
 * JGit, quo vadis?
 * Using Git for everything but source (Git as a backup tool, how to handle 
large blobs, using as a DB back-end, etc)
 * How to make Git more attractive to the Google Code folks?
 * Success/War stories (big wanking session for Gits)
 * perl.git - the joy of grokking Perforce metadata using Postgres, and 
writing a transactional git-fastimport exporter SamV
 * Linkable library for basic object access (libification or new library)
 * Scriptability, using git in other languages (using interfaces vs calling 
plumbing vs reimplementting) 
 * Git GUI that even a designer could use (GitCheetah, AKA TortoiseGit?) (UI 
session?)
 * Git integration with IDE, RAD, and editors (UI session?)
 * New Git Homepage hammering-out (UI session?)
 * Shawn's current bundle related secret project
 * TopGit introduction/design/integration(?)
 * Pasky's current pickaxe related "secret project" (if tangible by then)
 * Extending Git with volatile metadata database (see 
[http://mid.gmane.org/20080910164045.GL10360@machine.or.cz 
20080910164045.GL10360@machine.or.cz])
 * Git improvement ideas gleaned from creating and running Git``Hub as a 
social layer on top of Git
 * Git Survey 2008 results and discussion
 * Free form "We tried to use git in our project this way, didn't work very 
well" session, where participants are not allowed to say "Your workflow is 
broken".

Thanks,
Christian.
