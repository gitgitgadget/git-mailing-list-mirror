From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: A basic question
Date: Thu, 11 Oct 2012 18:08:58 -0700
Message-ID: <CAJsNXTm3k6YYFLhM9WZo2ZwKQjxWUHKbbbWvVYO_sKvCxsKD6w@mail.gmail.com>
References: <001501cda711$8ab6f0a0$a024d1e0$@com>
	<1349897794.32696.15.camel@drew-northup.unet.maine.edu>
	<002801cda7d7$4792c260$d6b84720$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Drew Northup <drew.northup@maine.edu>,
	Skot Davis <skotd122@gmail.com>, git@vger.kernel.org
To: Jim Vahl <jv@wmdb.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 03:09:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMTkX-0001Xu-ET
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 03:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab2JLBJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 21:09:01 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36566 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab2JLBJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 21:09:00 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1735504lbo.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=rdqBlKGGh/kOl0kt3dLf/cOi+bP0WQwOwnBf0kALZa0=;
        b=Tvu+ylO06IxOhD2HcL25qZHzwk0PVNESqO1558lvLLgZutNuos6sTZo6D9HiedAlhA
         ki5N+TvAzdMNGjPtnFBiex3ETfHQNjPA9rZrwam6hKETy6JWD2xK6Pl9+/j1JmIvouML
         MvVt1JL3BE0HhbTZrNNzxMkivU+eEuaAZZeg3HuBHuROMM+QevCVpE8KHhm9/pkSo16z
         491wT0dMMYBKLhmaopu4oOzgpqXaD+EzBoueldBr1lZB8aU6G1zAW7iZjQyOjj8gaYXZ
         4Wn0n+vLNT14KxlQq95aNX/oynP5XnSmHQbWgaPKT8tBUtQ3mlTEqDfmR1iuCcd87CIi
         6R3w==
Received: by 10.152.112.136 with SMTP id iq8mr2416493lab.18.1350004138762;
 Thu, 11 Oct 2012 18:08:58 -0700 (PDT)
Received: by 10.112.6.197 with HTTP; Thu, 11 Oct 2012 18:08:58 -0700 (PDT)
In-Reply-To: <002801cda7d7$4792c260$d6b84720$@com>
X-Google-Sender-Auth: V2YkvTEMqy-E3Xw7njZMwd-IC74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207526>

On Thu, Oct 11, 2012 at 10:38 AM, Jim Vahl <jv@wmdb.com> wrote:

> 1) Does git have a built-in way to get a list of all of the "most recently
> committed" files only at a given point in time, thus automatically recording
> the revisions of all of the component files of a release?   This implies
> that for files which are being modified or which have been staged but not
> committed, that git would go back to find the "predecessor" file which had
> been committed.

I feel like I'm missing the point of your questions.  Why do you think
your central repository would contain anything that hadn't been
committed?

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
