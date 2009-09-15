From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 14:45:30 +0100
Message-ID: <26ae428a0909150645s59e1fb40hbb19e672230077eb@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
	 <26ae428a0909150627n4e5935bcxdcdf0fdd33a44aa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLz-0007XQ-IH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZIONpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbZIONpd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:45:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:4248 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbZIONp2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 09:45:28 -0400
Received: by ey-out-2122.google.com with SMTP id 25so789179eya.19
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=b3Z6P69d1oL4TrOabDGwQeqN0seqDnMpvvnSPnGCuws=;
        b=exUYJifBZYkz1IOGWax1h1Pe+xv+EuCnMJx3wu8STOBTos0V8G2oZcv5+9yGzTpEaY
         UbZ2jvu6K7fITI+/8Z2VVADQ1fIiZM8cMEDPyIpRsRt1yNWZR89YM8McDon2Hm6UaB0o
         pFKkIY6GRa5h9I/IN9Rp9gVm/WZu/Gdb4EfhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PM07gsMjDKjBWRBrhJj32GtRp5UJYYPtcq4byCPGjUe7LvHig7i29sXYkbSnIpn7JR
         Bh+1FswJmG5Zs6cSI8Qh83+v6IjKF/RlmrPF52+AI47Xo3PBDK8tonHe49fdmwFKtMu4
         DKQLGVqoY+PO0UVDOLEmib06YDbfgEVF87otw=
Received: by 10.216.15.7 with SMTP id e7mr1578162wee.202.1253022330370; Tue, 
	15 Sep 2009 06:45:30 -0700 (PDT)
In-Reply-To: <26ae428a0909150627n4e5935bcxdcdf0fdd33a44aa8@mail.gmail.com>
X-Google-Sender-Auth: be150476ff5ebcc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128560>

Martin et al.

Thanks for your help and sorry for ranting (also to Daniele Segato who
replied off-list).... these things always happen when you have the
least amount of time to deal with them!!

Problem solved.... well bodged actually (just copied files which were
all in one directory over to the correct branch).... but it will do. I
shall be MUCH more careful in future :-)

Howard

(PS. I now even know what 'top-posting' is - but not why it's bad.)

2009/9/15 Howard Miller <howard@e-learndesign.co.uk>:
> What's to stop me.........
>
> * The "wrong" branch just tracks a remote so I can just dump it once =
I
> have this fixed - (delete it and recreate it?)
> * after my 'reset' the files I have in my working copy (still the
> wrong branch) should be the latest version ('git reset' does not
> change the working copy I think?)
> * So can I grab these files (they are mostly new), checkout the
> correct version, and just overwrite the existing files? I'll loose
> some history but not much and I don't care
>
> Seems too easy :-)
>
> 2009/9/15 Howard Miller <howard@e-learndesign.co.uk>:
>> Martin,
>>
>> Got as far as applying the temporary patch and I now get a load of..=
=2E
>>
>> Reversed (or previously applied) patch detected! =A0Assume -R? [n]
>> Apply anyway? [n]
>> Skipping patch.
>> 1 out of 1 hunk ignored -- saving rejects to file
>> theme/onepointnine/local.css.rej
>> The next patch would create the file theme/onepointnine/local.css,
>>
>> funnily I didn't think that file had anything to do with it, but whe=
n
>> I changed branched I got
>>
>> T =A0 =A0 =A0 theme/onepointnine/local.css
>>
>> Not sure what the T means :-(
>>
>> H.
>>
>> 2009/9/15 Martin Langhoff <martin.langhoff@gmail.com>:
>>> On Tue, Sep 15, 2009 at 2:10 PM, Howard Miller
>>> <howard@e-learndesign.co.uk> wrote:
>>>> Martin,
>>>>
>>>> Looked at gitk - yes there is definitely one more commit still on =
the
>>>> current (wrong) branch.
>>>>
>>>> I deleted the offending file and have now successfully switched to=
 the
>>>> other (correct) branch.
>>>
>>> ok!
>>>
>>> so you have
>>>
>>> A - The commit you undid, and have in the temp patch. Note that thi=
s
>>> patch file is missing the file you've rm'd.
>>>
>>> B - A commit you haven't "undone" on the "wrong" branch X.
>>>
>>> =A0and you are on branch Y
>>>
>>> so now...
>>>
>>> 1 - git format-patch Y^..Y =A0# will export that patch B into a fil=
e for you.
>>> 2 - git am 0001-whatever-the-name-of-the-file.txt # patch B
>>> =A0 =A0this may need conflict resolution - read the notes it prints=
! If
>>> it refuses to apply the patch, do "git am --skip" to indicate you
>>> won't use git-am no more for this, and try applying it with the pat=
ch
>>> utility.
>>> 3 - patch -p1 < your-patch-A.patch
>>> 4 - find and readd the file you rm'd earlier -- if you don't have
>>> another copy, we can get it from git reflog but that'll take extra
>>> steps :-)
>>> 5 - git commit # you're committing your patch A here
>>>
>>> Now, review with gitk to see that you have what you want to have
>>> there. If it's all ok...
>>>
>>> =A06 - git checkout X
>>> =A07 - git reset --hard # unstich that last stray commit
>>> =A0 --
>>>
>>> hope the above helps. Git pros will see that the process could be m=
uch
>>> shorter :-) I chose this specific path because in exporting your
>>> patches and applying them again you can see each step.
>>>
>>> If we were to start again, and the branches are reasonably close to
>>> eachother (not 19_STABLE vs cvshead :-) ) then you can say
>>>
>>> =A0- X has 2 bad commits that belong to Y, then
>>> =A01 - gitk X & # open gitk to visualise the commits, send it to th=
e background
>>> =A02 - git checkout Y
>>> =A03 - git cherry-pick X^ # takes the next-to-last commit from X an=
d
>>> tries to apply it here - conflict resolution may be needed
>>> =A04 - git cherry-pick X # same with the very last commit on X
>>> =A05 - gitk # check that is all as you want it
>>> =A06 - git checkout X
>>> =A07 - git reset --hard X^^ # "rewind 2 commits"
>>>
>>> hth,
>>>
>>>
>>>
>>> m
>>> --
>>> =A0martin.langhoff@gmail.com
>>> =A0martin@laptop.org -- School Server Architect
>>> =A0- ask interesting questions
>>> =A0- don't get distracted with shiny stuff =A0- working code first
>>> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>
