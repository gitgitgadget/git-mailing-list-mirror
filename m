From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 19:49:38 +1000
Message-ID: <CAH3AnromoeSc=34H14j92kFg3FjWbdg+XuZcd72Aq04zScvD8g@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
	<CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com>
	<CAH3AnrppdYOC_Z4PWnzNLWXPSSQMBvHd9KPnQyAt40=FTn2dFg@mail.gmail.com>
	<CAGK7Mr5byhUOZ1vZTOMWWBVs4rXdE8RH+SS2ppz2QP1e-MiG0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:50:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgv4R-0002vk-5C
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 11:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab2FSJtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 05:49:55 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49348 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2FSJtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 05:49:40 -0400
Received: by wibhm11 with SMTP id hm11so481191wib.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A5+xkdpK8QF6LpSNaV9FOauiFsNivh4DdChOyj8lvB4=;
        b=FBwVKZB7F+j42Ko5DavBqX9dR38vJeMDEyMaLO6w5pU2uMOei0DE9UInytVlv3Hd3r
         6B+wGiWVo6OhVfQR90AUOV5OOiPpIG58F5dTNGuSiCjA6dLzclvt+HDeeBKW2BE1/SJk
         yrvPoZVVe/D+E9qoRA0iUhY26NlDJrF8Ys1m3PLL65HLD9tX16mokjbbTD9RBMcGRpPB
         wxOVUjdE5JYWW8478yINVOL4mpQ7HlzrkrxbtFhC4qoui8jGtapgB4YyA3LT/aL9OspR
         fx/UfJif7SgEz3oVWSQM8tZojd9HqlFGqh37410yYpZjG5UwAfuWA8S4Q3+Pe9p6s89/
         sDeg==
Received: by 10.180.98.39 with SMTP id ef7mr1846519wib.21.1340099378786; Tue,
 19 Jun 2012 02:49:38 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Tue, 19 Jun 2012 02:49:38 -0700 (PDT)
In-Reply-To: <CAGK7Mr5byhUOZ1vZTOMWWBVs4rXdE8RH+SS2ppz2QP1e-MiG0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200190>

On Tue, Jun 19, 2012 at 7:28 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> I was hoping to use cygwin because I don't like the (understandable)
>> limitations of the msysgit toolset (restricted set of available tools,
>> invoking bat files is painful, symbolic links don't work the same way,
>> etc)
>
> There's a git bash with msysgit which is probably more limited than
> cygwin's one but decent enough. About the tools you can install
> something like https://github.com/bmatzelle/gow/wiki or
> http://gnuwin32.sourceforge.net.

Yes, I have tried the msysgit bash which is ok, except for the
annoyances mentioned. Thanks for the additional links, which I shall
peruse.

>
> To be honest most of the time I just use the *nix tools from the
> windows command line, and jump into git bash for more advanced stuffs
> when necessary.
>

I do like my bash  and have got used to the way cygwin handles "the divide".

jon.
