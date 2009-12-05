From: David Aguilar <davvid@gmail.com>
Subject: Re: Git GUI client SmartGit released
Date: Sat, 5 Dec 2009 12:44:57 -0800
Message-ID: <20091205204455.GA49665@gmail.com>
References: <4B161B15.2020106@syntevo.com>
 <c94f8e120912042337n43d5bcd0qc61a2820a8009dc4@mail.gmail.com>
 <alpine.DEB.1.00.0912051601040.4985@pacific.mpi-cbg.de>
 <c94f8e120912050832o6d43672bla3beb1e3cedd7db3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 21:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH1VD-0000ph-47
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 21:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbZLEUo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 15:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbZLEUo7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 15:44:59 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:60755 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbZLEUo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 15:44:58 -0500
Received: by gxk26 with SMTP id 26so3173644gxk.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 12:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+Hmn1Y1/aasTa+owe3JLiUmrWWQkTkXQ/qRECo/rXAw=;
        b=QcZn9QGCnntbvjCvYboA3CMy8ipZfO1whp6BeClRagS3Qg2M9Dvi3cTYAXrCeXNtFM
         sYKHYwMI/KlFthzZ6C5js3j6sY5EcoJ9A9moHAnHxliKmqDnXIc5BSAEdq41JqX3gLRF
         Ksr95HLAL8dTgBD4S036YM5B4c+0M2Z5Ki4ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R6xGU8rPzxoKEA6SXQJyW3wJKzDAjNL8E8eeruuc9sGJfnds036GZOuPCg/zIVI5b0
         Nhk71DpDnvbCJ5VQ/DUG+UH350/JkOCKcS7cxE74C3PkdSBtyPFvi+ncL+8Ft8j5vPHb
         105HlexeYXhckyM6IJZQTylWNZPXY8iGZecX8=
Received: by 10.91.54.1 with SMTP id g1mr7754669agk.20.1260045904882;
        Sat, 05 Dec 2009 12:45:04 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 8sm2003576yxb.25.2009.12.05.12.45.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 12:45:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c94f8e120912050832o6d43672bla3beb1e3cedd7db3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134622>

On Sat, Dec 05, 2009 at 10:02:08PM +0530, Dilip M wrote:
> On Sat, Dec 5, 2009 at 8:31 PM, <Johannes.Schindelin@gmx.de> wrote:
> 
> > As for "missing", do you refer to "paid service", or "yet another GUI"?
> 
> Ahaha! I can say "a good gui" :)
> 
> I was not knowing that this was "paid service". I saw the screenshot
> and tried it. No doubt, it has a _great_ ui interface.  While installation I
> realized that it is licensed.
> 
> - SOFTWARE Non-Commercial License,
> - SOFTWARE Commercial License,
> - SOFTWARE Enterprise License.


Aside from the other good GUIs out there, have you tried
git-cola?

http://cola.tuxfamily.org/

It's GPL and not too shabby.
The screenshots on the webpage are a bit out of date, though.
I should probably get to writing the release announcment and
updating the screenshots ;)

It probably also depends on your platform of choice.
I know some Windows users like explorer-integration, so stuff
like git-cheetah make a lot of sense for them.  I was a little
sad to see that the tortoise-git guys didn't get the joke
(who wants a tortoise when you have a cheetah?) and didn't
just work on cheetah instead, but hey, it's all good.

Another example: eclipse users like eclipse integration so for
them egit makes perfect sense.

Maybe that makes git-cola the poor man's smartgit?
If that's the case then it looks like the poor man is still
winning according to the feature matrix on the git wiki ;)
I don't know.. I haven't used smartgit, but if there are
any features that people are itching to have that git-cola
doesn't then feel free to throw it on the backlog:

http://github.com/davvid/git-cola/issues

At first glance, the gitk-like history widget in smartgit
is very nice.  I've been thinking about how to implement that in
PyQt for a while but haven't yet hammered it out.


Have fun,

-- 
		David
