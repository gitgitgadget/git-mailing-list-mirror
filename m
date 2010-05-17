From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Development Environment Setup
Date: Mon, 17 May 2010 07:53:16 +0100
Message-ID: <AANLkTilZLOyTRWNJ36HelPAJWJUHUXh8c_e5N6iKCdee@mail.gmail.com>
References: <00b801caf560$6d07be50$47173af0$@burgmann.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Albert Krawczyk <albert@burgmann.anu.edu.au>
X-From: git-owner@vger.kernel.org Mon May 17 08:53:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODuCa-00054c-SV
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 08:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab0EQGxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 02:53:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34037 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0EQGxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 02:53:18 -0400
Received: by fxm6 with SMTP id 6so3420674fxm.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=yQaKfYRHBOIeGuC9PLcC/+M0QBCuKZ1QZgkdWhGXsCA=;
        b=jn8UBjpxkN39v6+FLyfhsCGh1p9UYbfKLUn9+tLbj2A+bi8FqNIfztYfBgsuN4S9OK
         VHifL20RUaomz4TQ40JNe5HnREONwNN/I0MFmnJlRON+zmu9e8buEY1YkyHX8Knzikw2
         RnhDjPA6VRGgfZjh0HgC4l0eX9an2DHKnUjhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=kuldo/5wjZK2AT7IJcUPh9egnAzPWGfyhaGMFaE/lPXUU5d2B1WR2Tu3X7uM3gZIBr
         VTLbDy4yDxtAm0LwT8QwAAbnavvMw9hcQBA1CADA6WP6801Sa98h9U2onYBVl7jjYNnH
         NjtkQZF5RT7cqG+yUuUZuLKYr8CLaFSqm7hLA=
Received: by 10.239.167.16 with SMTP id d16mr428567hbe.118.1274079196606; Sun, 
	16 May 2010 23:53:16 -0700 (PDT)
Received: by 10.239.133.69 with HTTP; Sun, 16 May 2010 23:53:16 -0700 (PDT)
In-Reply-To: <00b801caf560$6d07be50$47173af0$@burgmann.anu.edu.au>
X-Google-Sender-Auth: Xy7Z9OEAnxS_JyZhavFWDaSVom0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147211>

> I'm curious, what is the recommended / typical setup for Git development?
>
> Do people use IDEs? If they do what are they?
>
> I'm looking to do dev on Ubuntu.
>
> Thanks,
> Albert

I've been doing development of one sort or another for longer than I
care to remember and currently develop PHP on (mostly) Ubuntu. I've
never found anything that beats the speed and versatility of
vim/ctags/git. I have tried (more than once usually) all the IDEs I
can but, clever though they are, they always seem to get in the way.

In case you have any doubt about it, git has made the single biggest
difference to my productivity that I can think of for a long, long
time.
