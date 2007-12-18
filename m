From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: The 6th edition of the msysGit Herald
Date: Tue, 18 Dec 2007 01:42:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712180141481.9446@racer.site>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Dec 18 02:43:25 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4RUS-0001eh-5K
	for gcvm-msysgit@m.gmane.org; Tue, 18 Dec 2007 02:43:24 +0100
Received: by wr-out-0708.google.com with SMTP id 56so646491wra.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:subject:message-id:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=B0Vt8+Wnu0NfA6BCSBt21c2aKwf2biMX0hKZDhoty1E=;
        b=1e7ubJv1+mT40cQ7eAcJ9SLTSO6Gfwn2wyCq5veCoWjh3t3j/adZGUkNECcRJsEx6mZZnilot2bpiCLDobM5lHCB8yqTP0esWG/sqRl6DjmGA2Z1CrEPV9mYcmB9GRA8t4aLwyY9iVolJajlNV8TaGi3Ftw/DQAMsZQ+mufvnuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:subject:message-id:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=ls9jTgXm3kvNxxdHgqysuNOhEFzDg+uS00g6oQ5e1CASfPSjklK2cvgIc4l3RYa1hLMO7FTNDI6BnmWC17LFVI5rE3klbgtHCJg4MD9jpNXIypYI/iePaLFCR30ZwGipslgW/PG4YxchGrwgens/PVK/pb0owWngdn3x/sUW/f0=
Received: by 10.100.138.4 with SMTP id l4mr207222and.2.1197942181315;
        Mon, 17 Dec 2007 17:43:01 -0800 (PST)
Received: by 10.107.100.4 with SMTP id c4gr1266prm;
	Mon, 17 Dec 2007 17:43:01 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.157.1 with SMTP id f1mr1940363wae.16.1197942180308; Mon, 17 Dec 2007 17:43:00 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id h49si260839nzf.5.2007.12.17.17.42.59; Mon, 17 Dec 2007 17:43:00 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 18 Dec 2007 01:42:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp019) with SMTP; 18 Dec 2007 02:42:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18s00M3HngswxAmL/TPATTTMDNkcbDrfZjcyIwODy QD/p9oPpBIaWnk
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
X-Y-GMX-Trusted: 0
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68684>


Good morning git land!

This silent midnight is as good an occasion as any to offer to you the 
6th edition of the msysGit Herald, the not-quite-biweekly news letter 
to keep you informed about msysGit, the effort to bring one of the 
most powerful Source Code Management systems to the poor souls stuck 
with Windows. 

These are the covered topics:

	Git Gui's fetch problems resolved

	vim colours improved

	Getting more hits via git.or.cz than Google

	Update to 1.5.4-rc0

	New naming scheme: Git and msysGit

	We busted the quota of Google Code

	msysGit-netinstall: HTTP proxy and directories containing spaces

	Next things



So this not-quite bi-weekly newsletter took a little bit longer this 
time. But only for the better! Seems like the installer really 
stabilises, as I hoped, and we really concentrated on some serious git 
work. 

Oh, and we got mentioned on kernel trap. For those who got the 
impression from there that Git on Windows is not quite there yet: not 
only is msysGit one of its own heaviest users, it is very much at the 
technical front of Git: we use submodules, and we promote Git Gui 
heavily. So there you have it: Git on Windows is already here. 

Although we call it beta. Just to cover our buttocks. 


Git Gui's fetch problems resolved
=================================

We updated git to a version where git-fetch is a builtin, in the hope 
that the issues with fetching were resolved (for those who do not 
follow the Herald: when fetching within Git Gui, a window would pop up 
with the remote refs, instead of redirecting this output to 
git-fetch). 

Alas, it turns out that the implementation of spawnvpe() in Windows' 
runtime library leaves a lot to be desired. Amongst other issues, it 
does not automatically attach the child process to the same console as 
the parent window, which gave us some grief. 

Hannes Sixt finally broke down and reimplemented spawnvpe() as it 
should have been (but was never fixed to). 

Since then, it is running like a charm. The only issue left is when 
you access a remote host via ssh, and have to type in a password. We 
have do not intercept that yet. There is a relatively low-hanging 
fruit waiting for somebody to harvest it. 


vim colours improved
====================

We got a bug report that the colours in vim made a user blind ;-) 

While investigating, we found out that not only did we have a useless 
/etc/vimrc (the correct location is /share/vim/vimrc), but the code to 
show nice colours for a dark background was already there, only at the 
wrong spot. 

With that fixed, our user can recover, and open his eyes again to this 
lovely world we live in. 


Getting more hits via git.or.cz than Google
===========================================

Seems that the recent linking from the Git home page really changed 
things in the statistics! While Google's search referalls dominated 
the traffic sources earlier, 30% more users find our home page via 
git.or.cz than via Google now, which might also mean that they are 
referred to the Git home page first. ;-) 

We also got some attention on November 19, when KernelTrap had a story 
on us. 


Update to 1.5.4-rc0
===================

Since the last Herald, Hannes was very busy sending patches to Junio 
Hamano, the maintainer of (non-MinGW) Git, in order to bring mingw.git 
closer to git.git. In the midst of all those wonderful efforts, a 
feature freeze was declared on git.git, to stabilise for 1.5.4. Such 
is life ;-) 

Nevertheless, a few patches made it in, and Hannes made quite a few 
more cleanups, such as a rework of the environment variable handling 
(when you setenv() on Windows, references you got earlier via getenv() 
are now stale), or avoiding dup()s which confused Windows -- in the 
commit messages, this issue is known as the "dup dance". 

At the same time, Steffen Prohaska worked on bringing 4msysgit.git 
closer to mingw.git ;-) 

The fallout of these endeavours is that we are not only much closer to 
mingw.git, but we are in fact pretty close to the current prerelease 
of Git -- 1.5.4-rc0! 

Together with the usability improvements in the installer, such as 
installing shortcuts for all users when installing as administrator, 
or the integration of the release notes into the installer, I am 
pretty happy with the state of the project. 


New naming scheme: Git and msysGit
==================================

When taking the first steps of "Git on MSys", there was only one 
pretty large zip file, containing the development environment to 
compile git, along with a checkout of mingw.git. 

Since then, we decided that we wanted installers. Three of them. 

The final goal is a Git installer, meant for the end user. 

To attract developers to that end, we also wanted to have two 
installers for the development environment: a small one, containing 
barely enough of Git and MSys to fetch and checkout the master branch 
of the development environment's repository, and the master branch of 
our fork of mingw.git (and recently, we got another submodule for the 
documentation). And a big installer, which does not clone anything, 
but is an all-in-one package of the development environment, not even 
setting up git remotes -- basically the big zip we had during the 
first day, turned into an installer. 

As I am pretty bad with British slang names, I could not think of any 
really good names, and we ended up with "WinGit" (from "to wing it") 
for the Git installer, "GitMe" for the net installer of the 
development environment, and "msysGit" for the full installer. 

That was confusing. 

Steffen pointed out that we should thrive for the crown of Git on 
Windows, leaving cygwin's Git behind, and therefore our Git installer 
should really be called "Git". 

Also, since the other two installers are in fact just two different 
ways to obtain the development environment, they should share the same 
name, "msysGit", with one being the net installer and the other the 
full installer. 

So, these are the downloads we offer: Git, msysGit-netinstall and 
msysGit-fullinstall. 

But maybe we decide to rename the latter two to Git-Dev-netinstall and 
Git-Dev-full some day... we'll see. 


We busted the quota of Google Code
==================================

A mere 5 months after starting the project page 
http://msysgit.googlecode.com/ we reached the (default) quota of 
100MB. We used up about 7-9 megabytes for each release of the Git 
installer, and the full msysGit installer weighs in with a 14 
megabytes. 

When Dmitry Kakurin suggested to get some project hosting, back in 
July, my first address was sourceforge. However, they dragged their 
feet (and our project was really moving along at a breathtaking pace, 
back then) so we ended up using Google Code's friendly hosting service 
instead. 

Already it became quite clear that we'd eventually need more quota, 
but we were being told that we would get more when we needed it. That 
point was reached on Friday, 14th of December, when Steffen was unable 
to upload the current preview due to space constraints. 

When I found the right spot to ask (in case you wonder, it was not the 
email address code-hosting-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, as suggested by the Google Code 
FAQ, but the Project Hosting discussion group at 
http://groups.google.com/group/google-code-hosting?lnk=gschg), things 
went smoothly and we now have a quota of 200MB. See you in 5 months, 
Google ;-) 


msysGit-netinstall: HTTP proxy and directories containing spaces
================================================================

A long standing bug in msysGit-netinstall (then known as GitMe) was 
fixed quite some time ago, but I never got around to wrap up new 
installers: If you installed msysGit into a directory containing 
spaces, it would not be able to finish the installation. 

Another bug(let) was that we did not have any method to specify an 
HTTP proxy in the net installer. 

This was the reason, probably, that the net installer was 
substantially less popular (2817 downloads) than the full installer 
(4306 downloads), despite the former being featured on the main page. 

With both bugs fixed in both msysGit installers -- also updated to the 
same state as the Git installer -- we lay the old installers, 
GitMe-0.4.2 and msysGit-0.6, to rest. Requiescant in pace. 


Next things
===========

The commands git-svn and git-cvsimport had to take a backseat while 
more visible _Git_ issues were being taken care of. But postponed is 
not abandoned, so they will both see some attention again soon. 

My pet project, git-cheetah, should also get integrated as a submodule 
of msysgit.git. It is a lightweight Explorer extension a la 
TortoiseCVS, and given enough people working on it, it should be able 
to kick rear ends pretty quickly. 

Rxvt. Ah, so long ago, I abandoned hope that this would be fixed 
eventually (for one, git-log is not able to spawn a pager, and thus 
the history just whizzes by). So we use cmd instead. 

It is no secret that cmd (or the console window it opens) has pretty 
annoying restrictions (such as no proper multi-line selections, no 
_real_ resizing support, and you have to use the mouse to scroll 
back). But with the work we did to recompile Perl for MSys, it should 
become easier to tackle Rxvt. Or maybe we'll just include Xming 
instead, a very small and lean rootless X11 server for MinGW. 
