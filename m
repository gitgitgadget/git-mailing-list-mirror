From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Qgit should use "git config" instead of "git repo-config"
Date: Mon, 9 May 2011 21:11:46 -0300
Message-ID: <BANLkTi=jsUwg7CgWfRr47Csq8yMeTKzO4w@mail.gmail.com>
References: <4DC85AA7.2090502@socialserve.com>
	<BANLkTikoViHF-AzfNwKkaYxsWhzvtRpvyw@mail.gmail.com>
	<4DC85F33.4020305@socialserve.com>
	<BANLkTimuWFSq_5_HkfgyXhRG6ysaVt_JwQ@mail.gmail.com>
	<4DC8617F.70001@socialserve.com>
	<BANLkTinsMTucb0Vj=rhkUNtv+hgsq2VfSg@mail.gmail.com>
	<4DC87943.6010805@socialserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Rogers <jrogers@socialserve.com>
X-From: git-owner@vger.kernel.org Tue May 10 02:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJaYK-0003jv-9u
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 02:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab1EJALr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 20:11:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54260 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab1EJALr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 20:11:47 -0400
Received: by iwn34 with SMTP id 34so4772325iwn.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZTSZuk9wYhbVn/D8gCr3Lt2km7xlJj0+MKR/lI4VhGg=;
        b=wDJoy7+Nkk/YfL9vvCgJwgE8GSn/KicwA/WilgxjuofqdEk+deR5gOuTptJd4a59Fj
         /3NnC+XRjgKzsdf9tI1lvmJvRcjUaPb4vE2tNo6zh05D95UBlaHW6uQsIuTBmtOKlASA
         bB6PB321x1KtOC6ArmSXhriyHQXtMhzENe/Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IAznrhU2qXbaO8NR6gE0MdT76DaT/LwLZaR9vqsdHUZ0UpQHbr1CqmRjwbp70UP0h4
         kAXsbIB/F3Um05mK7xwYKaYBAQHYrFMq5H4AWDUrkzVujtiWmThTeUm/62Wo6zA7KM/k
         4kLPuE9n7zd0mdlch1uxAZfDH53lDTlBubnW8=
Received: by 10.42.168.134 with SMTP id w6mr7305526icy.246.1304986306390; Mon,
 09 May 2011 17:11:46 -0700 (PDT)
Received: by 10.42.170.132 with HTTP; Mon, 9 May 2011 17:11:46 -0700 (PDT)
In-Reply-To: <4DC87943.6010805@socialserve.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173296>

Please, don't forget to +cc the mailing list!

On Mon, May 9, 2011 at 8:31 PM, Jonathan Rogers <jrogers@socialserve.com> wrote:
> Thiago Farina wrote:
>>
>> I think what he means by "Bugs or feature requests should be sent to
>> the git@vger.kernel.org mailing list." is?
>
> I don't understand the question.
>>
Ops, not a question. s/?/:

>> Reporting bugs on git goes to this mailing list. If you have a
>> suggestion that you would wanted to see on the git core you could try
>> to send to this mailing list.
>>
>> He doesn't say that bug fixes and improvements to the source code of
>> qgit4 should be send to this mailing list. Patches sent here are for
>> the git source code at all if I'm not wrong.
>
> Since the README and author clearly state that the git@vger.kernel.org is
> the preferred place to discuss qgit, it's not clear to me where else is an
> appropriate place to send the patch.
>>>>
>>>> Maybe there is another list for qgit4?
>>>
>>> If there is, please share it with me.
>>
>> Maybe try to send a pull request on github or an email to the author?
>
> I also sent the patch to the author. The repository is on git.kernel.org, so
> I'm not sure how github would be involved.
>
I just saw this at: https://github.com/kaitanie/qgit4/

> <URL:http://git.kernel.org/?p=qgit/qgit4.git;a=summary>
>
> --
> Jonathan Ross Rogers
>
>
