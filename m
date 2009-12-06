From: Dilip M <dilipm79@gmail.com>
Subject: Re: Git GUI client SmartGit released
Date: Sun, 6 Dec 2009 12:07:33 +0530
Message-ID: <c94f8e120912052237g4be9afacmdd35031608c8700@mail.gmail.com>
References: <4B161B15.2020106@syntevo.com>
	 <c94f8e120912042337n43d5bcd0qc61a2820a8009dc4@mail.gmail.com>
	 <alpine.DEB.1.00.0912051601040.4985@pacific.mpi-cbg.de>
	 <c94f8e120912050832o6d43672bla3beb1e3cedd7db3@mail.gmail.com>
	 <20091205204455.GA49665@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: David Aguilar <davvid@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 07:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHAkf-00025a-7H
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 07:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZLFGh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 01:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZLFGh2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 01:37:28 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:55974 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZLFGh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 01:37:27 -0500
Received: by pzk1 with SMTP id 1so701266pzk.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 22:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=qJ0rkVhVn1miVSUVr4XpxvVgz6f5XpAbfeiKyzs3KNc=;
        b=v84gSNlrrJe4WKbz3A+wZvx7WKnUkakFOTWAoomAc1NSW26Kd7s3kqwP7fVhBSO6KO
         rT9cxVYUs4P0D20o1FjTmGSE5LhkhxwFXXJzoQ2kq0kXJUl+saAV155oK03twvtfZNLS
         OxxA2G0LZlIpl6Zw1jIOtva+4YPHNZ+CJoEJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=D3hBgejhOpiaAIT/8HblL/RI6JWxBNlbzMT9AgaIofqE2VWCDQ+Kgo+JB27epjeJnI
         hEfpxKx5VHvaZzOs4bi4zqkCOKR8NrDpMFTcqfYXG40ye4IqWFWNo2thccrg4EIjwmKU
         xtFOZF9jNjfrHL/AJvfRHjclhrsKMa2qmFaC8=
Received: by 10.140.199.16 with SMTP id w16mr326757rvf.252.1260081453978; Sat, 
	05 Dec 2009 22:37:33 -0800 (PST)
In-Reply-To: <20091205204455.GA49665@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134647>

Hi, yes..Cheetah has more feature set. Have to give a try once.

I really don't know the diff of Cheetah and Tortise. Want to know more
on Cheetah...any links would help. Some time back when googled all
resulted in Tortise.

On 12/6/09, David Aguilar <davvid@gmail.com> wrote:
> On Sat, Dec 05, 2009 at 10:02:08PM +0530, Dilip M wrote:
>> On Sat, Dec 5, 2009 at 8:31 PM, <Johannes.Schindelin@gmx.de> wrote:
>>
>> > As for "missing", do you refer to "paid service", or "yet another GUI"?
>>
>> Ahaha! I can say "a good gui" :)
>>
>> I was not knowing that this was "paid service". I saw the screenshot
>> and tried it. No doubt, it has a _great_ ui interface.  While installation
>> I
>> realized that it is licensed.
>>
>> - SOFTWARE Non-Commercial License,
>> - SOFTWARE Commercial License,
>> - SOFTWARE Enterprise License.
>
>
> Aside from the other good GUIs out there, have you tried
> git-cola?
>
> http://cola.tuxfamily.org/
>
> It's GPL and not too shabby.
> The screenshots on the webpage are a bit out of date, though.
> I should probably get to writing the release announcment and
> updating the screenshots ;)
>
> It probably also depends on your platform of choice.
> I know some Windows users like explorer-integration, so stuff
> like git-cheetah make a lot of sense for them.  I was a little
> sad to see that the tortoise-git guys didn't get the joke
> (who wants a tortoise when you have a cheetah?) and didn't
> just work on cheetah instead, but hey, it's all good.
>
> Another example: eclipse users like eclipse integration so for
> them egit makes perfect sense.
>
> Maybe that makes git-cola the poor man's smartgit?
> If that's the case then it looks like the poor man is still
> winning according to the feature matrix on the git wiki ;)
> I don't know.. I haven't used smartgit, but if there are
> any features that people are itching to have that git-cola
> doesn't then feel free to throw it on the backlog:
>
> http://github.com/davvid/git-cola/issues
>
> At first glance, the gitk-like history widget in smartgit
> is very nice.  I've been thinking about how to implement that in
> PyQt for a while but haven't yet hammered it out.
>
>
> Have fun,
>
> --
> 		David
>

-- 
Sent from my mobile device

Dilip
