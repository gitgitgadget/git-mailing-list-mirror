X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Jakub Narebski <jnareb@gmail.com>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Sat, 28 Oct 2006 15:53:05 +0200
Organization: At home
Message-ID: <ehvnal$tjg$1@sea.gmane.org>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
	<4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org>
	<m3mz7gheoe.fsf@iny.iki.fi>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8Bit
X-Trace: sea.gmane.org 1162043664 30682 80.91.229.2 (28 Oct 2006 13:54:24 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Sat, 28 Oct 2006 13:54:24 +0000 (UTC)
Cc: git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 28 15:54:21 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gdodh-0003DW-9d
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 28 Oct 2006 15:54:21 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gdoce-00043m-Vd; Sat, 28 Oct 2006 14:53:17 +0100
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1GdocX-00043b-Ng
	for bazaar-ng@lists.canonical.com; Sat, 28 Oct 2006 14:53:10 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GdocE-0002q1-7t
	for bazaar-ng@lists.canonical.com; Sat, 28 Oct 2006 15:52:50 +0200
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Sat, 28 Oct 2006 15:52:50 +0200
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Sat, 28 Oct 2006 15:52:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bazaar-ng@lists.canonical.com
Original-Followup-To: gmane.comp.version-control.bazaar-ng.general
Original-Lines: 199
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18927 gmane.comp.version-control.git:30376
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30376>
X-Mailing-List: git@vger.kernel.org

Ilpo Nyyssönen wrote:

> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
>> Documentation helps, though sometimes extensive documentation is a sign
>> of a problem--it takes a lot more documentation to explain how to manage
>> a branch in CVS than it does in any sensible system....
> 
> Usability:
> 
> I have used bzr, bk for development and git very little for following
> kernel development. I have followed this discussion quite well.
> 
> 1. It is easier to start using something you are already familiar
> with. (Just try to use Mac OS X with a Windows or Linux background.)
> 
> G: Something totally new and so no points from here. The way of using
> git is just so different from any other similar software.
> 
> B: Quite clearly gets points from this. Normal branches work quite
> like many other software, the checkout stuff works like CVS and SVN.

I find for example concept of branches in Git extremly easy to understand.
Bazaar-NG "branches" is mixture of Git branch and Git repository/clone of
repository. In bzr "branch" refers to abstract SCM concept as part of DAG of
revisions sourced from given revision/head/tip (git branch is very close to
it); yet another but distinct abstract SCM concept of branch as "your" line
of development i.e. path in the DAG of revisions started at given
revision/head/tip and ending in initial/parentless revision; the physical
representation: working area, metainformation, storage or pointer to
storage (when branches share storage forming so called bzr "repository").

About checkout: Bazaar mixes here "CVS checkout" model in the "bzr checkout"
command, and SCM concept of checking-out i.e. getting files from repository
(or branch in bzr) to working area.

On the other side breaking with traditional concepts of _centralized_ SCM
in _distributed_ SCM (and geared towards distributed usage) is IMVHO a good
idea. And breaking with the cruft of bad ideas of CVS is very good idea.

But I agree that in Git some terminology (and names of commands) could be
better. Some of it stems from BitKeeper background, some from the way Git
was created: bottom-up, from repository layout to fully (or not ;-) fledged
SCM. For example "pull" as "fetch + merge" is IIRC BitKeeper legacy, while
the fact that "merge" command is low-level (or mid-level) command fairly
poorly usable for user (which should use "pull ." for merging from local
branch).

> 2. Finding commands.
> 
> G: Quite big amount of commands, some clear, but some not so. With all
> the installed commands, it is even more confusing. What's the
> difference between fetch and pull and which one I should use? Same for
> clone and branch.
>
> B: A bit clearer I think, but the pull and merge does cause confusion. 
> Also the checkout stuff could be better shown in the command line
> help. With plugins like bzrtools the amount of command raises and
> confusion increases. Maybe better separation for plugin commands in
> the command line help?

In Git Users Survey (http://git.or.cz/gitwiki/GitSurvey) the answer "too
many commands" was most common answer to question 6. "What did you find
hardest?" in the survey (which survey was base on Mercurial survey:
http://www.selenic.com/mercurial/wiki/index.cgi/UserSurvey). It would be
perhaps better for Git to clearly divide commands between porcelanish (for
end user), admin (whole repository level) and plumbing (for use in
scripts).

But for example git(7) man page lists git commands clearly divided between
low-level commands (plumbing): manipulation commands, interrogation
commands, synching commands and high level commands (porcelain): main
commands, ancillary commands. The "git help" and "git --help" shows the
most commonly used git commands with short description of each command
("git help -a" show all commands). 
 
I can understand confusion between "git pull" and "git fetch"; it is
adressed in documentation. Although I think the confusion between
"bzr merge" and "bzr pull" is as great if not greater.

I don't understand the confusion between "git branch" and "git clone"
commands... unless you are confused by Bazaar-NG branch-centric approach
which mixes branch with repository.

> 3. Understanding output
> 
> G: Speaks a language of its own, hard to understand. No progress
> reported for long lasting operations.
> 
> B: Could maybe speak a bit more. Progress reporting is quite good.

Which long lasting operations lack progress bar/progress reporting?
"git clone" and "git fetch"/"git pull" both have progress report
for both "smart" git://, git+ssh:// and local protocols, and "dumb"
http://, https://, ftp://, rsync:// protocols. "git rebase" has
progress report. "git am" has progress report.

But I agree that Git tends to speak in its own jargon. But this jargon is
very clear if you are familiar with Git. BTW. some of the worst offenders
like <ent> (== <tree-ish>) is removed already from documentation.

> 4. Misc stuff
> 
> G: You have only one workspace and this forces you to use git more or
> to make several repositories. 

This is your confusion stemming from Bazaar-NG branch-centricness. In Git
working area is associated with repository, not with branch as in bzr.
Usually you have repsoitory embedded in working area, in .git directory in
top level of working area. The fact that you have only one index (but you
can specify alternate index, or switch between index files), and only one
current branch marker namely HEAD (you can switch HEAD to other branch; if
I remember correctly there is no way to specify current head other way)
makes working with multiple working areas tied to one repository more
difficult. But it is usually not necessary in Git.

In Bazaar-NG "repository" is just sharing the storage of "branches"; in Git
you can share the storage between repositories (although it is not the
default mode), or share common old history between repositories (more
common). 

> You can't just diff branchA/foo branchB/foo.

You can: either using "git diff branchA branchB -- foo" which means
difference between branches branchA and branchB limited to the differences
on branch foo (where foo can be directory name or filename), or via
"extended SHA1 reference" using "git diff branchA:foo branchB:foo" which
means compare file/directory "foo" at revision "branchA" and file/directory
"foo" at revision "branchB".

You can even diff two different _repositories_ if they are on the same local
filesystem using pasky trick described in http://git.or.cz/gitwiki/GitTips.

> You can't just open file from old branch to check 
> something while you are developing in some new branch.

You can view file from old branch via "git cat-file -p old-branch:file".

> Do I have to commit my changes before changing a branch
> in the workspace? 

You have to. But we have "git commit --amend", so if I need to do this
I usually do "git commit -m 'TEMPORARY COMMIT'" before switching to other
branch. Or you can save differences between working area and current branch
to patch file. The "git-checkpoint" proposal adresses that... in rather
heavy-handed fashion. There is also "git-stash/git-unstash" floating
somewhere in git mailing list archives.
 
> G: What is this git repack thing and do I have to use it? If yes, why? 
> Nobody told me that I should run it, but I did notice Linus mentioning
> it somewhere. Definetly causing harm for usability.

Hmm... perhaps "repack -a -d" should be shown in "git help" list of commonly
used commands output.

Having two separate formats in repository: loose (but compressed) and packed
(in one file, deltaified, compressed) has the following advantages:

0. Historical, it allowed for git to be released (deployed) early,
originally as fast content tracker and not full SCM, and to add features
based on how people used it and scripted it. It also gave Git design the
advantage of not being tailored/based on some storage mechanism, which
resulted in IMHO very clean design and concepts.

1. Security (together with format). It secures repository against corruption
stemming from: corruption during saving file, race condition, interruptions
during operation etc.; although it doesn' save against all possible errors.
That is what sold Keith on choosing Git as SCM for X.Org:
http://keithp.com/blog/Repository_Formats_Matter.html

2. Efficiency. The packed Git format is both AFAIK the densest repository
format from OSS SCM, and it is very fast to access any given revision.

3. Net format. It allows to use _exactly_ the same format for transmission
during clone and fetch; well with the exception that for "smart" protocols
git can send "thin" pack, with some deltas without bases. The latest work
in progress by Nicolas Pitre and others to convert thin pack to full pack
without exploding it into loose objects in between.


There quite frequently appears suggestion for SCM based on Git, or Git
porcelains (like Cogito) to automatically repack. Latest work on the option
to repack to not pack only loose objects, or repack everything, but to
repack given pack or repack with exception of some archive packs should
help with that solution.

> B: People migth misuse the revnos and so be confused when things won't
> work like they expected.

Revnos work only with very specific workflows.

> Conclusion: I would say that Bazaar is more usable than git.

Conclusion: I would say that Git is more usable than Bazaar.

