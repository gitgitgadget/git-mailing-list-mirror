From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Wed, 29 Sep 2010 15:00:50 +0200
Message-ID: <AANLkTimPdqM_29Aru7tAGp_REem+BYAuE8o-U-qkhS6T@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk> <4CA1899F.2020509@cadifra.com>
 <141CAFB5-D423-48FE-BEED-B755C5F2685B@sb.org> <4CA2FA76.6080501@cadifra.com> <4CA30201.5020006@drmicha.warpmail.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adrian Buehlmann <adrian@cadifra.com>,
	Kevin Ballard <kevin@sb.org>, Rico Secada <coolzone@it.dk>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 15:01:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wHe-0006DQ-K5
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab0I2NBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 09:01:13 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55395 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0I2NBM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 09:01:12 -0400
Received: by pxi10 with SMTP id 10so154130pxi.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=gIAN7geWWizclqdbBhdDjucw3WXC1G3bqstrCzkNF7E=;
        b=vat4LjPVDrpt3v/3hlxFu09zb4LTjRE6AbrHne65Qca06RDJtDrRzdjliUv5YgTT/y
         zlG2DBd7jD2UjYD8Kt0a2nIVZGcB4Y9cMQZJ2U1cDHgKDVCLk1u6kV832+lVOHpZH+/b
         CWth8bjVD/yp/w/LzFzfskbJH6guztymG/+4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=icF6M2/GLQU3MDAh51JAB5+bQKXROiKha2fFGNCoausC20l1qmMkVcktT0pXXEm0dW
         Z04W0faNcxDvMadvozKm9HQXdGyJkgExKhpseHLA0HPGlmMJ884XhJCCBxawAWL3hs2Z
         MyuQu1rfqhCV4teFK8qNwDVckZ9QdHtNXNoOQ=
Received: by 10.114.110.10 with SMTP id i10mr1825542wac.70.1285765271796; Wed,
 29 Sep 2010 06:01:11 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Wed, 29 Sep 2010 06:00:50 -0700 (PDT)
In-Reply-To: <4CA30201.5020006@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157561>

On Wed, Sep 29, 2010 at 11:08 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Adrian Buehlmann venit, vidit, dixit 29.09.2010 10:36:
>> On 28.09.2010 22:06, Kevin Ballard wrote:
>>> On Sep 27, 2010, at 11:22 PM, Adrian Buehlmann wrote:
>>>
>>>> I think this would definitely be an improvement for git users. At least
>>>> splitting up into dev and user, like Mercurial does it too (which I am
>>>> used to). Not sure about announce though.
>>>>
>>>> When I recently subscribed to this list (after having been a long time
>>>> subscriber to the Mercurial lists too), I was interested in seeing
>>>> discussions about git usage to help me get started with git.
>>>>
>>>> I also think searching the archives would be a bit easier if discussions
>>>> of new git development details and its usage would be separated.
>>>
>>> Perhaps it would make more sense to simply create a new list for git
>>> newbies to get help, and to not change the nature of this existing list
>>> at all.
>>
>> Of course, I would be fine if this list here would be simply defined as
>> the "git development centric list" and a new, more usage-centric list
>> could be started (git-users ?).
>
> You mean something like:
>
> git-users@googlegroups.com
>
> I don't participate there, but my impression is that it's really a user
> group.
>

http://groups.google.com/group/git-users says "This is the git mailing
list for users, feel free to ask any question about git usage.", so
yes. I think we already have that list. Perhaps all we need to do is
to add a link to it on the front-page of git-scm.com, next to the link
to this? Perhaps something like "You can also ask the Git development
community directly at our git@vger.kernel.org mailing list, or the Git
user community at git-users@googlegroups.com"?

That would imply making it a bit more official, but perhaps it's a
good compromise?
