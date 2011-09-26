From: Scott Chacon <schacon@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Mon, 26 Sep 2011 07:03:03 -0700
Message-ID: <CAP2yMaL=Ox7mFQSA8yyOB9CoBaa_pQQ3bE4B9FugOnfJCT6XeA@mail.gmail.com>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
	<CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com>
	<7vvcsjuojp.fsf@alter.siamese.dyndns.org>
	<7vsjnnt5vg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Bm3-0006Wy-Ar
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab1IZODF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 10:03:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57689 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab1IZODE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 10:03:04 -0400
Received: by gwb15 with SMTP id 15so5324299gwb.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jK4tU1mBa1LadG0w5N2ZgoSekB3yX39UeoDEVce5LM0=;
        b=m6bPrUVzNSLXP1/TCR0S638sl0hzSklMe8vBoVKCQEZ8AFYiS5kCnghY4bDITbFYZV
         e2jHtcCzoxWml+m7EEC87R8xz2ncvWpTEyvGd8lbHSHU70B33QeDcEjIeyo/rCTiNNgf
         ecrqxFqHVwDoXTMFBTRqL5OvXvHzzf1gEz4Ho=
Received: by 10.150.159.16 with SMTP id h16mr6674712ybe.196.1317045783877;
 Mon, 26 Sep 2011 07:03:03 -0700 (PDT)
Received: by 10.150.212.13 with HTTP; Mon, 26 Sep 2011 07:03:03 -0700 (PDT)
In-Reply-To: <7vsjnnt5vg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182112>

Hey,

On Fri, Sep 23, 2011 at 12:29 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> It just occurred to me that https://github.com/git/git repository mig=
ht be
> the one you are talking about, but that repository is not even mine. =
=C2=A0The
> page at https://github.com/git says git@logicalawesome.com is its con=
tact
> person.
>
> I _suspect_ it is set up to mirror from my k.org repository and obvio=
usly
> nothing is updated from that route for the past few weeks. It is corr=
ect
> to say "html branch in that repository is no longer updated", but I c=
annot
> do anything about that repository ;-).

git/git is a mirror I set up from k.org years ago for git-scm.com. I
believe you've been a collaborator on it for a while now, so you can
push to it if you'd like.  The mirroring system is down since k.org
died and I've since moved it off the host I had been using to Heroku,
so I can't do the mirroring that way anymore.  If you want to push to
it I'll leave it there, otherwise I'll reroot your repo to be the head
of the GitHub network instead.
