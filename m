From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Thu, 11 Sep 2008 22:14:17 +0200
Message-ID: <200809112214.18366.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 22:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsZr-0006gZ-Pt
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYIKUOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2008 16:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYIKUOf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:14:35 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:13185 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYIKUOd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:14:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so61949and.103
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Lo0RF5YXFUfqcJsswXoVOpLkNcBMbYmsrC+xJmaDcKM=;
        b=ACBIrDrE7So2CYRF2AXFvPyu5MVXlB527b9jRwUlxq4PNr+05lOThxrrJ9gE93x+77
         LUfXA7OqPv2Q0z69b2wmzIa7fEs3h8UsIx9AOjEKXgZ9QYNQBBc7504fAIp1MnMVNMYx
         yuzj615JsZVa8erTtwkcluQOMbN1NtG27blHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=GrvgclFZCMNr9qKD4n+TcKzWcArFC47Ta5clrq0zYK9QWiKnGX/6n6QYhJ2xAIbrlo
         scRUwAQQksmS87GgnonsDXisvK90pPwmmsvU2E+aIh5PbT4m0UlCXLBqWPXXx9ogKsKk
         wvPYABD4hO41mq2CLg+avj8ZpSaR1mvnVIkus=
Received: by 10.86.27.19 with SMTP id a19mr2456189fga.56.1221164067745;
        Thu, 11 Sep 2008 13:14:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.193])
        by mx.google.com with ESMTPS id 3sm9980382fge.3.2008.09.11.13.14.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 13:14:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809031607.19722.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95638>

This is partial summary of Git User's Survey 2008 for the state from
Sep 09, 2008, with almost 2300 responses (yes, _thousands_ responses).
It is based on "Analysis" page for this survey:
=A0 http://www.survs.com/shareResults?survey=3DM3PIVU72&rndm=3DOKJQ45LA=
G8

We have around 2295 individual responses (excluding 21 responses in the=
=20
'testing' channel), for the time I got those data, as compared to
683 individual responses for 2007 survey, and (I think)
115 answers (Base =3D 115) for 2006 survey.  That is a lot,...
I wonder how many replies we would have at the end of survey, Oct 10?


---
Below I concentrated on questions related to other SCM, although not al=
l
those questions were from "Other SCM" section.

12) What other SCM did or do you use?
    (Matrix - One answer per row)

The table below is sorted alphabetically, with exception of 'custom'
and 'other' which are put at the end.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SCM                    |  Never     | Used it    | Still use
--------------------------------------------------------------
AccuRev                | 60% (1227) |  0%    (6) |  0%    (1)
Arch (or clone)        | 54% (1108) |  7%  (136) |  0%    (1) 11
Bazaar-NG              | 47%  (969) | 12%  (257) |  4%   (76) 7
BitKeeper              | 55% (1135) |  5%  (111) |  0%    (3) 12
ClearCase              | 53% (1101) |  7%  (151) |  2%   (37) 10
CVS                    | 12%  (242) | 62% (1277) | 13%  (260) 1=20
Darcs                  | 48%  (990) | 13%  (262) |  2%   (48) 6
Mercurial              | 40%  (819) | 18%  (379) |  8%  (174) 5
Monotone               | 55% (1136) |  5%   (95) |  1%   (16) 14
MS SourceSafe          | 46%  (949) | 19%  (401) |  1%   (20) 3
MS Studio Team System  | 57% (1173) |  3%   (56) |  0%    (9)
Perforce               | 51% (1045) |  9%  (191) |  3%   (64) 9
PVCS                   | 56% (1157) |  5%  (100) |  0%    (3) 13'
RCS                    | 43%  (881) | 19%  (389) |  3%   (59) 4
SCCS                   | 56% (1146) |  5%  (100) |  0%    (7) 13'
Subversion             |  3%   (59) | 35%  (726) | 59% (1217) 2
SVK                    | 51% (1043) | 11%  (226) |  1%   (15) 8
=2E.............................................................
custom (non-published) | 54% (1115) |  4%   (90) |  1%   (22)=20
other                  | 51% (1042) |  5%   (98) |  1%   (22)=20
--------------------------------------------------------------
Total respondents      |                2060
skipped this question  |                 235

Side note: each of version control systems have at least one
respondent which still use it.  That was not assured.


Top 5 "still use", which should mean version control system which
are used beside, and together with Git.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SCM                    | still use
-------------------------------------
1.  Subversion         |  59% (1217)
2.  CVS                |  13%  (260)
3.  Mercurial          |   8%  (174)
4.  Bazaar-NG          |   4%   (76)
5.  Perforce           |   3%   (64)
=2E....................................
7.  Darcs              |   2%   (48)
10. Monotone           |   1%   (16)

Note that 10th place for Monotone excludes 'custom' and 'other';
otherwise it would be 12th.

Analysis: Subversion (SVN) is most popular, eclipsing all other SCMs.
This might be caused by the fact that git-svn is very good in
integrating Subversion with Git enhances and emphasizes popularity of
Subversion.  CVS, at time very popular, leaves the field to Subversion
(advertised as replacement fo CVS, as "CVS done right") and other
systems.  This agrees with the number of people which have above
version control systems in Ohloh software stack [need new analysis for
final version; for now you can use data from GitSurvey2007 page at git
wiki], and with Debian Popularity Contest (popcon) [here also new data
is needed].

A bit suprising for me is high place of Perforce.  Another strange
thing (and a bit alarming) is that MS Visual SourceSafe has higher
place than Monotone; but that might be caused by different design and
different target groups of Monotone and Git, which might have caused
that the communities have almost no overlap; people choose either Git
or Monotone, one or the other.  BitKeeper has also a very low number
of active users among Git users... but that is not that strange,
considering history.

See also "Adoption of various VCSes" blog post by Newren:
http://blogs.gnome.org/newren/2007/11/17/adoption-of-various-vcses/
which is less than year old.  This essay includes proprietary SCMs
like Perforce.


Top 5 "used it" (assumption: no longer in use) version control
systems.  Replaced by Git or other SCM, tried and abandoned, etc.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SCM                    | used it
-------------------------------------
1.  CVS                |  62% (1277)
2.  Subversion         |  35%  (726)
3.  MS SourceSafe      |  19%  (401)
4.  RCS                |  19%  (389)
5.  Mercurial          |  18%  (379)
=2E....................................
6.  Darcs              |  13%  (262)
7.  Bazaar-NG          |  12%  (257)
14. Monotone           |   5%   (95)

Note that again 'other' and 'custom' are excluded.

Analysis: We can see here former glory of CVS, which was once standard
for version control system.  Its predecessor, single-file locking
version control system, RCS is also visible.

A bit suprising is 3rd place of MS Visual SourceSafe; I really hope
that it is either "I took a look at it and ran away", or "I had to use
it but fortunately no longer". And what do you think about this?


13) Why did you choose/use Git? (if you use Git)=20
    What do you like about using Git?=20
    (Open ended text - Essay)

Total respondents       1723
skipped this question   572

14) Why did you choose/use other SCMs? (if you use other SCMs)=20
    What do you like about using other SCMs?=20
    (Open ended text - Essay)

Total respondents       1329
skipped this question   966


25) How do you publish/propagate your changes?=20
    (Choice - Multiple answers)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
method                  | using it               =20
--------------------------------------
push                    | 91%  (1740)
pull request            | 29%   (551)
format-patch + email    | 22%   (414)
git bundle              |  2%    (39)
=2E.....................................
git-svn                 |  26%  (498)
other foreign SCM^[*]   |   2%   (45)
=2E.....................................
other                   |   2%   (32)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Total respondents       |       1904
skipped this question   |        391

=46ootnote:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[*] publishing to other foreing SCM:
  + Bazaar,      using git-bzr
  + CVS,         using git-cvsexportcommit
                 using git-cvs (probably git-cvsserver)
  + ClearCase,   using custom scripts
                 unspecified method
  + Perforce,    using git-p4
                 using git-p4-import
                 using patch
  + Mercurial,   using fast-import (?)
                 using email + hg mq
  + AccuRev,     using git-acu
  + Quilt,       using email
  + SourceSafe,  using shared workdir
                 using custom scripts
  + Subversion,  using shared workdir (?)
  + SVK,         using shared workdir
  + RCS,         using custom scripts
  + TeamWare,    using git-tw (unpublished yet)


Analysis, as pertinent to "other SCM" question: as you can see git-svn
is very popular, just below pull request (which probably include
GitHub social interface), and slightly higher (!) than format-patch
plus email, i.e. patch-based workflow.


26) If the way you publish your changes is not mentioned above,
    how do you publish your changes? Please explain.=20
    (Open ended text - Essay)

Total respondents         95
skipped this question   2200

Here are listed only methods which are truly not mentioned above
(for example publishing to other SCMs usually doesn't count).
I have also tried to remove duplicated entries:
 * git-bzr allows for bidirectional syncing with a git
   repository. Useful when a project is hosted in Bazaar.
 * Standard diff file encompassing all changes for a specific feature.
 * On one machine, I use rsync to push my repository upstream by hand
   (for HTTP access).
 * Personal use only (many responses).
 * we also use a script that uses various git=3Ddiff concoctions to
   generate patch bundles
 * format-patch + lighthouse;
   We create patches and attach to tickets in Lighthouse
   (lighthouseapp.com) for several open-source projects.
 * Patches on reviewboard
 * format-patch and attach to bugtracking system
 * Just so I can be a little more specific about how I publish. I
   primarily use stgit and then put the patches in an issue tracker
   (like trac).
 * I do format-patch. Then I've written a script that posts to
   pastebin.com My friend uses another script that downloads from
   pastebin.com ;)
   NOTE: why don't use gist.github.com, or even just GitHub...
 * forum or IRC to the project owners
 * format-patch and uploading to a webserver.
 * format-patch + save patch on wiki page
 * "git diff > my.patch" and upload to the drupal.org issue queue.
 * after-push hooks on github to campfire/lighthouse/twitter
 * GTP (Git Torrent Protocol -- my own implementation)
 * git archive
 * gitweb's snapshot/tarball plugin
 * Since my hosting provider is temperamental, I have many projects in
   a strange hierarchy, and I want to recreate my repository
   precisely, I just tar up my master folder and upload that.
 * Because of a retarded network setup out of my control, I use a
   disgusting script based on git clone --bare, tar, scp, ssh, and
   rsyncing.
 * Sometimes as simple and stupid as tarball / scp
 * Transport of entire repositories via CD/DVD.
   NOTE: wouldn't it be easier to use USB stick and bundles?
 * copy the whole changed file or tell them what to change since some
   windows people do not know what a patch is or how to apply it :-/
 * I use git for a repo with lots of huge files (RAW image files). git
   pull/push insists on packing up objects but I'd rather have one
   object per file in .git/objects, so I rsync those and then pull the
   changeset history via std means.
 * For all my projects, I set up a post-update hook on my dreamhost
   account to force update. I use a standard remote named "stage".
 * Package a RubyGem and upload it to the files area of the relevant
   RubyForge project, and make sure the same RubyGem is in my Git repo
   so GitHub will generate a gem as well.
 * Custom scripts for pull requests and patchbombing

An interesting comment:
 * At work I use git for tracking one project I work on. It is a
   project with Unix line endings in some files, and Windows file
   endings in the other. My company uses VSS which cannot handle Unix
   line endings and otherwise is not very powerful. So I use git to
   track my history, but use VSS as backup repository. Also I git pull
   my git repository to a backup repository on a network drive.

An explanation of choices:
 * There are cases where I will push to continuous integration
   repositories to get a specific tree tested. Otherwise it is all
   about pulling.
 * I do not publish my changes. Other people can access a copy of my
   code, but I do not use a git repository on a server. I do not
   understand that concept good enough (hint: that needs docs for
   total dummies)
 * I only use git for cloning/pulling repo's for now, since it is too
   hard to use. I don't have a lot of spare time to learn it since svn
   is easy and useful. I would use it if there was a doc that explains
   it to us svn people.

And there is also:
 * For 27 and 28, there is no "I don't know< I'm using the GUI's",
   so I'm not ticking the answers
 * I don't know!
 * GitHub; Gitosis; Capistrano
 * Send them to somebody who has git access.
   NOTE: probably format-patch + email
 * can some one provide free private git service?
   ANSWER: There are many free _public_ git service, and a few
   non-free git services offer private repositories (e.g. GitHub)

 * Carrier pigeon


Analysis: as you can see format-patch + <something>, where <something>
is not email or mailing list, but issue tracker, wiki, patch queue or
other web site/web application is quite popular. =20

Some people use different combinations of tar/zip and scp or other
transport, or rsync, or ssh to simply transfer the whole repository
(some of which might be migitated by using bundles instead, but only
if there is access to shell account on remote site and there is git on
remote site to "unpack" bundle).  Sometimes it is caused by the lack
of decent features in a web server, sometimes it is lack of knowledge.


15) Do you miss features in git that you know from other SCMs?=20
    If yes, what features are these (and from which SCM)?=20
    (Open ended text - Essay)

Total respondents       1046 (some/many of them wrote 'no')
skipped this question   1249

This is just a very quick summary, based on a first few pages of
responses, Full analysis is I think best left for after closing the
survey, because I think this would be a lot of work...

So here is preliminary list, or rather beginning of one:
 * sparse/partial checkout and clone (e.g. Perforce)
 * better MS Windows support (CVS, Mercurial, Darcs, Bazaar)
 * integration with IDE/RAD/editor/filemanager
 * good GUI/visual tools/graphical shell (on multiple platforms)
 * 'soft' locking aka. watching files (like in ClearCase)
 * equivalent of 'hg serve': fast web interface and pull-server
   in one (Mercurial)
 * better documentation (svnbook, hgbook, generic)
 * traversing history of individual file (unknown SCM)
 * better interface for staging individual changes
   (Darcs interface is better than 'git add -i')
 * better UI for submodules (less commands to issue, like in Subversion=
)
 * integrated conflict resolution tool
 * tracking empty repositories (Bazaar)
 + It would be helpful to have something like "comments" in monotone.
 + hackability and portability of Mercurial
 + good Unicode support, the current implicit handling sucks
 + Hg had less commands to do the same :) (Mercurial)
 + big file support (ClearCase)=20
 + maybe a 'info' style command where it lists all branches, tags,
   remotes and repo specific config. Rather than using separate
   commands.
 + I don't miss any *feature* from SVN, but I do miss some of the
   terse commands. Reverting my local changes to a file in Git always
   feels like hard work, and in SVN it's a dead simple command, etc.
 + svn:externals from subversion (especially the part where one can do
   partial imports from other repositories) something in the likes of
   hgforest, i.e. having 'live' submodules which are not fixed to a
   specific revision (from Mercurial)

 * better support for tracking third party tools like 'piston'
   for Subversion.
   NOTE: there is 'braid', formerly 'giston' for git
 * mainly fine-grained commit support (staging diff hunks),
   branch management, stashing
   NOTE: all of this is available in modern Git
 * easier to use commit identifiers. "It's hard to memorize the
   seemingly random commit hash (even the short 7-character ones)."


Note that people used this question to put feature requests, instead
_only_ things from other SCMs that they are missing in Git; and even
when they did correctly, they forgot often to state _which_ SCM is
given feature from.

--=20
Jakub Narebski
Poland
