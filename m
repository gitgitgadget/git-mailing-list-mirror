From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 13:20:47 +0100
Message-ID: <26ae428a0910190520t64411515je6f5c4551963d6bb@mail.gmail.com>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
	 <alpine.DEB.1.00.0910191155310.4985@pacific.mpi-cbg.de>
	 <26ae428a0910190308t3233debdjfc0c8beedb9c0ac6@mail.gmail.com>
	 <alpine.DEB.1.00.0910191353080.4985@pacific.mpi-cbg.de>
	 <26ae428a0910190519mbe9ddaava3c15de94a0cd14f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mohit Aron <mohit.aron@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 14:20:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzrEM-0005ta-At
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 14:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbZJSMUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 08:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbZJSMUo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 08:20:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:13976 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZJSMUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 08:20:43 -0400
Received: by ey-out-2122.google.com with SMTP id 9so911013eyd.19
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=/SPnFe1tpfbQWzNACom9Bngim2ckqp9RvmfXGZueBqg=;
        b=XvxCEsqfiWLR2mvzYrVP6Urrg+A86wbicHqeJYKynOrqHcbq4aLeoH51CSYd/xy3qr
         vB8dk8lORtV2bJ2jN/ivOHp8zroGoxr5/EXGp499f8yCr8/ul6dNHfkS7xCMu8bBYRqt
         9+vhbziKT0HHxcxrVcuWJFINJI9GE8gFjadyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VOfV6zk9nEcf2ZVpaVKYwjTNPVdRGfMi/vN/I6AXC6rZo8nM7qQCXIpQvdSCACKMmh
         jghgenixhETi+5U80IKffAo6hDFhx4jcLvwYwrTT2KY1pvrWvOXKoTPe6D/GjvRWGMcs
         3zB9yNvhxm6+fRk+3wQm6zk23n1UpoLupgMCQ=
Received: by 10.216.91.81 with SMTP id g59mr1800791wef.128.1255954847183; Mon, 
	19 Oct 2009 05:20:47 -0700 (PDT)
In-Reply-To: <26ae428a0910190519mbe9ddaava3c15de94a0cd14f@mail.gmail.com>
X-Google-Sender-Auth: 8bd8c04c4dd04d32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130694>

And... I instantly have to apologise..  With wonderful irony,
Googlemail folded the helpful bit of your reply leaving just the
(apparently) unhelpful bit.

(Crawls under nearest rock).

2009/10/19 Howard Miller <howard@e-learndesign.co.uk>:
> Mmm....
>
> Thanks for the helpful reply Johannes. Perhaps you should do diligent
> research into mail software that folds quoted text for you. There's a
> company called Google you might have heard of. Just a thought.
>
> On the other hand if you can't be bothered making a helpful reply
> rather than a rude one perhaps simply not writing anything at all
> would, at the very least, leave us absolutely no worse off. Just the
> opinion of someone not to be taken seriously.... of course!
>
> Howard
>
> 2009/10/19 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi,
>>
>> first, if you want to be taken seriously, you might want to avoid to
>> top-post.
>>
>> Second, do diligent research (e.g. on the 'mob' user).
>>
>> On Mon, 19 Oct 2009, Howard Miller wrote:
>>
>>> I'm quite interested in this too but I can't see what that patch do=
es at
>>> all. I'm unsure what the 'mob' account is but a search suggests it'=
s
>>> something to do with anonymous access, which doesn't seem to make a=
ny
>>> sense.
>>
>> If this trivial script (_not_ a patch! This should be obvious at fir=
st
>> sight) does not make any sense to you, I fear you will not be able t=
o use
>> hooks to do what you want to do.
>>
>>> Can you explain?
>>
>> Yes.
>>
>> The 'mob' user (who is password-less) can push to the 'mob' branch _=
iff_
>> that exists. =A0IOW a user of repo.or.cz can decide to let random pe=
ople to
>> push commits by creating the 'mob' branch and adding the 'mob' user =
to the
>> pushers.
>>
>> The first part of the hook (as you can see from the pretty helpful e=
rror
>> messages it outputs) is about denying to push to anything but the mo=
b
>> branch.
>>
>> The second part is much more interesting in the context of this thre=
ad
>> (and I would expect anyone capable of reading shell scripts to see t=
hat
>> readily), because it denies the 'mob' user to _create_ the 'mob' bra=
nch.
>> See line 16ff.
>>
>> So the point is: the update hook gets a "$2" =3D 0000... in case a b=
ranch is
>> about to be created, and the hook can prevent that by exiting with a
>> non-zero exit code.
>>
>> Hth,
>> Dscho
>>
>>
>
