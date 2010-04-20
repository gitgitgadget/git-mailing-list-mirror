From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Tue, 20 Apr 2010 17:47:21 +0530
Message-ID: <u2ke72faaa81004200517p6386438dt16fb0051584d5e18@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004191900.12529.jnareb@gmail.com>
	 <u2ze72faaa81004191055t13ad6f2hbdcc319260cbabcf@mail.gmail.com>
	 <201004200114.07506.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 14:17:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4COS-0001ch-Sh
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 14:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab0DTMRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 08:17:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38286 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab0DTMRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 08:17:23 -0400
Received: by gwj19 with SMTP id 19so783888gwj.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BAW1dBbPDy4xoUOuZ7vH7a4uGYIVcNC2xUXALYQEYDM=;
        b=VX69cS2dGUofjHrdVC28+aCb180jVIL0LK+NP8aNVuB0D4dRgmfYFus9YWIgDbK4tL
         p1Oqh7XDLBpBQZXqC+gObtZR5ygCbw0UAqW/p2e2CIv2i+LE89ZmmGiAiqT35ZbwWm5W
         5z0AGOqaHBBS8B3nP/tFRIM2LxlDQ7a5CdVcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tm71DEw0qw9n23pUkgxDsNXz7oc1xnXIwb43jy+5C7DASa1hDoe67ppebu+qYZC5FG
         FaXonMngz/Q0KzepfMgtLL6aNS++XZXlSNmd3nun+M3UbPqehR8FsmrAOsCqeMDoyYhf
         jwpRt18H7x0jSQHtoEIA1YiJIDi1xFGa6Ao1A=
Received: by 10.90.118.4 with HTTP; Tue, 20 Apr 2010 05:17:21 -0700 (PDT)
In-Reply-To: <201004200114.07506.jnareb@gmail.com>
Received: by 10.91.37.1 with SMTP id p1mr3920134agj.47.1271765841544; Tue, 20 
	Apr 2010 05:17:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145369>

On Tue, Apr 20, 2010 at 4:44 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Mon, 19 April 2010, Pavan Kumar Sunkara wrote:
>> 2010/4/19 Jakub Narebski <jnareb@gmail.com>:
>>> On Mon, 19 Apr 2010, Pavan Kumar Sunkara wrote:
>>>> On Mon, Apr 19, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com>=
 wrote:
>
>>>
>>> I can agree that you would be able to learn Perl in a week. =A0I do=
 not
>>> think however that you can become proficient in Perl (and neither i=
n any
>>> other non-trivial programming language) in such short time. =A0The =
question
>>> remains if you can be proficient enough for the task in question...
>>
>> I can learn perl in 3 hours. Becoming proficient in perl is just
>> knowing about all the majorly used inbuilt functions and libraries.
>> Coming to the concepts of programming, I already know a lot about it
>> along with data structures and algortihms. So you need not doubt me =
on
>> this.
>
> You can (probably) learn Perl *syntax* in 3 hours. =A0You perhaps can
> learn to start to write clean, idiomatic Perl within a week, provided
> that you find good books (like "Higher-Order Perl", which can be foun=
d
> at http://hop.perl.plover.com/book/, or other Perl books from O'Reill=
y).
> Be proficient in Perl in that short time? =A0I don't think so.
>
> I guess that you can learn enough Perl for this project, but I'd real=
ly
> prefer for you to be proficient in Perl already...

It's your choice. All I can say is learning perl won't be a
obstruction to do this project.

>>>
>>> Yes, I found it in later parts of proposal, but don't you think tha=
t
>>> this goal of this project should be stated upfront, so that one can
>>> know what this project is to be about from project description itse=
lf?
>>
>> I thought it should be described later in the "Describe your project
>> in more detail" section. =A0So, I didn't go into details here.
>
> Nevetheless it is a place to describe *specific* goal of project here=
,
> in one to two sentences. =A0No marketing buzzwords here :-PPP

:-)

>>>
>>> I guess (please correct me if I am wrong) that lib/ would contain m=
odules
>>> *required* by gitweb, and modules/ would contain *optional* modules
>>> needed for extra functionality (for extra features).
>>
>> You are half correct.
>> lib/ contains modules *required* by gitweb
>> modules/ contains actions *performed* in gitweb like commitlog,
>> snapshot etc.. (write actions too)
>>
>> Maybe I will rename it to actions/ to not to be confused.
>
> I don't understand why actions are not to be in lib/, like e.g. SVN::=
Web
> (http://p3rl.org/SVN::Web) has SVN::Web::Blame module for 'blame' act=
ion?
> Although I am not sure if SVN::Web is a good example of coding practi=
ces
> and code organization.

I did so to make them clearly distinct and easily to be maintain and
modify later.

>>>
>>> If gitweb is configured to scan for repositories, adding existing g=
it
>>> repository to gitweb doesn't make sense. =A0If gitweb is configured=
 to
>>> use static file with list of repositories, of course it would make
>>> sense... but then the question is how would one specify location of
>>> a new repository to add.
>>
>> How about like this ?
>> We will have a static file with list of projects. All the repositori=
es
>> in scan path will be added to this list. Then we will also have an
>> option to add an existing repository which can be done when the user
>> specifies a relative or full path to the repository.
>
> O.K. that is a good idea: make gitweb scan for repositories, and pres=
ent
> user with the list of them to add to static list of visible projects
> (repositories).

ok.

>>>
>>> Well, unless there would be time for it after you finish all other =
work,
>>> but it is a bit unlikely.
>>
>> I don't think so. I would like to constantly contribute to gitweb.
>
> I'm sorry, we seem to have a bit of misunderstanding here. =A0What I =
meant
> that this should be in the "optional" part of GSoC project, so it wou=
ld
> be worked on during GSoC only after everything else is done. =A0Becau=
se the
> scope of this project is quite wide, I though it unlikely to have tim=
e
> left at the end of GSoC after finishing all other more important feat=
ures.
>
> I did not mean to say that you would be unlikely to contribute after =
GSoC
> finishes.

ok. I can include it is an option part of GSoC.

Thanks
-pavan
