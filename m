From: "Zorba" <cr@altmore.co.uk>
Subject: Re: getting started, happy with cmd line on windows [Scanned]
Date: Tue, 30 Dec 2008 01:22:59 -0000
Message-ID: <gjbt63$v8t$4@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local> <alpine.LNX.1.00.0812281326300.19665@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 02:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHTLk-0004w6-8j
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 02:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbYL3BX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 20:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbYL3BX1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 20:23:27 -0500
Received: from main.gmane.org ([80.91.229.2]:34868 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbYL3BX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 20:23:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHTKO-0005Ts-Jx
	for git@vger.kernel.org; Tue, 30 Dec 2008 01:23:24 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 01:23:24 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 01:23:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104145>

Thanks Daniel, I'm not a tar man anyhow, so that would be one more thing to 
learn.
So I'll pass, but someone else into unix will find this useful (maybe me, a 
few mths down the track)

Believe it or not, I had budgeted half a day for getting git installed, 
learned, and all the versions safely stowed away.
That was on Xmas eve (24th Dec.)

I've been on this every day since - gawd, its becoming an Odyssey.

SCM is a support to my software development, which is a support to my 
business (a user business, not technology based) and iin a normal year (not 
like this current one) would be <10% of our effort. I can sense the beauty 
of git, but A WEEK ! to get close to making the first LIVE COMMIT.

I'm going to assert that a large number of possible users will not be 
interested, or how shall I put it better, they'l be very interested in git, 
but that's where it will stay. The blogosphere is littered with the burnt 
bodies of those who have tried to ride this dragon. Gawd its tempting to 
give up and install CVS or something, the only thing keeping me going is 
that I HATE quitting !

What is it about this stuff ? I am not unintelligent but struggling with 
this.

It seems like to do something simple you have to understand EVERYTHING -
its not like other systems with a clear set of "basic", "intermediate" and 
"advanced" commands that are fairly standalone.

everything in git seems so interleaved - its like relativity, or nuclear 
physics !
I'm sure git nirvana is coming sometiime for me,
gawd please may it be in this lifetime!
 :-)

"Daniel Barkalow" <barkalow@iabervon.org> wrote in message 
news:alpine.LNX.1.00.0812281326300.19665@iabervon.org...
> On Fri, 26 Dec 2008, Conor Rafferty wrote:
>
>> We want to use git to
>> a) archive old versions of our project that have till now had no SCM
>> applied
>
> There's actually an importer for this; if you can put all of the old
> versions into tar files in the same format and list them in order, you can
> use "import-tars.perl", which is in contrib/fast-import in the git source
> tree. Of course, using that won't teach you anything about the tools, but
> it might be the best way to get the real import done with the least chance
> of mistakes.
>
> -Daniel
> *This .sig left intentionally blank* 
