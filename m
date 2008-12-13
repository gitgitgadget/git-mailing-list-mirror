From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sat, 13 Dec 2008 02:16:34 +0100
Message-ID: <bd6139dc0812121716w73ea1145w7f870e887e00adc0@mail.gmail.com>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
	 <m33agtgp2v.fsf@localhost.localdomain> <32073.1229130284@redhat.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, torvalds@osdl.org,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: "David Howells" <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 02:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBJ8k-0002U8-IT
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 02:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbYLMBQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 20:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYLMBQh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 20:16:37 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:46545 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbYLMBQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 20:16:36 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1545011rnd.17
        for <multiple recipients>; Fri, 12 Dec 2008 17:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nYZXlY2mHHRDZjZGG/XqZ+jIgPgAeUeBZwHdKCOVSlE=;
        b=eKyf4uZO6737LScc8WvyjCaj4OuV/z+w+3QsmcW2fpDPkC0AeSk2PnafPip1ywJrdQ
         XoWP3+ygrRgkRmgFUZdYA22IDTT0GmUnrGuCEilnUnZoALvABE81+4FOC44J9mMJjMhJ
         5vfPs+zov+A5G3Bs8u98wU4AgJgfqf07L+w8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=hvmmCO5AW13LTgZ7FuJELiPT1gKP2i7xAUkhMDg5d1t/BBaFmakjdx9jwP8Iv/gqGw
         QLglrHEeNSmCaF1AwYj9BeGMvoTADyJmYoZJ+PGNa5PvkspTcmhaiDHzvJiKvS+TgQoF
         I05nBSX88IPzbRJLRyZN4Y0njN+yjO8Y2tKFo=
Received: by 10.150.145.20 with SMTP id s20mr6776780ybd.121.1229130994774;
        Fri, 12 Dec 2008 17:16:34 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Fri, 12 Dec 2008 17:16:34 -0800 (PST)
In-Reply-To: <32073.1229130284@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102976>

On Sat, Dec 13, 2008 at 02:04, David Howells <dhowells@redhat.com> wrote:
>  (3) You put some non-basic stuff in the basic section (branching - this isn't
>     ordinarily useful, IMHO), but you miss other stuff out ('git rm' for
>     example).

Erm, branching is not ordinarily useful? I think you're Doing It Wrong
(TM) then, since branching is a Big Thing (also TM) in DVC, not using
branches would be a bit like only using the first 4 gears in a car;
sure, it's possible, but you're missing all that extra power!

>  (4) It needs to be installed with GIT in a form that can easily be cut and
>     pasted from (maybe this is the case).

I'll agree with you that the git-scm site is in fact, a site, and as
such cannot easily be accessed.

>        github

First hit on google:http://github.com/

>        repoorcz

http://repo.or.cz

I'm sure both are supposed to be hyperlinks, and some text there as well.

-- 
Cheers,

Sverre Rabbelier
