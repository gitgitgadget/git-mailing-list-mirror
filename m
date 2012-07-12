From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: How can I append authentication with "git push" ?
Date: Thu, 12 Jul 2012 12:04:27 -0300
Message-ID: <CACnwZYfbbZJV--aaOVH+af+Hxibg7XWvb909kZYWgKXVHexfDw@mail.gmail.com>
References: <20120712134844.2d1c4378@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 12 17:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpKwT-0000gT-1s
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 17:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934014Ab2GLPE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 11:04:29 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54301 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab2GLPE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 11:04:28 -0400
Received: by qaas11 with SMTP id s11so1739682qaa.19
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OONQIvA9+0rA/elHhNlAQRv74aGjF4AMHCCMpYR+Iys=;
        b=lol1NBhDl4l2kqGYfOavtCdg4sduFjaIqkoP7f30aJxquHzG/AF4jCJZKkh3goSL1/
         3ozNsOOxXeixEmoMS8M5rAP9pAEpgaEfxUzKzOObK1Nywfsi7K0hDA8rE0AdrGQEkqo/
         ExXRe6P233LVHHq86PxMn+CL6J3QijTcSKG8F+U6XtCJfpmCCCAYYahRWnXlOL9nDf2Q
         QwFyOBSbPNjkydputBvUbhNWZxfHjgAOUUJG/QvA+aiVfrtihB35Xy3NQRn1wcgBDVbn
         k3SXJkJt6b250DR0cQcMR1qn0SHmCVjeiudDDM4gdkKBDWDzws3Q2zAn8h8scmKsI0ag
         vW/Q==
Received: by 10.60.9.193 with SMTP id c1mr7784364oeb.47.1342105467298; Thu, 12
 Jul 2012 08:04:27 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Thu, 12 Jul 2012 08:04:27 -0700 (PDT)
In-Reply-To: <20120712134844.2d1c4378@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201361>

On Thu, Jul 12, 2012 at 5:18 AM, J. Bakshi
<joydeep.bakshi@infoservices.in> wrote:
> Or any repo wise configuration file where I can save the info, so that
> it doesn't ask the credential before every push ?
>
I'd like to know how to do that too.

It's a pain to have to type username and password every time I need to
push to github. (Linux here btw).
