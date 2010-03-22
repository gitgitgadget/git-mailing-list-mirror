From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Mon, 22 Mar 2010 12:58:05 +0530
Message-ID: <f3271551003220028w79d2f1b4q5a47ca8d21515288@mail.gmail.com>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com> 
	<f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com> 
	<alpine.LNX.2.00.1003211907390.14365@iabervon.org> <fabb9a1e1003211635w27f0b22em73c7c6431c3998af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:28:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntc3s-0005sz-Im
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab0CVH21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 03:28:27 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:55106 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab0CVH20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 03:28:26 -0400
Received: by gxk9 with SMTP id 9so359737gxk.8
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=LlmzwIjBeUuSVI8nHGz8cgogG+t15dBt6O2oaUjWEZI=;
        b=YN2UimN0ZI8MiHpsUNGrr2K+s/AOiPWrDo1wZJ8vgqoG7EXqQ2OJWyAeJNVht2+8Kb
         OrcNKFoEpJidBX+3E1dNBPiQVGW+F7JEpPPjqvcNHOOVlSPOYuZoCYt29qZLAHx1sae/
         fRppwSOnz10Ck6uuBbRGx13hj/KAg7QuX6pMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=v2sVmCCM34A270u5Zabz0RZkhoqo1OPm80eG5/xbPaI+3lFg6pi+0YiNB3XYnmeE2/
         sLB177tMKiNv57bqPQAsJZ5F/2jrao8oBZqr8PxUbtM1/PgKnqUgdOUizO3mzHoCBHdP
         7vTVWituqfAl9U7JxGHgLOa3aAMxGxWqnVbmQ=
Received: by 10.90.1.32 with SMTP id 32mr3931764aga.22.1269242905149; Mon, 22 
	Mar 2010 00:28:25 -0700 (PDT)
In-Reply-To: <fabb9a1e1003211635w27f0b22em73c7c6431c3998af@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142904>

> Speaking of which, I have uploaded a preliminary version of the export
> capability to my github repository [0] since Ramkumar wanted to have a
> look at it. Sadly I have not been able to test it yet, I wanted to
> work on that today but instead spent hours on getting the first
> argument to the helper to be 'origin' (or whatever the user sets it to
> with the --origin option), something that's been bothering me forever.
> No documentation yet though, working on that ;).

Thanks! I'll look at it in the evening.

-- Ram
