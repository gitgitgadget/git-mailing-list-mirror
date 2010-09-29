From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Wed, 29 Sep 2010 15:30:18 +0200
Message-ID: <AANLkTimLyYMpedvk1OWYxZDQWWY0VvVy9Sk3ZURUxQKd@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk> <4CA1899F.2020509@cadifra.com>
 <141CAFB5-D423-48FE-BEED-B755C5F2685B@sb.org> <4CA2FA76.6080501@cadifra.com>
 <4CA30201.5020006@drmicha.warpmail.net> <AANLkTimPdqM_29Aru7tAGp_REem+BYAuE8o-U-qkhS6T@mail.gmail.com>
 <4CA33D07.3000207@cadifra.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Kevin Ballard <kevin@sb.org>, Rico Secada <coolzone@it.dk>,
	git@vger.kernel.org
To: Adrian Buehlmann <adrian@cadifra.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 15:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wkB-0000Cy-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab0I2Nam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 09:30:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36307 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0I2Nal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 09:30:41 -0400
Received: by pzk34 with SMTP id 34so165878pzk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=YYvwBsqGemgQJH8StGmSjPFrE3efFvpAWB5oDyLqCQw=;
        b=WeopE23iUcYd3H9FK4m472QVN//u70Y/Pi6hJhj2kLTKRHUVrB8o8YvRo7qQeqCKeL
         hOp43qdjc8AioSV1b6v+pbEkJeh42sLWyWdKcI3wSNhpKFCb0cLTk6lGVhpBXBDctkxP
         vdCfXVeU5NjbKX1Znptszz6RdNOzcYvFHmvQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=nepN/rHue6jHdg3M6+L46bbMc1A20Mgkc9BdX7iWND6WFEI/ru1l8x1e97oK7IAfD2
         AXc7w/Tm4NRwcs7rASePUzOKDSQ0v+4lgBs/c+9+hs2f5/yGsqamoNCf4naYCAg/oU1T
         Srs5lfDTPSqgjENhoKl5oWPxkRQs+ZOzZmbqc=
Received: by 10.114.13.9 with SMTP id 9mr1816666wam.195.1285767038650; Wed, 29
 Sep 2010 06:30:38 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Wed, 29 Sep 2010 06:30:18 -0700 (PDT)
In-Reply-To: <4CA33D07.3000207@cadifra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157567>

On Wed, Sep 29, 2010 at 3:20 PM, Adrian Buehlmann <adrian@cadifra.com> wrote:
> On 29.09.2010 15:00, Erik Faye-Lund wrote:
>> On Wed, Sep 29, 2010 at 11:08 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Adrian Buehlmann venit, vidit, dixit 29.09.2010 10:36:
>>>> Of course, I would be fine if this list here would be simply defined as
>>>> the "git development centric list" and a new, more usage-centric list
>>>> could be started (git-users ?).
>>>
>>> You mean something like:
>>>
>>> git-users@googlegroups.com
>>>
>>> I don't participate there, but my impression is that it's really a user
>>> group.
>>>
>> http://groups.google.com/group/git-users says "This is the git mailing
>> list for users, feel free to ask any question about git usage.", so
>> yes. I think we already have that list. Perhaps all we need to do is
>> to add a link to it on the front-page of git-scm.com, next to the link
>> to this? Perhaps something like "You can also ask the Git development
>> community directly at our git@vger.kernel.org mailing list, or the Git
>> user community at git-users@googlegroups.com"?
>>
>> That would imply making it a bit more official, but perhaps it's a
>> good compromise?
>
> At least it could be mentioned on
> https://git.wiki.kernel.org/index.php/GitCommunity
> ?

Done.
