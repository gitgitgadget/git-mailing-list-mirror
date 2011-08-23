From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Restoring timestamps (Re: Branches & directories)
Date: Mon, 22 Aug 2011 20:20:29 -0700
Message-ID: <CAE1pOi1c2sKh671sFjHtHR3ux9Uv8Xinqg3RNpC2dBRXQnPc=Q@mail.gmail.com>
References: <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<20110822210141.GA3880@elie.gateway.2wire.net>
	<CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com>
	<CAFzf2Xw6=BFsKauYTG-4cw0D_LzLSNb_wqz8dQJ83wJHNQXbdg@mail.gmail.com>
	<CAE1pOi1J=TWUmJKZorotBsDoz3wozXsioN7fVO=7JBxdMD7Zqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 05:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvhbe-0004WO-2n
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 05:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab1HWDUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 23:20:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50420 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab1HWDUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 23:20:30 -0400
Received: by ywf7 with SMTP id 7so3982748ywf.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 20:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=innQ6RnNyJF0fBydTel5H4rMm/AHjgW7TF28gBfHiPE=;
        b=kMts5D6JFZNcnrtGXW3GnpwrFreEEUJB3kYELh+T2hH1UERjDlDCLa+2tbjE/YoGhQ
         N8lQnIZ5KFGwtXv1UG5oJO/gikcveb6cNfpJ/Db8+ViHkjLgx7ZRefaShLEmd4r2C5Th
         d8zozc4GVeBUfy9zUoooX+mKZdcR65Puz/Z9c=
Received: by 10.236.136.135 with SMTP id w7mr20230604yhi.51.1314069629403;
 Mon, 22 Aug 2011 20:20:29 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Mon, 22 Aug 2011 20:20:29 -0700 (PDT)
In-Reply-To: <CAE1pOi1J=TWUmJKZorotBsDoz3wozXsioN7fVO=7JBxdMD7Zqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179916>

On 22 August 2011 20:06, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrot=
e:
> On 22 August 2011 16:21, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hilco Wijbenga wrote:
>>
>>> You mean an extra dotfile per file in the commit?
>>
>> Let me step back a moment.
>>
>> When you mentioned mtime, a switch went off and reminded me of the
>> problem of metadata in general, especially owner and permissions. Th=
at
>> problem is important for people keeping track of /etc or $HOME in
>> version control (always a little dangerous because of the effect of =
a
>> stray "git reset --hard", but never mind). And the last time it came
>> up, I convinced myself that a hook script setting up entries in
>> .gitattributes, .gitmetadata, or .etckeepr with information like "al=
l
>> files are owned by root:root unless otherwise specified" could be a
>> good and not too invasive way to deal with that.
>>
>> Now that you remind me that the mtime of every file is likely to
>> differ from every other file, it is harder to imagine what situation
>> would make this meaningful information that should be stored in the
>> repository and shared with other people. It seems more like somethin=
g
>> associated to the worktree, which fits more closely with what you ar=
e
>> trying to do, anyway.
>
> Yes, indeed.
>
>> Regarding the problem "eclipse metadata is not carried over from one
>> worktree to another", isn't that going to be a problem regardless? I=
n
>> your proposed setup, each time you stash everything and start work o=
n
>> a different branch, the eclipse metadata before would be stashed alo=
ng
>> with everything else, which doesn't make anything any easier (unless
>> disk space is very scarce or metadata stores the absolute path to th=
e
>> cwd).
>
> Eclipse is a wonderful IDE except for how it makes sharing workspaces
> practically impossible (where "share" means "put in SCM", not "used m=
y
> several developers at the same time"). It's mostly (AFAICT) binary
> data with lots of absolute paths. So it's a pain but it doesn't make
> my scenario all that much more complicated.
>
> The hard part is creating a new branch. Somehow I would need to
> duplicate the state in the parent branch in the child branch. It need=
s
> to be duplicated because I need to be able to do git stash in the
> child branch *and* the parent branch. Is it possible to do git stash
> pop without losing the stash? Or to "copy" a stash? Otherwise, it's
> probably easier to simply write a separate script to do it. That
> should not be very hard. I would not use git stash at all.
>
> For a new branch, the script would
> 1. in "parent", move workspace (i.e. the root working dir, where .git
> is) =C2=A0into .git/branches/parent/
> 2. create and jump to "child"
> 3. in "child", copy .git/branches/parent into workspace (so creating =
a
> new branch is no longer a cheap operation)
>
> For an existing branch, the script would
> 1. in "current-branch", move workspace into .git/branches/current-bra=
nch
> 2. jump to "other-branch"
> 3. in "other-branch", move .git/branches/other-branch into workspace
>
> The moves (assuming everything is on the same partition) should make
> switching branches relatively cheap. Not very elegant (quite brute
> force in fact) but it's simple and I think it would work. Or did I
> overlook something? Better/other ideas are certainly welcome. :-)

P.S. I do not mean to imply that I have discounted simply using
different clones or git-new-workdir. Those are still valid options.
The script is probably a bit faster, though.
