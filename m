From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: The 8th airing of the msysGit herald
Date: Sun, 2 Mar 2008 23:30:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803022329560.22527@racer.site>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 03 00:32:08 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.171])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVxf1-0002so-Up
	for gcvm-msysgit@m.gmane.org; Mon, 03 Mar 2008 00:32:04 +0100
Received: by py-out-1314.google.com with SMTP id p69so10293571pyb.5
        for <gcvm-msysgit@m.gmane.org>; Sun, 02 Mar 2008 15:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:subject:message-id:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=wgnaQziJO7iPzY8RdTD/TFfTYR9AwbHPad3d0GsTlPs=;
        b=I+0yjgaS80CUDoxuhkhNogfLZi8pVXQRv4s2oXyb9CkHZLNEW8UcDliJvThqkGa5yR7qEo9/WWulSE83betXZSHi3PzxbRls/IfLipbSzZWhOuZ4UyqooZnodZJCa7wJuMOhS+sNXuO6QhbgshX7wObz9vOW5pgn7FBoHyFrcEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:subject:message-id:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=NCrIRNri+BIymnSrIKWPvFyjp4C7dbSQY6q260QA6XaNGCbau29RwgHUXshIcKREz+3IUhTe9MoRY5HtZVEwopDL65jiLc2VdHR6hYxkJ5Kv94Pefbw2szE+AEhBULY4pqihClPWNZqOq4fX1zjNR4X02adB7whTTZy3wBf+g88=
Received: by 10.141.63.20 with SMTP id q20mr970639rvk.9.1204500685416;
        Sun, 02 Mar 2008 15:31:25 -0800 (PST)
Received: by 10.107.168.21 with SMTP id v21gr1876pro.0;
	Sun, 02 Mar 2008 15:31:25 -0800 (PST)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.132.5 with SMTP id f5mr1976627wad.3.1204500685035; Sun, 02 Mar 2008 15:31:25 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id k36si1919637waf.1.2008.03.02.15.31.24; Sun, 02 Mar 2008 15:31:25 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 02 Mar 2008 23:31:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40] by mail.gmx.net (mp055) with SMTP; 03 Mar 2008 00:31:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JzggxsaYJYh835kggd/jr2rpZrgLYnSAFnXkm3e nVYG/RWNMeRDTI
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75855>


Good morning git land!

This dark and quiet Sunday night is as good an occasion as any to 
offer to you the 8th airing of the msysGit Herald, the 
not-quite-biweekly news letter to keep you informed about msysGit, the 
effort to bring one of the most powerful Source Code Management 
systems to the poor souls stuck with Windows. 

These are the covered topics:

	We have a working 'git svn'

	Interview with Christian Stimming

	GPL only needs to be acknowledged

	The installer was on diet

	core.autocrlf = true

	Update to a new ssh, problems with pulling msysGit

	Entering Babel: "rebase"

	git-cheetah is now a submodule



Maybe I should strike the "not quite biweekly"? But then, it _is_ not 
quite biweekly ;-) 

Anyway, here it goes, the newest issue of the Herald, subtitle "Yeah, 
we have a working git svn!" 


We have a working 'git svn'
===========================

Some time ago, we started work on compiling Perl ourselves, in order 
to be able to install the Subversion modules which are necessary to 
run 'git svn'. In the last issue of the Herald, I wrote something 
about our long and rocky road until we had a working 'git svn' (See 
the story "We managed to get git-svn to run!"). 

We played it safe, though, and had some alpha versions of a Git 
installer including 'git svn', and with good reason: Some testers came 
back and said that it would not work with https repositories, and that 
authentication was not supported. We included the necessary libraries 
and modules, cut a new Git installer, and the tests show that while it 
is slow, it works! 

While working on git-svn, we realized that there are a few scripts in 
msysGit that cannot possibly work (yet), so we excluded them from the 
Git installer. These scripts are: archimport, cvsexportcommit, 
cvsimport, cvsserver, filter-branch, instaweb, send-email, and shell. 


Interview with Christian Stimming
=================================

Christian put in a big effort to get 'git svn' to work when I got 
stuck. He did such a great job, that I decided to interview him for 
the Herald, since I could not afford to buy him a house by way of 
saying thanks. So here it goes: 

> 1) How did you get involved with Git? 

Some fellow developer in another Open Source project mentioned it and 
was enthusiastic about this new way of working. As my main reason for 
being involved in Open Source is learning new things, this got me 
curious. 

> 2) What were the reasons that you started working on Git? 

In one project I had to work with a dead lame CVS server, where each 
contact to the repository took way way too long. Discovering that git 
would import all of the history and give me access to each and 
everything I wanted to know from the history brought back the fun into 
the project. From that moment on, I was hooked. 

> 3) What do you like most in Git? 

Speed. It's so fast, it's marvellous. This doesn't quite hold for the 
Windows version, but it is still faster than any other alternatives 
that I know of. And the GUI tools gitk and git-gui did a fantastic job 
of a low entry barrier - it's now really easy to start branching and 
merging a lot. 

> 4) What do you hate most in Git? 

The command line options. Sometimes it seems to me all the really cool 
actions in git can only be invoked by a mysterious collection of weird 
option switches which 1. I've never heard of, 2. are hidden deep down 
in long manual pages which make it impossible to distinguish important 
options from the unimportant ones, and 3. change very frequently in 
new versions. For example, "git rebase -i" is a nice feature, but it 
is simply a different action than a one-shot "git rebase". Hence, if 
it is supposed to be really used, it should rather be a command such 
as "git interactive-rebase". The GUI tools go a long way to hide those 
mysterious option collections, but some of the daily workflow steps 
are still unavailable in the GUI. Rebase being the most prominent, I 
guess. 

> 5) What was the most surprising moment when working with Git? 

Seeing it up and running on Windows just as well as on Linux. 

> 6) What was the most frustrating moment when working with Git? 

Finding that "git pull" will create many more merge commits than I 
wanted, and that there doesn't seem to be an easy way of running "git 
fetch; git rebase" in one command. All in all there hasn't been much 
frustration potential in git... I guess this is a good thing. 

> 7) In what environment do you work? 

Desktop machines with Linux or Windows, always using code from a 
central SVN repository. Really: I'm switching back and forth between 
Linux or Windows, and seeing git available on Windows just as well 
makes this fun again. 

> 8) What other hobbies do you have? 

Programming. Oh, and programming. Well, there's also family: A 
wonderful wife and two cute daughters. 

> 9) What is your favourite movie? 

Schulze gets the Blues. 

> 10) What are your visions for Git? (I.e. where do you want it to 
go?) 

Git will empower the user! (Well, here the user is more the developer, 
but this doesn't rhyme as good.) The GUI tools will make it possible 
for everyone to use git instead of any of the previously popular 
central VCSs, but now with the decentralized features on top. This is 
step one in introducing a true decentralized model into the normal 
company workflows. Step two is to start using push and pull between 
the decentralized repositories, so that developers use the tools to 
represent their actual workflow. Step three: World domination! 


GPL only needs to be acknowledged
=================================

It is funny how licenses can make people speak up who normally would 
keep quiet, and so we got a complaint that we forced the users of our 
Git installer to accept the GNU Public License. 

Personally, I think it is not nice to demand changes, especially 
license changes, or changes in the visibility of the license, when you 
get the software for free. 

Also, I try to stay on the very safe side of legal issues, in order to 
avoid contact with lawyers, especially ones where they demand that I 
cross their hands with silver. So I was quite unwilling to change 
that. 

However, none less than our benevolent dictator, Linus Torvalds spoke 
up, pointing out that it is not really a _choice_. You need not accept 
the GPL, it is sufficient that you acknowledge that this is the only 
license regulating your rights with regard to Git. 

Now, that was very reasonable, so we changed it. 

Personal sidenote: I would do quite a few things for people whose work 
I benefit from every day; it is that fundamental idea of fairness (or 
tit for tat) encoded in the GPL which makes me extremely comfortable 
with that license, and I think that I am not the only one. 


The installer was on diet
=========================

The installer had a diet on Doctor's orders, but no worry, it is not 
bulimic. As stated previously, now even 'git svn' was added. How was 
that possible? 

Pretty easy. We dragged around a lot of garbage in our installer. Some 
time ago, it was janitized, and lost a few megabytes already, but this 
time, even more effort was put into removing unneeded parts. 

Mainly inside the Perl library, files were removed. Since the Git 
installer is not meant to be any development environment -- we do not 
even ship gcc -- shipping header files and linkable libraries does not 
make sense. 

Neither is documentation for Perl needed, since nobody is supposed to 
develop the Perl scripts of Git without the development environment: 
that is what 'msysGit' is for. 

So away went the documentation! 

A few files have been removed from Tcl, vim, some unneeded Perl 
modules, and cvs, too, so we actually ended up with an 8.0 megabyte 
installer _with_ 'git svn', whereas the previous installer weighed in 
with 8.8 megabyte. 


core.autocrlf = true
====================

We finally addressed issue 21. For Windows projects, it seems to be 
the safest bet to just set core.autocrlf = true. We did that in the 
/etc/gitconfig we ship with msysGit. 

There is a subtle problem here, and we will see how to solve it: Git's 
source code itself is not supposed to be checked out with 
core.autocrlf = true. 

For new cloners, this should be easy to address (even if it has not 
been done yet): Git is checked out by /etc/profile, and we can set the 
config variable there, too. 

However, existing users who pull (and do not read the msysGit mailing 
list regularly enough to have heard about the problem) will have to 
update their setup manually. 


Update to a new ssh, problems with pulling msysGit
==================================================

There have been reports about hanging ssh processes, and for a long 
time, we had no idea how to solve it. 

Until it was reported that an update to a newer MSys helps. So we 
updated some of MSys' libraries, and ssh.exe. 

Little did we know what this would involve: one peculiarity of the 
Windows platform that has never been addressed properly by Git is that 
you cannot overwrite files that are in use. The symptoms in Git are 
that you check out, or merge, new revisions, but the files-in-use are 
not updated, and marked as dirty afterwards. 

... such as the MSys libraries, when you are using the bash. While 
pulling msysGit, for example. 

Now, a workaround is to actually install Git from our installer, then 
cd to the msysGit root, and perform the pull. That is a bit involved, 
though. 

A few ideas arose, such as writing a script, or using git-gui. But a 
script does not seem feasible, as it would not be able to close the 
bash, perform the pull, and then start the bash again. 

Also, "git merge" is still a shell script, so even git-gui (which runs 
via Tcl/Tk, and thusly does not use the MSys libraries) cannot perform 
the merge -- except when you call the git-gui from the Git installer. 

We'll see if we can find an elegant way to tackle that problem. 


Entering Babel: "rebase"
========================

What is a "rebase"? For Git users, it means replaying commits on top 
of a new branch point. 

Not so in Windows Speak: Windows' .dll files have fixed address ranges 
assigned to them, and when they overlap, problems occur. The tool 
"rebase" is meant to help there, by assigining non-overlapping ranges 
to existing .dll files. 

Peter Harris -- about whose work you will likely read more in the next 
Heralds -- was so kind to diagnose and fix that problem, by running 
"rebase" himself. 

Unfortunately, this tool is a closed source tool. But happily, Peter 
could point me to an Open Source implementation of it, and I succeeded 
in compiling it. 

As a consequence, we have now a script to fetch, compile and install 
that Open Source "rebase" tool in our "full" branch, for the joy and 
enlightenement of interested developers. 


git-cheetah is now a submodule
==============================

We readded the necessary COM infrastructure, and added git-cheetah 
(the hopefully-soon lookalike of TortoiseCVS for Git) as a submodule 
in /src/git-cheetah. 

It is not checked out by default, so you will have to update the 
submodule as usual: 

$ cd / 

$ git submodule init src/git-cheetah 

$ git submodule update src/git-cheetah 

$ cd src/git-cheetah 

$ make 

Speaking of git-cheetah: mailing list member Kirill is working pretty 
hard to get a context sensitive menu in place, and on separating the 
platform dependent parts out into their own source files. 

So my dream about a git-cheetah for Dolphin, Konqueror and Finder has 
actually a chance to become reality soon! 
