From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Dead links, broken search box, confusing/inconvenient contact
Date: Thu, 03 Oct 2013 20:22:48 +0200
Message-ID: <524DB5F8.7010809@googlemail.com>
References: <CAHpmzU65EUSmBVsPgRKSykS5Z5BO0KpOWN5Bdc0MixLn64pDdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Stefan Pochmann <stefan.pochmann@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 03 20:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRnXz-0001Sj-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab3JCSWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 14:22:44 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:58124 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab3JCSWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 14:22:43 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1295372eak.4
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=sQR+NYVulqoTMy+RZe9VKEFwUpggBfE583KcuFSFbQY=;
        b=MrpMkCp4TIXIfdTayTIt9y8/VKf4ykti1mVEIIjEwYE9BzC9Q9cXOKoffkGwaC3Dhp
         27LGVZH0UdBW2uUhrwZ2a2s+293MzcDNSQLXwzwc64UEieyiO+7MCLe/lJot2ckuKhNg
         EmMC6LDO5a0Fsx29ysDQ5k1lv4ROEiR8jgeQf/TzPbTbzwNA/mg2PNT9o6EEwDRbxkXC
         RDRfQ+69GhAlYs6zIOYpIP0l4+Df76boutIE7A5Bz0tBeITa9tHK4ejHvGSrwidUqSbS
         JSI5fIj6rcNe1E2oMbTYTC97/aObCE/8Ly7Esfh0c+1nKJgLexCgr+IIVDOEW9dDYQTK
         p07g==
X-Received: by 10.14.174.131 with SMTP id x3mr5039045eel.61.1380824561652;
        Thu, 03 Oct 2013 11:22:41 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m54sm18586390eex.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 11:22:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAHpmzU65EUSmBVsPgRKSykS5Z5BO0KpOWN5Bdc0MixLn64pDdA@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235688>


Hi Stefan,

On 10/03/2013 07:50 PM, Stefan Pochmann wrote:
> 1) The links to Matthew's lists on the bottom of
> http://git-scm.com/downloads/guis are dead (I get 404s).
> 

git-scm is an open sourced site and hosted on GitHub.
It is providing some information for git, but also on github.
(It was started by the github founder iirc)
Improvements by your own or just filling an issue, would be best at
https://github.com/github/gitscm-next



> 2) Wondering whether TortoiseGit is mentioned anywhere, I typed
> tortoisegit into the top right search box, hit enter and got to
> http://git-scm.com/search/results?search=tor (note the ending - I did
> type the whole word but it got cut off!). I'm not *that* fast at
> typing, but apparently I'm still way too fast for the search box, as
> it does work when I wait a second or two before I hit enter.

Same thing, it's git-scm related, please get in touch there.

> 
> 3) Trying to contact you I first looked at the bottom of the page, the
> link to https://github.com/github/gitscm-next was the only that made
> some sense, and there I don't see contact information, even though
> that README does say " contact me first" at some point (and who is
> that "me"?).

I'd assume the "me" is https://github.com/schacon the founder of github.
The README may be outdated there.
This is the mailing list for the git project, which is run by different
people than the github company.

> 
> 4) When I found this email address and sent a mail with items 1)-3), I
> got a rejection reply saying " The message contains HTML subpart".
> Very annoying. I'm trying to help here by pointing out problems, and
> you're making it really inconvenient.

On this mailing list html is not appreciated as you wouldn't gain much
from it with respect to the development or discussion of git, only
larger emails.

Thanks for writing to the list, but it may be not the best place for
reporting git-scm.com issues.

Thanks,
Stefan
