From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Proposal for new Git Wiki admin
Date: Wed, 11 Aug 2010 15:06:03 +0300
Message-ID: <AANLkTimuHzC_brw2bBDTvc=-Cj+70AMFEj7nzspW5mGq@mail.gmail.com>
References: <20100810162602.GG3921@kytes>
	<m3y6ce2kdz.fsf@localhost.localdomain>
	<20100811050056.GA3715@kytes>
	<4C62494A.2030805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 11 14:06:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjA4S-0006Al-U8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 14:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab0HKMGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 08:06:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48934 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab0HKMGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 08:06:05 -0400
Received: by bwz3 with SMTP id 3so47487bwz.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rnX5GvTfkC9KSt/oX/1OV3OSO9/enCvm+jpCwL5PUT4=;
        b=OsdgKYFxanSR68+DFr8+fYYXLzvKbAU6hfQ8NrdplcJyqoiTHC5OyVv4xYNqsuyXT6
         ueC7wyaiCi5B9m2XksgrREezhDdpDy0FfEMn6IEogKl90ImMEBAvJxc2BeBZXu2hW/km
         h8RCbgouLou3YOEBQ07y8WXwlSKJT+yBY0XwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nmHIOtzzzvqG9WcTcggeWiJf2gszo8tp3GHdOyQ2DfS0MWYtufIq6exEger0Is/9zM
         zhzuP7Dx2Ph9UTtzYTKjYufu77dgQCEN/jbqhanZEJVqiDiqUc92/u5tYijsORrbq0V3
         aVFFDliI8s+LXHQm99xbUBFrLyOPH9dIog9Lo=
Received: by 10.204.74.195 with SMTP id v3mr5185023bkj.35.1281528363894; Wed, 
	11 Aug 2010 05:06:03 -0700 (PDT)
Received: by 10.204.21.200 with HTTP; Wed, 11 Aug 2010 05:06:03 -0700 (PDT)
In-Reply-To: <4C62494A.2030805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153227>

On Wed, Aug 11, 2010 at 9:55 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> +1 on Jakub and Ram because they showed restraint in the pertaining
> thread. We need moderators, not radiators ;)

Ok, I was going to let go what happened, but you are calling me a
radiator. So here's what happened

1) On August 7 Johannes (Dscho) deleted a bunch of user/user talk
pages, including Jakub Narebski's page with comments like "link spam",
"Inappropriate abuse of the Wiki as a messenger".

2) The same day, Amir (Amire80), an experienced wikipedia editor and
sysop, asked Johannes what was wrong about having a link in his user
page, a practice not only allowed, but encouraged in wikipedia, and
according to the default text in mediawiki, also in git's wiki. He did
it through user talk pages, which again is the way people communicate
wikipedia.

3) Johannes blocked Amir with the message "Inappropriate abuse of the
Wiki as a messenger, as well as abuse of the admin", and deleted
Amir's comment.

4) Amir proceeded to contact the mailing list explaining what
happened, and that if indeed that's the policy of git wiki (which is
quite contrary to most wikis), such policy must be written somewhere,
not allowing people to make those mistakes. Also, asking for his
account to be unblocked.

5) The thread developed into the pros/cons of user pages until =C5=A0t=C4=
=9Bp=C3=A1n
brought back the issue of the ban, at which point Johannes was Cc'ed.

6) Johannes defended his decision, arguing that people should somehow
know that user pages are not allowed, even though other people have
user pages (Jsarenik, Mike.lifeguard, etc.), even Jakub Narebski had
one at the moment Amir created his. He made it clear he wasn't going
to do *anything* regarding this issue, suggested that I take over his
task of monitoring the wiki, and that he was done with the discussion.

Note: I never accused Johannes of doing anything wrong, until he
denied to unblock Amir, which I think was clearly wrong, and even
worst, didn't have any desire to listen to the arguments.

7) At this point it was clear to me that Johannes had too much power
over the wiki, being the only admin, and that was specially worrying
since he had so low tolerance to accepting mistakes, therefore, on Aug
10 I started a new thread asking for a new (as in extra) maintainer,
and one of the arguments was his misbehavior.

Note: I consider raising a flag when there are problems to be a good th=
ing.

8) The same day Johannes accepted he made a mistake, and silently
unblocked Amir with the message "I overreacted and am sorry". He never
accepted any wrongdoing on the mailing list, nor expressed any desire
in doing anything to avoid these issues in the future.

I didn't "radiate" anything, the problem was there, I merely pointed it=
 out.

What we need is people that resolve the conflicts, not ignore them.

--=20
=46elipe Contreras
