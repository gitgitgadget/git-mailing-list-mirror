From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 09:45:40 +0100
Message-ID: <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
	<20110112182150.GC31747@sigill.intra.peff.net>
	<AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
	<AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
	<AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
	<AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
	<AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: JT Olds <jtolds@xnet5.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 14 09:45:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdfI7-0002Hf-JZ
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 09:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757417Ab1ANIpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 03:45:45 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47396 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab1ANIpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 03:45:41 -0500
Received: by qyj19 with SMTP id 19so6565858qyj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1MKe9yQD7eYwC9wA9pZdQNToYGxdqzifB06+ViUSUtc=;
        b=WvRvEjkT7YNedwpyN0lm1PU+gd7+U8mRIopw3v4Dh7woYhIQ1nZBsUiBkH2ekx3gt8
         gKOmiPc7lJC2YbQvD0po43JbKRtqyjTCrl9VV5yM/6KkwDIro/NjHZGmaoUkyqvREShm
         032UMOiObPaRIWNlTjazo7uoHU5SsN2gxdGVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=C/OOWgbQYQ49qutomDmMaPWvnVxCafFOiNNURSwB15xJ43yP6yQ9e9L6U8sbXnMYDo
         CK0jRMABr59oNIGLmzDuZnn6nw6Qw0z8OM5cHHjigvUfNmhQV23xTZ8ugC4Fu/s7Uq7t
         ZIpQ0CqIQzZhVDwPW+yBO+JVBB/BjLh2ORMCs=
Received: by 10.229.241.196 with SMTP id lf4mr414292qcb.284.1294994740498;
 Fri, 14 Jan 2011 00:45:40 -0800 (PST)
Received: by 10.229.84.202 with HTTP; Fri, 14 Jan 2011 00:45:40 -0800 (PST)
In-Reply-To: <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
X-Google-Sender-Auth: Bd6jUDvf4io1HdE8lLpokGksGcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165080>

On Thu, Jan 13, 2011 at 19:20, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>[..] Besides, a name of
> two characters aren't really sane. You'd need at least three
> characters to form a first/last name pair.

I think I've mentioned this before in another thread, but first/last
name isn't universal, not even within countries where it's the common
form. When I was as student there was a fellow student from another
scandinavian country and his legal, full name consisted of a single
letter.

-Tor
