Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374221FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 19:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbcHWTRA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 15:17:00 -0400
Received: from mout.web.de ([212.227.15.14]:57338 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752843AbcHWTQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 15:16:59 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LiCbT-1aqa1110Rn-00nR44; Tue, 23 Aug 2016 21:07:40
 +0200
Subject: Re: git-svn bridge and line endings
To:     Lucian Smith <lucianoelsmitho@gmail.com>,
        Julian Phillips <julian@quantumfyre.co.uk>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
 <20160823030721.GA32181@starla>
 <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
 <20160823055418.GA5990@whir>
 <CAHLmBr3Yn1tVhijmgRwd8hyxgasdc2VtfNi6pYP5FbEHjjb3Vw@mail.gmail.com>
 <501dc45544c5582379df21a758d3be6c@quantumfyre.co.uk>
 <CAHLmBr1Cd_JimZEsLUjG=+v4CgsXGGzkyFizZ1U5YSSMqjsEvw@mail.gmail.com>
Cc:     Eric Wong <e@80x24.org>, Alfred Perlstein <alfred@freebsd.org>,
        git@vger.kernel.org, git-owner@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <cfb712ee-ff0e-0f62-0477-6edf483d4101@web.de>
Date:   Tue, 23 Aug 2016 21:07:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <CAHLmBr1Cd_JimZEsLUjG=+v4CgsXGGzkyFizZ1U5YSSMqjsEvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kR22K3Qpeuz/PPKRdGqvR0rOtGPWLlS5k6bdMzJp6YXUkdfrvmC
 +5RGNA0Vfj4gswJ/Pw2vS9waLADShA09SyFXUabkTEUWJ95tq3KxWFiGPfntTzIAhBmEx3l
 JJC6lh/KcpLvpcRFipi8pZiEl8P1cUpM997ZuT5QQaQhVjEGrf8q9UrAMyHMtUf+zJu1YKF
 /pN7JvVEtH/Wex4Qp15xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QpjCTltoFOw=:1YeNYxYdScC4lsjXpY0zBp
 +Yv3bn+5oRbhM/7wAM00MayrT6vJvduPuq9g3lB6Az6QWQmdJ/hZKHBxKsXXS9Yg+CCHDac1l
 ZrbotrOMBxJ7ek7vtToxEKmPM2+ORBOk2SNbynqAkTnbUEOdrrBKAjIQxSz+wdudhwM57cFrF
 OHe+n4VbSNgmc8FQG3z0SAy+pfIlIzEQwWLanXjXnP4eust50BIZuow+RiJWJV36CNAmz3Miz
 r3A+ELGOPAFHgD3qs4QDe4WVTJMIFH39xPruxi+U2bD2L62GPh6aWHMOEBtQ9GMcJXnJOzj0P
 aknZHJOMRWAQDjyh4PyAAVqQirc/SZFLkJFsORQe33AwPMrhxah6+0/uArRcvh4zld14Ajnmp
 HxqX9Alv3heETW34MiEDXVjNvflkLHtwXq7K9VOnjhyQIw8oY5MqXQIpoPovZgD4F0X5f9Ck/
 vnvEz5FivoXCoJn7XK+Z24AZY6XJhb9StnLIrV8YKPP81j3vkE8ICrbTTz42A3bRSa6/KDEC6
 /fTuEawD+g5ye9nwH6h0Z1rFiX6VZqJPHsVoq3UpK4UexDWGRazG3FySCCiGx0LsssET7kCKv
 whrR/4ZEcoQ5HceMdbQJ8XoB227E3GTss2GWUnyBIOl9JalwkNQUfFkPNkaRIBWrlYMaa35yn
 HGM9ZJHwWPD9KtCDqXyn+ktglzqDZR5/nCzrORrO1j+McPGPL/fW/W1q3ydw+eix5p2TzTTjV
 WBCufC3fc3IxP5uVTVSmqOut/+bfVo+fnMY3DB8OD2+2XkOInKiM610QV20oiX3R9Dv1y1ObB
 C+vQW6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.08.16 19:50, Lucian Smith wrote:
> On Tue, Aug 23, 2016 at 10:36 AM, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
>> On 23/08/2016 17:14, Lucian Smith wrote:
>>>
>>> Thanks for the quick responses!
>>>
>>> My situation is that the git side is entirely whatever github.org is
>>> running; presumably the latest stable version?  They provide a URL for
>>> repositories hosted there that can be accessed by an SVN
>>> client--somewhere on github is the 'git-svn bridge' (as I understand
>>> it): something that receives SVN requests, translates them to
>>> git-speak, and replies with what SVN expects.
>>
>>
>> The ability to use a Subversion client is functionality provided by GitHub,
>> and not native to git itself.  So unless someone for the appropriate GitHub
>> team happens to read this thread I expect there isn't much we can do to
>> help.  I don't know if they've even provided any real detail of how they
>> implemented the bridge.
> 
> All right, that makes sense.  And yeah, it was hard to find any
> information about the bridge, which is why I ended up here...
> 
>>> There is indeed a .gitattributes file in the repository, but the SVN
>>> client doesn't know what to do with it.  My hope was that something in
>>> the bridge code, that translated SVN requests to git and back, could
>>> take the SVN request, "Please give me this file; I'm on Windows" look
>>> at the .gitattributes file in the repository, and hand out a file with
>>> CR/LF's in it.  Conversely, when SVN tells git "Here is the new
>>> version of the file to check in," the bridge could look at the file,
>>> realize it had CR/LF's in it, look at the .gitattributes file to know
>>> if it needed to be converted, and then convert it appropriately.
>>>
>>> I can imagine a full-blown bridge that could even translate the SVN
>>> EOL propset back and forth appropriately, but I'm not sure if going
>>> that far is necessary and/or helpful.
>>>
>>> I don't know if this is the right mailing list for that particular bit
>>> of software, but it at least seemed like a good place to start.  Thank
>>> you!
>>
>>
>> Supported properties are listed here:
>> https://help.github.com/articles/subversion-properties-supported-by-github/
>>
>> You'll need to ask GitHub to implement support for the svn:eol-style
>> property I expect.
> 
> Thanks for finding that!  That even has an 'ask a human' button, which
> I expect is my next step.
> 
>> Might be easier to just use Tortoise Git?
> 
> It may be!  But thanks for the responses anyway.
Most text-files have been commited with LF:
/tmp/ttt/sbml-test-suite> git ls-files --eol | grep "i/lf" | wc -l
   10266
Some have been commited with CRLF:
/tmp/ttt/sbml-test-suite> git ls-files --eol | grep "i/crlf" | wc -l
    1620


The whole repo deserves to be normalized and equipped with a .gitattributes file,
see

https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html


