From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 06 Aug 2010 01:18:05 -0700 (PDT)
Message-ID: <m3vd7ooeru.fsf@localhost.localdomain>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com> <4C5B2F2E.4050709@gmail.com>
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
	<AANLkTimdZrdLFEit7ecXkEcGdfevbvp2TU1ekHddUHwf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 10:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhI8B-0003mv-0e
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 10:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935438Ab0HFISN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 04:18:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63639 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933008Ab0HFISK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 04:18:10 -0400
Received: by fxm14 with SMTP id 14so3629710fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=4Q4xNZTOsXpVYnQlAj/QLxS4h1WAiWvUUTgp8ktCEG0=;
        b=PDpqlTPSWH1jwIknmMp6hyrOd0Dy+OCCuFRgcx54lqbQL049Ibzl+N6WvuCfhq3cW9
         83M9x+w6RrcrcmtJY/z3MIFansR6sgJ8970fj4WCUPrqO1GbotM9HhHOWKPOJfK3xEcc
         Z8Ye5h3HD9NwlYny803UXRvwUcHUkxBuH+AnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Af3zf/KTAq0FKSxFy6eTWqGAWem+6tq+M440G2OjPRaoZ5/dcWIlYjdJV7dAyAGqpC
         2YrFI2afMJ1Dq53BzSLoVCurX9YUe/vshPzKI+w3POeYG5sGxmiZBes8+f0WvfivYWYn
         /Put/o6oFaGxak9f+WJqdE9azp2ZmNmwgatP8=
Received: by 10.223.120.82 with SMTP id c18mr12278068far.69.1281082688826;
        Fri, 06 Aug 2010 01:18:08 -0700 (PDT)
Received: from localhost.localdomain (abvc105.neoplus.adsl.tpnet.pl [83.8.200.105])
        by mx.google.com with ESMTPS id l12sm504012fan.25.2010.08.06.01.18.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 01:18:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o75Mof2h007707;
	Fri, 6 Aug 2010 00:50:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o75MoUvX007703;
	Fri, 6 Aug 2010 00:50:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimdZrdLFEit7ecXkEcGdfevbvp2TU1ekHddUHwf@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152770>

Sverre Rabbelier <srabbelier@gmail.com> writes:
> On Thu, Aug 5, 2010 at 16:58, =C6var Arnfj=F6r=F0 Bjarmason <avarab@g=
mail.com> wrote:
> > On 32bit:
> >
> > commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
> > Author: The Philadelphia Convention <>
> > Date: =A0 Wed Dec 31 19:59:59 1969 -0400
> >
> > On 64bit:
> >
> > commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
> > Author: The Philadelphia Convention <>
> > Date: =A0 Mon Sep 17 13:00:00 1787 -0400
> >
> > It would be useful to turn that into a TODO test for Git.
>=20
> That's bad, if we can't store a particular date we should do somethin=
g
> about it, not just silently underflow.

We can *store* it without problems, the problem is with
*interpretation* by porcelain (and some plumbing).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
