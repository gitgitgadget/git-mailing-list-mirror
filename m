From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Need help to complete the proposed gsoc 2012 project
Date: Wed, 1 Aug 2012 12:50:42 +0530
Message-ID: <CAH-tXsAjXxY28wGDVnwK21kmnXusnhfU3+Ed=S5nRc-UXAbTxw@mail.gmail.com>
References: <CAH-tXsByoeEWA0MZHp-xvJCpRZEXQT6G3M_MJYy+HwauW0ci0Q@mail.gmail.com>
 <CAH5451nw4VPpdMEQZEgM31BCuY+E=mgbAvti2k+RL6TKrC7N2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 09:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwTFK-00008B-5J
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 09:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2HAHVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 03:21:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51603 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab2HAHVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 03:21:24 -0400
Received: by wgbdr13 with SMTP id dr13so6636236wgb.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SwnQF6VopYxQGo1LcsPkz0uqnVMW9ZE09E2P24L3wx4=;
        b=J96rHViXPr4bzNKkFOeucUmEEkrwUsJaFth1pcUIpQmf/juNF5Hi6Nke1Oy6A6GuHw
         dWWE3gpiqmKtoVV72gkuC5xqISlR8VobWSTjVkSdLFI3IlJLNFlmg0JX66IhK1IWM8PA
         eMTMorz3PjkcEep1bdrEnqEGGEpuig8Ii2zU3W++Cx5Fq/5mHRyCkBzYljKSp1whEYwc
         Dqlnu4eN4exie/glBxxpP9fc2ot3uqNJ0KCiHckXdF3yRwHUX4qD3iMuGaGINahN416t
         1A3xaOJ59fYKU1vG1Dag8rgMMxANz6W+AkUPdfbhVhK4bzLzOCbFoP6iM2oC/i+ihNZA
         6TjA==
Received: by 10.180.19.169 with SMTP id g9mr9524630wie.9.1343805682932; Wed,
 01 Aug 2012 00:21:22 -0700 (PDT)
Received: by 10.227.30.133 with HTTP; Wed, 1 Aug 2012 00:20:42 -0700 (PDT)
In-Reply-To: <CAH5451nw4VPpdMEQZEgM31BCuY+E=mgbAvti2k+RL6TKrC7N2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202707>

On Wed, Aug 1, 2012 at 4:52 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On Wednesday, August 1, 2012, jaseem abid wrote:
>>
>> [...]
>>
>> Any help will be greatly appreciated.
>
>
> Was there anything in particular you wanted help with: code review, fixing
> bugs, implementing features?

1. Code review, I don't want to introduce new bugs in anyway.

2. Some changes are not trivial. I added a new dependency for
JavaScript developers - node.js for producing TAP output in the
console. I want someone to review those changes

3. Overall commit clean up.  I have cleaned up commits to logical
blocks, but it can be better

4. I am sort of happy about my changes on JavaScript files. I wanted
somebody to review the changes to gitweb/Makefile etc

5. Finish d10n

John 'Warthog9' Hawley also agreed to help and we talked over the IRC
sometime back.


> You've obviously done a lot of work, it would be good to complete this work
> and get it merged upstream.

Thanks :)

-- 
Jaseem Abid
http://jaseemabid.github.com
