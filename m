From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Wed, 23 Nov 2011 16:47:00 +0100
Message-ID: <CAH6sp9OXzHj=r707zyRQxaJmndHm5_DcWWMLn_1zyLdEZ_TSbA@mail.gmail.com>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local>
	<7vd3ckdjx9.fsf@alter.siamese.dyndns.org>
	<CAHVLzc=SPD+AHhAPP_=mEVv5cJvn0oiJ_k-KBEkG=Qhcw2UxHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 16:47:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTF2S-0001Xn-KB
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 16:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab1KWPrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 10:47:02 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33034 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab1KWPrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 10:47:01 -0500
Received: by qadc14 with SMTP id c14so2660068qad.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QMywg7c/4JkJZhzOkZKSqm7cx1dqDWPOUoOwa+CWgmU=;
        b=wnF8pN5Wv7jWE2moFyvUAU5rXABI3U/fAm+XarZuEX0NuhAIkrOJ5IHHJbKUrv0H17
         4HTyd1pF0KOhPUoRgfUzR9OaAt07wrM66mIrnykcgsyFXdQBGkqxFTi99ReaBnuMOFrR
         eQk4TZ8QyYsZhNzBBzQF73GAq/gEIgeI3FO48=
Received: by 10.224.117.144 with SMTP id r16mr10823272qaq.71.1322063220527;
 Wed, 23 Nov 2011 07:47:00 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Wed, 23 Nov 2011 07:47:00 -0800 (PST)
In-Reply-To: <CAHVLzc=SPD+AHhAPP_=mEVv5cJvn0oiJ_k-KBEkG=Qhcw2UxHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185851>

On Wed, Nov 23, 2011 at 2:44 PM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> On Tue, Nov 22, 2011 at 8:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Daniele Segato <daniele.bilug@gmail.com> writes:
>>
>>> [1] according to http://git-scm.com/ the link on "Git source repository"
>>> is https://github.com/gitster/git
>>
>> That one is as official as anybody's "git clone" from many of the
>> distribution points.
>>
>> I do not see any reason to name an official repository, but if I were
>> pressed, that copy at github is not the one I would nominate.
>
> But that's the only repo mentioned in the git-scm home page.

The note from the maintainer[1] mentions

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git
	https://github.com/git/git
	https://code.google.com/p/git-core/

I would assume one of those would be a nomination for 'official' repo.

Maybe something for Scott C. to address?

Cheers,
Frans

[1] http://article.gmane.org/gmane.comp.version-control.git/184174
