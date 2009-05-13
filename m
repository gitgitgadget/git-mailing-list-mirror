From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 02:29:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed May 13 02:29:57 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M42M7-0002As-Tm
	for gcvm-msysgit@m.gmane.org; Wed, 13 May 2009 02:29:56 +0200
Received: by mail-qy0-f143.google.com with SMTP id 7so566042qyk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 12 May 2009 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to
         :subject:message-id:user-agent:mime-version:content-type
         :x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=V39buH1JdDPZgJLJUQE/I67BEF14zFE6tJp8236RTNs=;
        b=MNhWSI4sQxHmaYgdKVzaOijIBhvhJL6b/Lyn+iM8ML+6fG5PD+QTDJcHNeArhwpsG8
         x3ETEt5DimzA5b481XHRI3mg+TK0ZpWdrMun7DeitiV0SWC7G2lqXMgzgAEhCtrHF3WR
         gL+rDPXWKW+Pe4TAJaVdLZ7FbhDmKIvEcyjME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:subject
         :message-id:user-agent:mime-version:content-type:x-y-gmx-trusted
         :x-fuhafi:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=tcpxoVAKk5mPACtty14TASNIwddjKeCR81Cd4a855sFP9q+Gjf5la5B/E0fRPLYTUi
         yK2NjJFQRrdV1/zAJ5csRYzH16E7pBOVtIhbLzjA7CStJFxh9zE5HTijZ1nP5IvJwgv3
         qX4+W2hYSj5vOMVM6ZrrHRMwKQyhhS115edU8=
Received: by 10.224.67.74 with SMTP id q10mr57963qai.7.1242174586056;
        Tue, 12 May 2009 17:29:46 -0700 (PDT)
Received: by 10.230.2.2 with SMTP id 2gr5207vbh.0;
	Tue, 12 May 2009 17:29:46 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.31.229 with SMTP id z37mr8510bkc.27.1242174585192; Tue, 12 May 2009 17:29:45 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 13si34587bwz.7.2009.05.12.17.29.45; Tue, 12 May 2009 17:29:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 13 May 2009 00:29:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp058) with SMTP; 13 May 2009 02:29:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/E+XhVt8DEZftcTYqzeGnqIony0iuWOe6iV1ZuYp m3CHjDYdZnVOV/
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118977>


Good morning git land!

A clear Tuesday night, just after midnight, is as good an occasion as 
any to offer to you the 9th production of the msysGit Herald, the 
quite irregular news letter to keep you informed about msysGit, the 
effort to bring one of the most powerful Source Code Management 
systems to the Operating System known as Windows. 

These are the covered topics:

	What happened since the last Herald (1 year, 2 months and 11 days ago)?

	Interview with Pat Thoyts

	TortoiseGit vs GitCheetah

	Being not nice about netiquette

	New contributors

	The issue with the issue tracker

	Supporting send-email: mstmp

	The MSys project

	A GitTogether in Berlin "Alles wird Git!"



I'm back. 


What happened since the last Herald (1 year, 2 months and 11 days ago)?
=======================================================================

Git 1.5.5. 

Git 1.5.6. 

Git 1.5.6.1. 

Git 1.6.0.2 (the new libexec/ layout really gave us some problems). 

Git 1.6.0.3. 

Git 1.6.1. 

Git 1.6.2. 

Git 1.6.2.2. 

Git 1.6.3. 

(The last three were done by me, serving as interim maintainer when 
Steffen Prohaska was on some well-deserved vacation.) 

We started recently to ship Portable Git packages, i.e. archives that 
only need to be unpacked (as opposed to be installed). 

In the meantime, we fixed quite some bugs. Just to give you an idea, 
the newest bug report is msysGit issue 256 (already fixed), while the 
number of open issues -- some of them enhancement requests -- is 17. 
Slightly more than a sixteenth. Not bad, I would say. 

During the same time, we upgraded GCC to version 4.3.3, and then to 
4.4.0. 

Tcl/Tk was updated to version 8.5.5. 

We also upgraded vi to version 7.2 (thanks Christian Michon). 

GNU make was upgraded to version 3.81. 

Git filter-branch was included back into the installer, as it seems to 
work now. 

Marius Storm-Olsen contributed patches to speed up malloc() and 
readdir(). This might sound uninteresting, but the test suite (run 
with -j5, i.e. 5 parallel threads) runs in 18 minutes now, opposed to 
45 minutes. A reduction by 60%. Good stuff. 

Lots of patches sent upstream. I mean _lots_. Really _lots_. Thanks go 
to Hannes Sixt and Steffen! 

In particular, Hannes worked very hard on getting the test suite 
up-to-par. We currently have almost no deviations there from upstream 
git.git. 

The patches accepted into git.git succeeded in reducing the deviations 
from git.git to only a handful of patches, which were compiled by 
Steffen into the 'work/not-v1.6.3' branch of 4msysgit, subject to 
being thrown upstream in the near future. 

The program 'git-svn' was removed in time for release 1.6.0.2 due to 
lack of maintainership. We were talked into including it again into 
1.6.2 after Alexander Gavrilov contributed some patches to fix the 
most obvious issues. To this date, there is no maintainer of git-svn 
on Windows, and as a consequence we still have to stick with (slow) 
MSys Perl, and some things just do not work on Windows. 

There has been work to choose something different than the much-hated 
autoCRLF=true option during install: there are options for 
autoCRLF=false and autoCRLF=input together with explanations, with the 
latest installers. 

The "netinstall" and "fullinstall" packages should work again 
(fullinstall is stuck at 1.6.1 for the moment, basically because I am 
too lazy, and do not want to waste much of our Google Code quota for a 
new fullinstall package). 

We now have a "kill" tool, thanks to Alexander Gavrilov. 

We make full use of pthreads on Windows now (thanks to Dhruva 
Krishnamurthy and Peter Harris). 

There is subtantially better support for running Git from cmd.exe. 

We patched msys-1.0.dll in several ways to accomodate Git better. An 
important step was to have a script that allows us to rebuild 
msys-1.0.dll relatively easily from within msysGit. The most important 
work was done by Steffen. 

It was pretty awkward to switch msysGit branches on Windows, as files 
in-use (such as msys-1.0.dll) cannot be overwritten. We have added a 
hook to msysGit which installs a script on the desktop when a file in 
use needs replacing due to a branch switch. The user can then quit all 
msysGit windows, start that script and thereby fix up the files that 
need replacing, and then restart msysGit again. This is far from 
perfect, but way better than the situation before (where you were 
stuck with the dirty files forever). 


Interview with Pat Thoyts
=========================

I noticed Pat for the first time on the msysGit tracker. He answered a 
Tcl/Tk related question, and the answer actually struck me as pretty 
competent, something I did not quite expect from a name I never heard 
before. 

It turned out that Pat is a maintainer of Tcl/Tk, very proficient in 
Windows matters, and he was more than just helpful at a number of 
occasions. 

Naturally, I like to honor people who add to msysGit's value in a 
substantial way, and asked him the 10 questions you all know by now. 
So, without further delay, here is what he says: 

2009/5/12 Johannes Schindelin <Johannes.Schindelin@gmx.de>: 

> 1) How did you get involved with Git? 

I do a fair amount of work as a maintainer for Tcl and Tk, 
particularly for Windows issues for these projects. Some time ago I 
started to look at DVCS to see how they might help or change the way I 
work. Tcl and Tk use CVS at the moment and I typically have a number 
of patches sitting around on my working tree. When I change track I 
update the patch, apply it in reverse and apply some different patch. 
Clearly this can loose development history and can result in a 
proliferation of versioned patches. 

Initially I looked into Mercurial as it had a reasonable following and 
apparently good Windows support. Mercurial encourages you to clone the 
repository for each branch you want to work on which leads to a lot of 
directories and eats quite a bit of space after a bit. I found I 
started to use the quilt equivalenet - mercurial queues - but that has 
trouble with line endings on windows. 

I then had a look at git. Git makes a much smaller repository than 
Mercurial (for tcl .git is around 32MB while .hg is 98MB) but also 
branches are contained in the repository so there is only one place to 
look for everything. I have also had no problem with line-endings so 
far. Now all my patches have become branches in my local git 
repository leaving the system much tidier. 

> 2) What were the reasons that you started working on Git? 

As a software developer, if I encounter a problem in a tool I am using 
I generally will attempt to fix it. Most open source projects have far 
more bugs than developers so there is not usually much point just 
raising a complaint. It needs to be examined in more depth before 
anyone else can hope to fix it. In my case there were a few issues in 
gitk that I can quite easily deal with given my experience with Tk. 
The hardest thing was to work out what to do with the patches until I 
discovered they should all be posted to the git mailing list. 

> 3) What do you like most in Git? 

The speed. And gitk. And git bisect. 

> 4) What do you hate most in Git? 

The learning curve is steep. Even for someone who has a lot of 
experience with unix and the mindset behind such tools. 

> 5) What was the most surprising moment when working with Git? 

The speed at which you can check out the earliest versions of the 
code. For the Tk repository I can examine any commit right down to 
1998 almost instantly, checkout the code for that version in next to 
no time. I've done a bisect to isolate a fault in less time than it 
has taken to checkout a given revision from sourceforge cvs. 

> 6) What was the most frustrating moment when working with Git? 

Discovering that cvsimport doesnt handle vendor branches properly. At 
the moment this is a major problem as I'm mirroring ongoing cvs 
development. 

> 7) In what environment do you work? 

Sat in an Ikea chair in the living room with a laptop ignoring the TV. 

Oh - maybe you meant something else - Windows x64 mostly. And 
sometimes Linux. Occasionally solaris on a sparc server I have in a 
cupboard. 

> 8) What other hobbies do you have? 

Thats a joke right? I used to have hobbies - then I had children. 

> 9) What is your favourite movie? 

Usually the last one I saw. WallE for now then. 

> 10) What are your visions for Git? (I.e. where do you want it to 
go?) 

I don't really have any plans for git. It's looking good at the 
moment. Getting a good explorer plugin will make it more acceptable to 
a lot of windows developers so that is something to look into. I might 
be able to persuade my co-workers to make the switch if we had a 
robust plugin. gitk and gitweb already help with code review tasks. I 
might try and investigate ipv6 for msysgit at some point as I operate 
a ipv6 network locally using the SiXXS tunnel broker. Its not that 
urgent though. As ssh will run over ipv6 and my local git remotes will 
use ssh that means they are already using ipv6. 

I am very happy to be able to use a native Windows git. I would not 
have looked at git at all if it had only had a cygwin port. 

Pat Thoyts 


TortoiseGit vs GitCheetah
=========================

A long time ago, I started GitCheetah in the hope that it would prove 
two things: a "Tortoise"-style Explorer extension does not need to be 
large, and does not need to be limited to Windows. Oh, and it does not 
have to rely on a closed-source compiler. 

I was quite enthusiastic about the project, especially when some GSoC 
student offered to work on it last year. Unfortunately, he was grabbed 
by a different organization, but that's the way it goes. 

To my further chagrin, Brian Hetro, who offered to take GitCheetah to 
new glory, stalled working on it pretty quickly. 

At some state, Kirill (whose surname I do not know, but who lives 
pretty close to me now, it seems) started working on Git Cheetah, even 
if he seemed not to be willing to take the project into his own hands. 

In the meantime, much to my now-enhanced sadness, somebody took 
TortoiseSVN and adapted it to Git. It makes me sad for several 
reasons: 

- TortoiseSVN is big, too big for my liking, and so is TortoiseGit; I 
sincerely believe that it should be much smaller for the things it 
does, 

- TortoiseGit seems to be compileable only with closed-source tools, 
and the author even seems happy about it, 

- TortoiseGit is as unportable as TortoiseSVN (i.e. I cannot use it 
myself, Linux being my main platform), 

- TortoiseGit takes resources -- including people -- that would be 
better spent on GitCheetah, and 

- in spite of making me very sad, TortoiseGit benefits greatly from my 
(and others') work on msysGit. 

In the meantime, I even had to notice that TortoiseHg implemented my 
dream of a cross-platform Tortoise. Why can't we have some people who 
are dedicated to this project rather than being happy to just wait for 
(and complain about the lack of) a capable and cross-platform 
FileBrowser extension? 

Happily, Bosko Ivanisevic worked a bit on GitCheetah, adding cascaded 
menus and more, and maybe this project can build up enough momentum to 
be interesting even for Linux/MacOSX developers, which would add an 
additional benefit to the project. 

So maybe there is some hope left. 


Being not nice about netiquette
===============================

One of the biggest reasons which made me lose fun with msysGit back 
when I gave up on it was that many Windows users are just rude. 

They probably do not mean to, and do not even realize that they are, 
but the whole idea of abusing the people who do all the work is not 
only incredibly wrong, it is also incredibly stupid: It should go 
without saying that if you want other people to work for you, you 
should provide them with a reason to do so. A good reason. 

In Open Source, by tradiditon there are almost no financial benefits 
which could try to convince people to work for other people, as there 
is a usually active user community offering to help for free. No 
surprise that when asked "would you pay for Git support", the previous 
Git surveys came up pretty blank. 

So there is no financial benefit. 

The big problem is that Windows is often much harder to work on than 
other platforms, as not only documentation is worse, and not only are 
you not able to look at the source where the documentation is lacking: 
many things are just not the same in different installations, much 
more so than when comparing, say, different Linux installations. 

Just one example: on Linux, you can rely on hard links being 
serialized properly. That is, if you call "link(source, target)" and 
right after that "unlink(source)" (to delete the file <source>), it 
works if <target> does not exist yet. This is the common paradigm on 
Unix to guarantee that <target> is not overwritten if it exists. Not 
so on Windows. Sometimes it works, but at other occasions, the 
procedure will succeed but <target> ends up corrupted (typically all 
zero, but correct size). 

Needless to say that issues like this one are hard to debug, and cost 
a lot of time (I call this the "Microsoft time tax", the time you have 
to spend on coping with Windows that would be better spent on other 
issues). 

So there is a tremendous amount of time to be spent, with no real 
benefit for most people who know how to fix things (as they seem to be 
mostly spread over other Operating Systems than Windows). 

To repeat: the effect I saw was that many people got abusive, and many 
a user actually expected msysGit to work out-of-the-box, and got 
really angry when their issues were not taken care of -- for free! 

As I _had_ to work on msysGit again, and was unwilling to let my 
efforts go to waste (after all, the initial "port" to MSys was done by 
me, and when I ran out of steam, Hannes took over), I tried a 
different tack, which works out pretty fine so far. 

The trick seems to be to actually use the powers I have as 
administrator of the Google Code page and the Google Group (having 
started it all, I am naturally given quite some permissions): I will 
not allow anybody to annoy me anymore. 

I will delete comments on the Wiki that do not contribute value, I 
will delete comments on the Wiki if they are just not comments but 
insults (and I will even delete commants that are useful after 
addressing their concerns), I will remove comments on the issue 
tracker that I do not like because they are abusive or just rantings, 
and I _will_ delete all mails in the Google Group that I find 
offensive. 

This might sound selfish, but look at it this way: some people will 
vent, oblivious of the effects they have on the project and on the 
people doing all the hard work. They would cast a damning light on the 
project, just by their bad choice of words. And they would make people 
lose fun in the project, just like they succeed with me, over one year 
ago. 

As some people (including me) put in a lot of effort, I feel _obliged_ 
to delete offending comments and emails. I even feel good about 
removing them. If you do not like that policy, first earn my respect, 
and then complain privately about it. 

Oh, and a little hint: you do not earn my respect by complaining. 

If you need a hint how to earn my respect, do read on: 


New contributors
================

For a very long time, msysGit was pushed forward by the gang formed of 
Hannes, Steffen, Sebastian Schuberth and myself. At some stage I got 
so frustrated that I stopped working on msysGit altogether. The reason 
is simple: it was no more fun. Way too many people asked for fixes or 
enhancements, and _none_ of them offered contributions of their own. 
As I am not a Windows person (being a happy Linux user since 1994), 
the work on msysGit was not rewarding enough for me to continue. So I 
stopped. 

But in the meantime, things have changed. 

We got contributions by Eric Raible, Petr Kodl, Pat Thoyts, Jeff King, 
Janos Laube, Marius Storm-Olsen, Peter Harris, Markus Heidelberg, 
Edward Z. Yang, Steve Haslam, Dhruva Krishnamurthy, Clifford Caoile, 
Heiko Voigt, Erik Faye-Lund, Kurt Pfeifle, Kirill (?) and Alexander 
Gavrilov. 

(And I should mention the continued contributions of Hannes Sixt, 
Steffen Prohaska and Sebastian Schuberth.) 

A few of them became pretty regular contributors -- we can always do 
with more, but the situation has improved noticably. 

I also want to thank all those who did not abuse the issue tracker to 
vent, or to report something and then go away, never to be seen again, 
or as a kind of a diary. 

There were some _very_ responsive people, one of them even offering 
VNC access so that I could debug issues on the machine where they 
happened. 

My heartfelt thanks go to all people who were helping msysGit! 


The issue with the issue tracker
================================

Some time ago, I tried to disable the issue tracker, because issues 
started to accumulate, but nobody took care of them. 

I was talked into reenabling it, putting the msysGit mailing list as 
"default assignee". 

Unfortunately, my worst fears happened to become true. Still nobody 
took care of the issues. Still it seemed that I was the only person 
feeling enough of an itch to take care of the issues. 

Even worse, some people abuse the issue tracker, either by adding 
issues that were already addressed (which can be a simple mistake, and 
therefore excusable), or by abusing it as a sort of a diary (which is 
not so excusable), or as a place to put rantings (which is not 
excusable, as it wastes the time of people trying to help), or even to 
put insulting comments (which totally inexcusable, there is nothing at 
all that could justify this behavior). 

I have to admit that I am totally unamazed by the "sheer" number of 
people adding helpful comments to the issue tracker. I mean, I could 
understand if the _ratio_ of people helping vs people being helped was 
unfavorable on Windows, since with a pretty large user base it is much 
easier to indulge in the convenient laziness of not helping fellow 
human beings with their problems. 

But seeing that the absolute number of people helping each other on 
the Git mailing list is so much unbelivably larger than the number of 
people helping on the msysGit tracker is just sad. Really sad. 


Supporting send-email: mstmp
============================

There is an issue (number 27: git-send-mail not working properly) 
which makes me particularly sad. Torgil promised almost two years ago 
to take care of it, but nothing happened. 

I am very, very disappointed at that. 

Now at least, it seems that Kirill took things in hand, but there are 
problems with the autoconf tools, and I just lack the time to help 
out, always hoping that other people would find their calling in 
helping with the troubles. 

After my addition of /share/msysGit/install-mingw-tar.sh things should 
become easier, but it seems that we need more enthusiastic people 
still. 


The MSys project
================

There is an msysGit issue saying that we should contribute our changes 
back to the MSys project. If it weren't for the fact that the reporter 
actually did some work on msysGit, I would say that this falls into 
the "abusive" category mentioned previously. 

However, the issue reporter lost interest after starting work on it, 
so things are stalled right now. 

On the other hand, we have evidence that the MSys project is 
interested in the msysGit effort, at least in the person of Cesar 
Strauss, an important MSys contributor, who added helpful comments to 
a few issues on our issue tracker. 

With our recent work on msys-1.0.dll, it seems that we can really 
contribute back some useful changes, too (even if I would have 
preferred to have a lieutenant to take care of the MSys-msysGit 
liaison). 


A GitTogether in Berlin "Alles wird Git!"
=========================================

This is not strictly an msysGit issue, but somehow it actually is: a 
guy called "A Large Angry SCM" on the Git mailing list offered some 
free beer in Berlin on October 3rd 2009 (actually, he offered the 
first $100 in beer, we'll see how strong the dollar is then ;-). 

The part that makes this at least partially an msysGit thing is that 
Steffen, the msysGit maintainer, graciously offered hosting space. 
Thank you very much, Steffen, and of course Zuse-Institute Berlin! 

In case you wondered, the title "Alles wird Git!" means something like 
"Everything will be _fine_!", where the "fine" is misspelt to read 
"Git". 

This GitTogether -- as all GitTogethers before -- is what you make of 
it. If you have contact to a company wanting to sponsor lunch, drinks 
or accomodations, please contact me. If you want to hack on Git, bring 
your laptop. If you want to give a presentation, bring everything you 
need for it. If you want to have fun, just go there. 

In any case, if you want to participate, be sure to add your name to 
the Git Wiki: http://git.or.cz/gitwiki/GitTogether 

October 3rd is a special date: it is the German national holiday for 
celebrating the reunification of the formerly-two Germanies! Actually, 
a better day would have been June 17th, but some politicians are just 
full of themselves and want to change dates, so there you are. 

The positive side is that it happens to be the date a certain big and 
not-so-peaceful SCM is offering free beer. Oh, and I could imagine 
that the party will be _big_ in the evening, as it is the 20th 
anniversary of the reunification. In the party-town of Germany, things 
will probably be anything except boring. 
