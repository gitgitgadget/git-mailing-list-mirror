From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 12:16:31 +0530
Message-ID: <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004180246.18263.jnareb@gmail.com>
	 <20100418005917.GO10939@machine.or.cz>
	 <201004180324.54722.jnareb@gmail.com>
	 <20100418021223.GP10939@machine.or.cz>
	 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	 <20100418223120.GB3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 19 08:46:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3kkh-0007B4-A3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 08:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab0DSGqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 02:46:33 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:35250 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0DSGqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 02:46:32 -0400
Received: by yxe29 with SMTP id 29so2357907yxe.4
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IFKEkW9YSzsyVtcUMKnk1+ZcTOaoJ8EflZMAiFS8GcU=;
        b=V1zG263RCP/fyIv16dKne4E0/QdXLf7frHSY662LhQM7Zwz6bO/2YuV8FReyW7N4g3
         HY7Av/KM/rEyV50IahntmRzBEBCxpwwPRaKO20w3n42xIeD/Bt8fLmBivvuFavcBGrJv
         xuwdfj++FDYxGcxU4Cvhs5Ee//MOb83kvvVcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RHYjLXyi+NNrZkdSe/ie2fbrbdHp/27mWcBQ1OFiAXD5YwzfP3Q00eXWU7r448mXUo
         FX5Q9lH1yVAQhVr2EixYlT4XqNG+O9D0q5JRtvArog4A+jfcCmN/C05jxKY7uJY8IYeI
         HpQfMJsLLOdAnldqdWGov/pZzzCY5s0+qIo1o=
Received: by 10.90.118.4 with HTTP; Sun, 18 Apr 2010 23:46:31 -0700 (PDT)
In-Reply-To: <20100418223120.GB3563@machine.or.cz>
Received: by 10.91.152.12 with SMTP id e12mr2725916ago.73.1271659591268; Sun, 
	18 Apr 2010 23:46:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145267>

On Mon, Apr 19, 2010 at 4:01 AM, Petr Baudis <pasky@suse.cz> wrote:
> Thanks for work on the proposal!
>
> On Sun, Apr 18, 2010 at 02:22:20PM +0530, Pavan Kumar Sunkara wrote:
>> 2.How would you measure its success or failure?
>> There are two parameters which would majorly determine the success o=
r
>> failure of the project.
>>
>> =A0 =A0* Splitting gitweb such that there should be no problem with =
the
>> installation of gitweb across cross servers and cross systems.
>
> I believe an important factor in the success of the project is gettin=
g
> these changes merged upstream in the main Git branch.
>
> If the rest of the project features is not merged (and it *won't* be =
for
> the lack of trying), it will still be reasonably easy to use it as a
> third-party modification. However, if the split-up itself will not be
> merged, that will have big impact on the usefulness of the whole proj=
ect
> - so I consider this fairly crucial, please don't under-estimate this
> part, getting things merged can take as much work as doing initial
> implementation of the stuff! You should plan to submit these patches
> quite early.

Yes, I promise that I will try my best to submit patches early and try
to get them merged them into mainstream.

>> =A0 =A0* It should be possible that the new gitweb requires less tim=
e to
>> work on a git repository than any other git client.
>
> I'm sorry, I don't understand this.
>
>> 3.Describe your project in more detail.
>> I would like to split the currently 6800 long piece of code in
>> gitweb.pl perl script into small files which will result in better
>> readability, maintainability and modifiability. The file structure o=
f
>> the new gitweb is given below and I will explain the working after i=
t.
>>
>> (From now on, I would like to call the actions of gitweb as modules =
of gitweb)
>>
>> a) File Structure:
>>
>> =A0 =A0* gitweb.pl -- Main script parsing urls and calling required =
modules
>> =A0 =A0* gitweb.tpl -- The template of the web page (GUI) in which
>> modules are embedded
>> =A0 =A0* gitweb.css -- The style for the gitweb pages.
>> =A0 =A0* gitweb.js -- javascript to make gitweb more interactive
>> =A0 =A0* modules (dir) -- directory containing the write and read mo=
dules.
>> =A0 =A0* lib (dir) -- some basic files like config, error_handler,
>> templater, redirecter, htmlHelper etc..
>>
>> The current gitweb makefile makes a gitweb.cgi from the perl script
>> and requires apache or lighttpd server for it's working. I would lik=
e
>> to continue this process but the change will be in the gitweb perl
>> script. The new script includes config and other basic files, checks
>> the URL, parses it, detects the module, manage session and includes
>> the proper module. It then retreives the output of the module and
>> substitutes it with the gitweb.tpl template file string and gives ou=
t
>> a proper HTML, CSS web page. It also contains some basic library fil=
es
>> in the lib directory. The new gitweb uses session variables to track
>> some of the variables rather than including them in the url. The wri=
te
>> modules need not be working in a gitweb installation like repo.or.cz=
,
>> so we will also have an option to disable the write modules.
>
> Frankly, I'm not very excited from this. First, I recommend that you
> completely separate splitting of gitweb to smaller pieces (without an=
y
> major conceptual changes) both in the proposal and in actual
> submissions.
>
> Second, you should justify the introduction of session management and
> templating. What is the point and why is it neccessary for your proje=
ct
> goals?
>

Session management reduces the length of URL and templating reduces
the amount of HTML in the actual code.

>> b) Write modules of the client:
>>
>> =A0 1. Add Existing repositories to the gitweb -- This will list the
>> given repo into gitweb config
>> =A0 2. Create new/Clone repositories into a given path [git init | g=
it
>> clone] -- This will create new repo and list it
>> =A0 3. Add/Remove/Move files [git add | git rm | git mv]
>> =A0 4. Stage/Unstage files [git add | git reset]
>> =A0 5. Add files to ignore list when u click on 'Ignore' link
>> =A0 6. Discard changes to a file in working copy [git reset]
>> =A0 7. Commit to the repository with a log message and an optional
>> sign-off [git commit]
>> =A0 8. Switch branches [git branch]
>> =A0 9. A simple branch merging* [git merge]
>> =A010. Creating tags [git tag]
>> =A011. Checkout code to a specific commit or branch or tag [git chec=
kout]
>> =A012. Push to a remote branch [git push]
>> =A013. Fetch/Pull from a remote branch [git fetch | git pull]
>> =A014. Garbage collection [git gc]
>
> Sounds reasonable. What am I missing is a way to edit files through t=
he
> web interface. Also, please spec in more detail the difference betwee=
n
> [8] and [11].

[8] includes creating and deleting branches along with listing and
switching where as [11] includes just switching and also allows to
switch between commits and tags.

>
>> =A015. Search for a part of code [git grep]
>
> This is already supported by gitweb. And it's not a "write" operation=
=2E
> ;-)

I wrote it here because I would like to integrate it with content
history browser functionality later.

>> c) Read modules of the client: (most of this need not be written, ju=
st
>> need to be organised)
>>
>> =A0 1. See the status of repository [git status]
>
> How will you integrate this with the existing 'tree' action?

No, there will be a seperate page for it which executes git status comm=
and.

>> =A0 3. List all the commits with pagination [git log]
>
> Why?

It's nothing but the current gitweb does.

>
>> =A0 4. With every commit we can
>> =A0 =A0 =A0 =A0 =A0* Visualise trees [git ls-tree]
>> =A0 =A0 =A0 =A0 =A0* Visualise files and diffs [git show]
>> =A0 =A0 =A0 =A0 =A0* Visualise annotations [git blame]
>> =A0 5. List all branches including remote ones [git branch]
>> =A0 6. Search commits, branches, authors etc..
>
> I.e. what we already do?

Yes

>
>> d) Usage of the client:
>> * Install on intranet - A company when installs this gitweb along wi=
th
>> some other login and account managing scripts will be able to order
>> their employees to login and ask them to work on the code with out t=
he
>> security risk of providing ssh access to the git repository host.
>
> Frankly, the net security risk of providing git-shell access is proba=
bly
> lower than using a web interface. ;-) However, I still see this makin=
g
> many corporate people happy and opening doors to less canonical Git
> usecases - it also enables "zero config" ability to contribute to Git
> projects, desirable for less technical users (artists etc.).

Yes.

>> I will try to make sure that the patches to be as small as possible
>> and easily reviewable. Also my vacation starts on May 2nd and ends o=
n
>> August 1st. So most of the project work will be done during the star=
t
>> of the GSoC project rather than in the end.
>
> Great!
>
>> [May 4th week - June 1st week]
>> Split the whole code of gitweb into framework structure and setup
>> library files along with installation and configuration.
>
> I think this might end up being rather tricky, and would appreciate y=
ou
> detailing this out a bit more, including some expected dates for init=
ial
> patch submissions.

We haven't yet decided on how to split gitweb, so I would like to give
a bit more details about this after I take the majority opinion on how
to split gitweb.

>
>> [July 2nd week]
>> Check for any possible and potential security loopholes or bugs
>
> I appreciate that you are thinking about this, though I'm less sure i=
f
> this can be efficiently done as a batch job like this.
>

I don't think so. Anyway, let's try it. :-)

> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Petr "=
Pasky" Baudis
> http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
>

Please ask me if you have any other doubts regarding this proposal.

Thanks
-pavan
