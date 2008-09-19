From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: GitTogether topics status
Date: Thu, 18 Sep 2008 23:03:12 -0700
Message-ID: <d411cc4a0809182303x365e2280r3fc8a9a3534d8890@mail.gmail.com>
References: <200809182207.21448.chriscool@tuxfamily.org>
	 <m363otmb8p.fsf@localhost.localdomain>
	 <200809190703.11969.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 08:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgZ74-0003mu-G7
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 08:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbYISGDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 02:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbYISGDO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 02:03:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:3100 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYISGDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 02:03:13 -0400
Received: by wa-out-1112.google.com with SMTP id j37so220573waf.23
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wtwtCNgO3YLqcBvCxptGNvjYmQ+ZCqWTkTu6mSSOkyk=;
        b=AXWEIfy5omgGz+CSyE4ptN1SaaZUHf3Kxc4DCScH2r42ZtyBH72sCqkpUi3L/+l7cR
         LGqxs5bJwkMalQrERkAbmG8yssVoN7Dk+Hx/773WWPyI6Tdtw5drAYyWUVDBBOUYwfzg
         314/d+2NEbGMs9/YDgZYx246vrDCV7KfENpQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q4EYy53moqqLpwl3t9EfIuZ/b4HImJTA+aLdso1OfgQ4OIHHYNsfJ1ee9VHnzNdRUS
         1RzzcKO0VOrCs3oJn2ZNhJz4PzVsT96LmdAmfdozx+f1nxIhnJ3HgZMm2wZYIm2e3VDL
         e1+rcym+2ZOB365L7irsf2uHqRtcUuGJK+1oE=
Received: by 10.115.76.5 with SMTP id d5mr5001842wal.191.1221804192677;
        Thu, 18 Sep 2008 23:03:12 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Thu, 18 Sep 2008 23:03:12 -0700 (PDT)
In-Reply-To: <200809190703.11969.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96259>

Hi,

On Thu, Sep 18, 2008 at 10:03 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Le jeudi 18 septembre 2008, Jakub Narebski a =E9crit :
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> > The topics suggested on the wiki are:
>>
>> [...]
>>
>> > More topics/ideas are welcome.
>>
>> Perhaps a good idea would be to take advantage of whiteboards and
>> meeting face to face, and talk for example about ideas for perfect G=
UI
>> for git, or for editor/IDE/RAD integration interface, designing
>> mockups of UI.  This could aldo help with improving git homepage (th=
e
>> original one, I guess).
>
> Ok. There are now the following topics together on the wiki:
>
>  * Git GUI that even a designer could use (Git``Cheetah, AKA Tortoise=
``Git?)
> (UI session?)
>  * Git integration with IDE, RAD, and editors (UI session?)
>  * New Git Homepage hammering-out (UI session?)
>
> The second one is new. And "(UI session?)" was added at the end of ea=
ch of
> them.
>
>> What also might be interesting to talk about scriptability, having
>> defined API, libification (I see that there is planned), interfaces =
to
>> other programming languages versus calling git plumbing versus
>> reimplementing git in other languages (e.g. JGit vs JavaGit, Grit vs
>> Ruby/Git, GitPython vs PyGit, Git.pm vs Git::Repo), but I guess this
>> discussion could be had on git mailing list.
>
> The following topics are now together on the wiki:
>
>  * Linkable library for basic object access (libification or new libr=
ary)
>  * Scriptability, using git in other languages (using interfaces vs c=
alling
> plumbing vs reimplementting)
>
> The second one is new.
>
> If we want these topics to be discussed during the GitTogether, we ne=
ed
> someone who wants to talk about or at least introduce these subjects
> though. (Hint, hint.)

I would be happy to talk about / introduce at least the second one,
since I've done most of the work on the pure-ruby implementation of
git in the Grit project, which is one of the more popular of the
re-implementations out there (and runs the GitHub site).  I would also
be happy to help with a discussion on the first one, since I added it
to the wiki in the first place and it is heavily connected to the
second topic.  I very much want to see a library that provides basic
Git object access that we can use to write proper bindings in
Ruby/Python/Perl.  If the current Git code is too difficult to libify
properly, then perhaps an alternate C implementation that is built
only for that purpose is preferable to having a re-implementation in
_every_ language.  Looking forward to the discussion.

Scott

>
> Thanks,
> Christian.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
