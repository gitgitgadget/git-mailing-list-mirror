From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Johannes misbehavior in the wiki, and a request for admin rights 
	(was: wiki "abuse")
Date: Tue, 10 Aug 2010 21:37:29 +0300
Message-ID: <AANLkTikEZ1DJSjSSE4o5XxMp_P0knT6e=874kRxkNypZ@mail.gmail.com>
References: <AANLkTinYqFMZe=ahgyaW-cYJXuBanvCU1A6AYVcVcrPB@mail.gmail.com>
	<4C613DFC.40006@drmicha.warpmail.net>
	<20100810123349.GA3921@kytes>
	<AANLkTi=4fhCMPGvO_zd_hmwXSG3wckJA8vTYwWFMEstx@mail.gmail.com>
	<AANLkTini7xKkncXxjv=p32PupR4W2FP3Rqm2atnsV1Q_@mail.gmail.com>
	<AANLkTinktAhPz_zp6Hf7yanxbn4FougPZwQj9msAXUvk@mail.gmail.com>
	<20100810161940.GF3921@kytes>
	<AANLkTin9Pnugt4NS_gwHoUsKvFur7CvowdR9Aqkuu6h7@mail.gmail.com>
	<AANLkTinNnchHQHvN6FnqF_E5NCVxQvE+T_gOD0z2-MUY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Hawley <warthog9@kernel.org>, git <git@vger.kernel.org>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Valeo de Vries <valeo@valeo.co.cc>,
	"Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 20:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oithh-0007n4-6Y
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 20:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541Ab0HJShc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 14:37:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33169 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932523Ab0HJShb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 14:37:31 -0400
Received: by bwz3 with SMTP id 3so2109646bwz.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yq4OsRPCdVtBhfxZCApOWd8tlkqqWegzEfX/Jf4sFb4=;
        b=lnyaij/48lwNMGzATSB4yoTkUZsjobPPQKKsu03af2oboQh13e7+K1rTVy8/mF3RTO
         pyBx3tA6vt7XeJCzn7iJvY5hWmmL/e3xWE/SeLqvCAyFoJzG3wnrgmtBbvVZ/U8VSRuI
         KnHENdFEWe+M87YMjkICx8f/dcYAYmyNpeIO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XkC6HoyqJijI6ABJOqVfSTl8S8H425znAyauyVCiwiWyiI/L4rokoPNfOb91lfIITY
         O0R1mo/bIenGoPRpALXQfFfXosJr96bEQUqTDPCWhj2RGBLN7aXIbnHRsHiglhqCsYLR
         q4Bl2gpGC7dnKJnC3MbOYWiPzABXHM+fSYOTY=
Received: by 10.204.178.67 with SMTP id bl3mr4438183bkb.161.1281465449908; 
	Tue, 10 Aug 2010 11:37:29 -0700 (PDT)
Received: by 10.204.122.143 with HTTP; Tue, 10 Aug 2010 11:37:29 -0700 (PDT)
In-Reply-To: <AANLkTinNnchHQHvN6FnqF_E5NCVxQvE+T_gOD0z2-MUY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153136>

On Tue, Aug 10, 2010 at 9:03 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Tue, Aug 10, 2010 at 1:54 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I'm not going to go into details as why I think no warning was issue=
d,
>> just that we need this:
>> https://git.wiki.kernel.org/index.php/WikiIdeas#Allow_users_to_see_d=
eleted_pages
>
> Keep in mind that 99% of the unwanted crud that gets posted to a wiki
> is spam and absolutely doesn't deserve a fair warning before it gets
> deleted. =C2=A0Just based purely on the list of usernames that was po=
sted
> earlier, it looked mainly like spammers to me.

Sure, if it's clearly spam (as in created by a spam bot) it doesn't
deserve a warning, but as Amir's case demonstrates, not all of the
deleted content was like that.

> If you want to implement a huge big process before deleting/banning
> users, you'll want to be sure what you're getting into.

There's no big process: warn before you ban if the user is not a bot. S=
imple.

> I personally don't think that anything that was done originally was
> necessarily wrong, or that the wiki management itself needs to be
> fixed. =C2=A0If it were possible for people to simply look at deleted
> pages, this thread would have been "Hey, you deleted me and it was
> unwarranted!" -> Someone checks it out -> "No, it was warranted, don'=
t
> post swearwords to user pages" -> "Oops, sorry" -> Unbanned.

That can't be right because the reason wasn't that, but "Spamming
links to external sites", and that hasn't even been decided yet.

But if that's what you meant, here's a more likely case:
1) Join the wiki
2) Fill the user page as requested
3) Get blocked permanently
4) Give up

Just by having a *temporary* ban instead of a permanent one (when the
user is clearly not a spam bot) would not have only decreased the
thread, but it wouldn't have happened in the first place and wouldn't
have caused the case I just mentioned.

> The thread went on as long as it did simply because verification was
> impossible.

No, it did because there was no admin willing to fix the problem: unban=
=2E

--=20
=46elipe Contreras
