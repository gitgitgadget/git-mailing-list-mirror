From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Git User's Survey 2007 unfinished summary continued
Date: Sat, 13 Oct 2007 00:08:18 +0200
Message-ID: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 00:26:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgSgL-0004QC-2u
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 00:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519AbXJLWIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 18:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758578AbXJLWIW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 18:08:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:56471 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759489AbXJLWIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 18:08:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1124841wah
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MLaU1qNt8KA2mNkMJoEGrvACFvwhJmzAewfDNaqYsHo=;
        b=mH0lmpkQA2JwvR7sd+IEIq4utEDqbu+NeD2JrvijUzeq6ONavyptr28Ibk7al/9iLxqU0R/RNUJ2MMewdNd5+Bj6jF/to+XlEgqXUbCs8sRpgfOUzkzg3MNJYEkYdqDMB8pXS63E670NALdiE2SFWUf6syhtMymjAAfvZ/EecQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PgLF5Z6riGzxFW59Sw0cw57sN6zqeeQV5C1KnyICacMCHEv+52qG2kPOnv9k8dYxthCwwAogNNO84KQDR+/RsNSrXk7DhMFods/yAB6ravAhEPN/OGJmFPGWc+DV1CC1eSQ9Qb4VacTdZDyfhu7F+bdEbfShjsRXmadyHGQTOB8=
Received: by 10.114.178.1 with SMTP id a1mr3999576waf.1192226898478;
        Fri, 12 Oct 2007 15:08:18 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 12 Oct 2007 15:08:18 -0700 (PDT)
In-Reply-To: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60707>

This is continuation of partial summary of Git User's Survey 2007,
ending at state from 28 September 2007.
(response ident "46f95167c967b").

The survey can be found here:
  http://www.survey.net.nz/survey.php?94e135ff41e871a1ea5bcda3ee1856d9
  http://tinyurl.com/26774s

The data this summary is base on can be found here:


----
There were 683 individual responses


Other SCMs
~~~~~~~~~~

13. What would you require from GIT to enable you to change,
    if you use other SCM for your project?

  TO DO
  474 / 683 non-empty responses

List of answers, without count (which for this question is, I think,
less important), divided into broad categories, is shown below

Generic
 * being more user-friendly, easier to use
   more friendly output from commands
   better and clearer error messages
   stable command semantics
 * reduced number of (visible) commands
   clear separation of plumbing and porcelain
 * consistent set of commands
   consistency if command flags
 * easier to learn (easier learning curve)
 * more stability
 * support UTF-16

 * A clearer UI. Read the monotone list archive. 70% of the mails are
   UI related. The result is an clear and easy to use intuitive UI
   that does what you expect in most cases.

Performance
 * better performance on massive trees (FreeBSD)
 * good speed on NTFS (MS WIndows)

Documentation
 * a good documentation
   user/installation documentation
   troubleshooting guide
   'Git For Dummies', 'The Git Book'
 * documented workflows (including centralized repo workflow, or at
   least documenting how and why replace it with better workflow)
 * development model tutorials
   more example usage
   best practices
   case studies
 * guide for designing a branch policy for a shared repository
 * screencasts
 * documentation in one's native language
 * good in-depth administative documentation
 * maybe git-tutor program

Specific features
 * partial-tree checkouts (partial checkout)
   checking out arbitrary subdirectories
 * granular permissions (ACL) within the tree
   e.g. restricting translators to the po/ subdirectory
 * shallow clone from a given commit: git clone --depth <commit>
 * automatic (re)packing
 * lightweight working copies
 * better and well documented submodule support
 * multi-project support / multiple sandboxes support
 * git-bind/unbind (like in bzr)
 * git-sync
 * cvs-compatible syntax as an option
 * tracking empty directories
 * more friendliness with corporate firewalls
 * ability to preserve permissions/modes/EA of files and directories
   access control features /  visibility access control
   disabling some users from accessing certain parts of the repository
 * being able to merge directories (instead of branches)
 * FastCGI gitweb
 * some embedded keyword capabilities similar to those provided by CVS
   and Subversion
 * ignore files during merge
 * R/W git server (allow push), with NIS, LDAP support
 * pull/rebase into dirty tree
 * clearcase dynamic view-like support (externally?)
 * better http(s) push via WebDAV: hooks
   working and easy to setup push over https
 * plain simple FTP upload (push) and download (clone, fetch)
 * better working through corporate firewalls

Portability
 * native MS Windows support, easy installer package
   even better support for all platforms
   easier setup on Solaris and AIX
 * pre-prepared _static_ binaries for FreeBSD, MacOS X, MS Windows
 * less dependencies
 * support for more platforms
 * a portable version of git, one binary + library (gitbox)
 * Windows version(s) mentioned on homepage

GUI
 * better (G)UI
   TortoiseGit for MS Windows, or other Windows front-end
   good, advanced GTK+ 2.x tool to visualize git
 * history graph conected to file tree in GUIs
 * easier management of remotes using GUI
 * better diff viewing tools (side-by-side, like KDiff3)

Other SCMs
 * seamless import
   BitKeeper / ClearCase import/sync
   tool to import TeamWare history into Git
   better SCM interop
 * SCM rosetta / "Git for <SCM> users" documentation
 * import/export tools supporting incremental import and export
 * 100% subversion interoperability
 * git update (stash, fetch, rebase, unstash) a la CVS
 * git-svnserve
 * svn:externals support

Tools
 * improved administrative tools
 * reasonable plugins for IDE (e.g. Visual Studio, KDevelop, NetBeans)
   full Eclipse / NetBeans / IntelliJ support
 * good integration with apps like Trac and Bugzilla
   work with continuous integration tools (cruise control etc...)
 * Git+Launchpad
 * libification (for tools support)

Other
 * SourceForge / Gna! / Google Projects support
   (free) hosting with git facilities
   FOSS hosting sites supporting git
 * commercial support / corporate backing
   contractual service
 * number of users, to convince my co-workers that they're not
   a silly minority
   popularity
 * projects switching to git
 * user education
 * marketing, advocacy videos
 * convincing coworkers / other members / boss
   willingness of the other developers to learn to use it
 * training/certification
 * a stop to the constant bashing of other SCMs - this doesn't get you
   any friends drop the arrogant attitude, work with the rest of the
   community and try to make something people can understand in an
   hour

 * http://wiki.FreeBSD.org/VersionControl

 * At work it'd require some kind of miracle. Huge Perforce repository
   of highly interrelated stuff in which people can make sweeping
   changes in a single changelist. Lots of tools that access Perforce.
   Slow as hell.



Getting help, staying in touch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

61. Did you have problems getting GIT help on mailing list
    or on IRC channel? What were it? What could be improved?

  TO TABULARIZE
  99 / 683 non-empty responses


Problems and suggestion for mailing list:

 * I answered my own question and no one even commented it. User and
   development discussion should be separated. Just release
   announcements in the user list.

   You need another mailing list for users. The current mailing list
   is very developer centric.

   The mailing list feels like it's more for developers rather than
   users and it's a little intimidating to ask newbie questions there.
   Maybe separate git-users and git-dev lists would make sense.

   Git mailing list needs a users and developers list. Mixing up the
   two is intimidating with all the traffic and the number of patches
   and advanced topics that shoot around.

   Having separate git-users and git-devel lists would be nice. I
   might read both but I hate to ask a newbie question on a list where
   50% of the submissions contain patches.

   (Other users find mailing list very responsive. Splitting the list
   into either git-devel and git-users, or git and git-announce has
   its advantages and disadvantages. You can always filter out patch
   submission and comments on patches thanks to the "[PATCH .*]"
   prefix convention present on mailing list.)

 * A question or two with no response at all. In hindsight my query
   was way too long-winded but it's still frustrating to be ignored.

   I answered my own question and no one even commented it.

   (See above)

 * The git mailing list is too high traffic to remain on. Maybe split
   it into a few lower traffic versions?

   Biggest problem is that smaller problems are getting lost in the
   growing size of the mailing list.

   The sheer amount of traffic makes the mailing list hard to deal
   with sometimes.  Getting your email tools set up correctly can help
   (i.e. auto tag+archive in GMail), but ultimately you still have to
   wade around in hundreds of emails you don't care about in order to
   find the ones you do care about.

   (Most people find traffic levels on git mailing list OK, see
   question 58.)

 * Will not go through corporate firewall.

   (I think it was about mailing list, but perhaps it was about IRC)

   I no longer subscribe to the GIT mailing list as ML subscription is
   forbidden at my new job, and I have no time at home to read it all.

   (You can read git mailing list through many archives / web
   interfaces, including MARC and GMane ones, and throught NNTP
   (aka. Usenet, aka news) interface on GMane. You don't need to be
   subscribed to git mailing list to post.)

 * People responded quickly to mailing list queries usually helpfully.
   However there was occasionally a touch of annoying 'groupthink' to
   the responses; sometimes new users are just confused and really
   would be better served by just changing their working habits, but
   other times there appeared to be a bit of tunnel-vision on the part
   of the longtime git users.

 * Trolls could be thrown out ;-) Seriously we had only a few there,
   but they are mighty annoying.

 * Mostly no. But little help on applying email-patches in win32 using
   GMail.  I'll get there though :)

   (Late addition of smtpserver (with ability to select port number),
   smtpuser, smtppass and smtpssl configuration variables / options to
   git-send-email should help with _sending_ patches using GMail. As
   to applying email-patches, git-am understand both mbox and maildir
   formats, not that it help much with win32 mail programs; but you
   can always try to save email in raw format from GMail WWW
   interface)


Problems and suggestions for IRC:

 * The IRC channel has too few people who know answers to questions;
   if you're there at the wrong time of day when none of them happen
   to be around it's useless. But if you're there at the right time
   it's pretty good.

 * IRC channel seems to respond to newbie git users quite well, but
   mid-level experience often gets no response.

 * Traffic on the IRC channel is a bit high. It may need to be split
   into a few different high-level topics in the near future.

   (IRC channel or git mailing list? I don't remember IRC channel
   having high traffic...)

 * It's hard to improve IRC. It's such a poor medium for understanding
   the communication going on.

   (On the other hand it is responsive. I think pastebins helps to
   sidestep limitations of the medium. Nevertheless the main medium of
   communication is git mailing list, not #git channel.)

 * IRC is blocked from work :-( I may try it by tunneling out.

   (Any suggestions here?)


Generic problems and suggestions:

 * Sometimes you get no answer (on git mailing list or #git channel)
   but that happens

 * People seem to think the problem isn't with git, and yet I find git
   extremely buggy and non-intuitive. Your "Git in 5 minutes" doesn't
   even include +x a hook or mention of hooks; neither does linus
   speech. If you don't +x a hook, try to figure out what is going
   on. I dare you. Git fails silently a bunch, maybe half of the time
   by design. Which shouldn't be acceptable.

   Try addressing an ssh address in url format: it isn't consistent
   and it will fail in half the apps. Same thing with git-ls-remote:
   it might have an --upload-pack that works, but this isn't across
   the board! From my own debugging none of the shell scripts have an
   --upload-pack option that work.

   (Not here. This is question about getting help from people, not
   about documentation or what you find hardest in GIT.)

 * After the last thread the GIT FAQ is almost begging for a 'Please
   don't ask about C++' section.

   (Truly, Git FAQ (which resides on Git wiki, but perhaps we should
   consider extracting it and adding to distribution tarballs) needs
   maintenance, updating and adding new frequently asked
   questions. Currently there is no FAQ maintainer.)


The other side: getting help success stories:

 * Quite the contrary. When Source Mage GNU/Linux switched to using
   GIT our developers spent a considerable amount of time asking
   questions and discussing features and bugs on #git. The feedback
   that we got was fabulous: the GIT developers were helpful
   interested in our needs and productive when it came to fixing
   bugs. One bug we discovered was even handled by Linus Torvalds
   himself and in just a matter of hours! In our eyes the GIT
   development community gained rightful reputation as one of the most
   friendly and helpful communities there is.

 * No, the mailing list has been very responsive. I have never asked a
   question on IRC but I sometimes answer newbie questions.

 * Mailing list is very interesting especially as I'm working on
   egit. IRC is more immediately helpful.

 * I'd like to say that I consider #git to be the most useful IRC
   channel I've ever been to when it came to getting answers to my
   questions. Thanks guys!

   The IRC channel is wonderful. The people there do a good job with
   questions.

 * No problems. In fact the mailing list/IRC could substitute the
   documentation but I guess that
     (1) does not work in offline mode
     (2) _is_ going to get on peoples nerves after a while
	 (recurring questions)



Open forum
~~~~~~~~~~

62. What other comments or suggestions do you have, that are not
    covered by the questions above?

  TO DO
  141 / 683 non-empty responses

There are many "keep up the great work!" (and equivalent) as answers
to this questions, and a few "worst SCM I've used". Those are excluded
from the lists below.


Suggestions for git:

 * One of the biggest complaints I hear is that mercurial's UI is much
   more 'intuitive' and user friendly.  Perhaps looking at it's
   operation and comparing/contrasting would be good.

   (Note that changing names of commands for example might be
   impossible because of historical reasons and large usebase.
   On the other hand perhaps this is just a steep learning curve,
   unavoidable for a power tool)

 * Mercurial has an excellent tutorial which had my team up and
   running in less than a hour after a week struggling to make git do
   anything useful.

   (I hope that late work on "Git User's Manual" helps here)

 * Handling of Unicode (UTF-16 encoded) files is a big pain with git.
   Even SVN can do a diff of them.

   (The idea that blob is just a bag of bytes will not change; but we
   have input/output filters, and soon before-diff filters, connected
   with gitattributes)

 * I like how in Subversion the commands work relative to the current
   directory. With Git I always seem to be dealing with longer paths
   and/or have to change to the root.

   (Running git from within directory deep within repository structure
   should 'just work'. If not, then it is an error... unless in
   situation like referring to tree-ish, where path is almost always
   relative to project root).

 * Keep up the UI simplification and make sure the docs start off with
   usage somewhat similar to CVS/SVN. I think many users are scared by
   Git because they see the more powerful commands thrown around too
   early and get scared.

   Git is just too complicated for a typical project. I understand
   it's probably great for the Linux kernel but for a smaller project
   like mine (Mesa) it's overkill and a frustration. (...)  With git
   everything seems hard. (...)  I've _wasted_ hours trying to figure
   out git. That alone is a huge issue. I guess I could go into
   specific details about my problems with git but I've already spent
   enough time on this survey.

   Figure out why people find git hard to learn and eliminate those
   barriers to entry.  Make git more task-oriented rather than
   data-model-oriented the way it is now.

   It's a great idea and a powerful tool but it's got a long way to go
   before it reaches wider adoption because it's so damn hard to use.

   (...) I'm evaluating Mercurial despite its being based on Python
   because it feels cleaner and simpler to use. I would prefer to use
   Git.

   (I think the 1.4 and 1.5 series is a good step in simplifying git
   for simple tasks and ordinary user. Core git porcelain improved
   much, and now there is no need to use plumbing for every-day tasks)

 * No one-pager cheat sheet with the 6 most basic commands on it so
   people can go use git.

   (This got corrected. There is git cheat sheet on the Internet;
   there is link on GitWiki to it)

 * Having a git library where other apps can integrate git, along with
   bindings for Python would be great.

   Make it easier to use by graphical clients like KGit.

   (The libification projects from Google Summer of Code would help
   there, I think)

 * I think that moving away from shell scripts to builtins is a
   necessary step but I don't really like it. It would help if you
   kept them around, perhaps in contrib/, so that others can learn how
   to use the plumbing (I learned a lot about git from reading these
   shell scripts).

   (Doing it: shell scripts which are moved to builtin are retired to
   contrib/examples/ directory).

 * Building git is a pain. (SHA1 sources being a problem). Can't git
   use autoconf? Also I've heard people have issues with git's
   portability (for example some BSD variant). Shell scrips weren't
   portable to non bash IIRC and often relied on GNU extensions in
   some programs. Native Windows port is also important.

   Probably the toughest challenge for Git IMO is that Mercurial,
   Darcs and Bazaar are good and similar. Lack of Windows support
   makes some people rule out Git altogether even though it may be
   better overall.

   I'd like to just stress support for windows and central
   repositories. (...) In fact most of my friends really wanted to use
   git but they wanted a solid native port.

   I think key to the adoption of git is that it is made to run on
   Windows as well as the other major OSes.

   (Git tries to use autoconf in a way that is totally optional, to do
   detection and write options for Makefile; you are welcome to
   contribute to configure.ac.  People work on making git more
   portable, for example trying to make it work with dash, defining
   in the meantime minimal POSIX-like shell compatibility required.
   Native MinGW Windows port is in the development)

 * I think that it is very nice that git is in the native OS
   repositories for Fedora. The Debian version needs updating.

   (git Makefile has rpm target, and git.spec target; perhaps this is
   the cause)

 * git-blame is manageable (with gc and reduced history etc) but that
   slowness still seems to be a negative point for many of my peers. I
   wouldn't mind better performance there either. Maybe some kind of
   optional indexing for those who want fast blame?

   (I recall there were some ideas about how to make git-blame faster
   on git mailing list.  Making it interactive for graphical blame
   tools reduced latency; there is I think a bit place for easy
   improvement for reblaming.  Maybe packv4 would help with blame
   performance...  What is I think unchangeable is the fact that
   snapshot driven / whole history driven SCMs _always_ would be
   slower at least a bit than single-file based SCMs.  This tradeoff
   is not possible to avoid.  But don't forget that git has other
   tools for examining history, like path (subsystem) limiting,
   searching commit messages, pickaxe search and graphical history
   browsing tools like gitk or qgit)

 * Get a mascot perhaps O'Reilly animal for O'Reilly GitBook
   (Git User's Manual) like the svnbook.

   (What animal could Git use for O'Reilly? Herd of horses, or a
   pony?)

 * I'm wondering what the overall goal is - git's origin as a neutral
   ground was fine but it hasn't seemed to take off as a viable
   alternative for general use.  Do you care about that?  Is it ok
   that git is it's own little niche?

   (Junio, Linus?)


Suggestions about git mailing list:

 * Git adoption will be limited by the actions and attitudes of those
   on the mailing list. 'If you can't say anything nice...'

   (We are nice, I think... to a point)

 * The ML had way too much traffic. I think there should be at least a
   git-patches@ where people submit there patches and git@ remains for
   user/dev discussions.

   (Most users find level of traffic on git mailing list O.K. It is
   not that hard to separate patch submission and their discussion
   from the rest of traffic thanks to [PATCH] prefix convention used.)


Suggestions and comments about this survey:

 * Various questions need 'other' options such as the programming
   language question. Various questions that already have 'other' as a
   possible choice need a text box to fill in the specifics.

   (I am not sure if it is possible mixing radiobutton/checkbox with
   text field with currently used free survey service, survey.net.nz)

 * The text fields (and text areas) of this survey are way too small!

   (I am not sure if changing this is possible with currently used
   free survey service, survey.net.nz)

 * You should do a survey of feature requests.

   (See questions 13, 38, 41 and especially 37)

 * Shorten survey length. This survey is too damn long. Make the
   survey shorter!

   Cut down the number of questions on this survey by a factor of 4.

   (I think removing the questions which asks very similar question
   but in different context be a good start. But that aside: which
   questions should be dropped, which concatenated (and which split);
   which are useful and which are not?)

 * Questions not asked: what can be improved on GitWiki, workflows
   used and tools used, kind of repository hosting used for project,
   programming experience level and version control experience, using
   git for non-programming repositories like ikiwiki or documents,
   perceived git stability and number of bugs.

   (The surveys is very long as it is now. Those questions are nice,
   but it would make survey too long I think.)

 * The survey asks about new features that are not in a stable version
   of git yet. git-stash comes to mind. This is silly. Not everybody
   will track your development branch. I certainly don't. I don't for
   other SCMs I use either.

   (I tried to put only features which are in released, i.e. numbered,
   version. git-stash is in 1.5.3, see Documentation/RelNotes-1.5.3.txt)

 * Regarding Q19 (How do you obtain GIT?). I actually use all three
   forms on different systems.
     Mac: pull from MacPorts
     Ubuntu: from git.git
     remote systems: tar balls.

   (Should it be made multiple choice question, then?)


Some other comments:

 * I've been so busy with other projects. I didn't realize so many
   interfaces exist.  Thanks to this survey I'll spend some time
   checking out the wiki for the other interfaces.

   I didn't even know about any of the new git features listed in
   question 43.

   I need to get an up to date version as there are things mentioned
   in this survey that I don't know about.

 * At the 'Solutions Linux 2007' exhibition in Paris I have been
   looking for a service provider that could propose some training
   sessions for Git. I couldn't find one. Maybe in 2008...

-- 
Jakub Narebski
(away from Internet)
