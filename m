From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 14:49:42 +0530
Message-ID: <CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com> <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 11:20:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USl19-0007C7-Mq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966522Ab3DRJU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:20:27 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:47350 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966504Ab3DRJUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:20:23 -0400
Received: by mail-ia0-f174.google.com with SMTP id m10so296016iam.19
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pEgYJUApEDvjTjDyZNYgPT1Aq16mhuI+CQhIuoTjm8Q=;
        b=oBX74TW2aKjz/xNb8pgkgDE+dw5/mrnegEqmk/yXqSdavd+6ULw201kn3bDY5dvQZz
         fL04fu5zmrqASYZ6Eq6Ms8ji+GlCIcg1ybVkwpimgX3FDMYPfO6UZosCnWDvL6JsmRIa
         IlBLDe4BTacQdpf25YOAKTH8RScZrqGLEev67jMoQ6yc5yZiCH1okWCB8P5eHUSIFcsV
         cOgqExqlhM90nNk7j4WzR7AV2nWMKkz/Nr47Y+nsgBddNGYeSOLXGHp4QS0B7K8n/s4+
         0uBJosj03buCglmltDrYqxckszRQilikTykQWsl50hm8VrR6RjpQSg4npymGAVQSC87d
         bbbQ==
X-Received: by 10.50.17.166 with SMTP id p6mr12716004igd.12.1366276822304;
 Thu, 18 Apr 2013 02:20:22 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 02:19:42 -0700 (PDT)
In-Reply-To: <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221630>

Felipe Contreras wrote:
> I think the commit message is fine, you don't. So YOU go ahead and
> write the proper one. If you don't, all you are doing is being an
> impediment to progress.

Hey Felipe.  Let's get a few things straightened out first:

- We all act in our selfish interests, and write code to scratch our
personal itches.  I don't write code or commit messages for anyone
else, and neither should you.

- However, we're not working in isolation.  We have this giant mailing
list where we all post our patches.  It's like a bazaar where we
compete against other patches for developer attention and potential
reviewers.  In other words, it's a free market, and we're selling our
product: if it fails to sell, will you blame the market or your
product?  I write clear code and beautiful commit messages exactly for
this reason: I'm fighting for attention!

- We have to learn to interoperate with others' code and conventions,
if we want to be part of the community.  That doesn't mean that we
drown out our individuality, but it means that a our patch series has
to conform to some minimal, loose, and evolving standard.  Now, you
can argue that many of the existing conventions are outdated (I do it
all the time), but it cannot change overnight.  Your influence on the
community will show up over an extended period of time.

- We are not an old enterprise who blame breakages on a few
individuals, and fire them.  We're a community where all of us are
equally responsible for all parts of the code.  I am as responsible
for the remote-hg code in master as you are, as I had every
opportunity to review it when the patch series came up on the list.  I
might have chosen not to, but that doesn't relieve me of
responsibility.

-  We don't practice division of labour.  There are no managers,
"testing people", "documentation people", "code-writing people",
"commit-message writing people" etc.  Everyone has to do some portion
of all these tasks, although we try to keep the boring work/ technical
debt to a minimum.  Don't ask other people to write commit messages
for your code.
