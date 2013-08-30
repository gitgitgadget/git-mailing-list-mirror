From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 30 Aug 2013 15:28:18 -0500
Message-ID: <CAMP44s0Lv+HTFt6RxyRehfA_NpSPtnr2v4EnAO_vxQcOtQZLbQ@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 22:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFVIu-0006r0-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 22:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab3H3U2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 16:28:20 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:52714 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3H3U2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 16:28:19 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so1915077lab.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T/5gyto+Y+DQNWI6TP0MlItjDElWV0dXrxo3WCtwxDA=;
        b=GkDV2bPJ/WP4/I1JT/LPplBVkOO4UV2XaV9PigOiLQwtIKkGrFmzLfhs0MXG4cm8kO
         p0QN0JnDLU5u74yKyoFYFYHcJ/b1myxxTgWhHPxIWpUfPZHoGC5fuSvRL5/qYBDevhC6
         eWc4my02uLDMsViLxBIi5zdp4qhTSsBIctmqb/s4iaIwAFOdmhvpIkZiQILDBN5Gag37
         5MIU9gtmUbctl2GTwji1ay3hWmecEAPoudvsrz9tM04+Olq2JtJXGkX4bys0LQNd5WKX
         EfPCQqvLFgDFKxsc2+fZ6mOvdGNv7v0tcjddnC58lXAgNhmuT4HnSBxP2wpHS2mbUX35
         E8tA==
X-Received: by 10.112.51.166 with SMTP id l6mr9417340lbo.5.1377894498091; Fri,
 30 Aug 2013 13:28:18 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 13:28:18 -0700 (PDT)
In-Reply-To: <CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233468>

On Thu, Aug 29, 2013 at 2:57 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 1:37 PM, Junio C Hamano <gitster@pobox.com> w=
rote:

>> IIRC, when this was discussed, many non-native speakers had trouble
>> with the verb "to stage", not just from i18n/l10n point of view.
>
> Well, you recall incorrectly.
>
> There was *A SINGLE* non-native speaker that complained, about
> "stage", not "staging area", =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, =
and he even said
> he had already translated index/cache to "the commit area"[1].

Actually, not only did =C3=86var not have a problem with "staging area"=
,
but he told you this argument about i18n/l10n didn't make sense at
all, and you agreed:

http://article.gmane.org/gmane.comp.version-control.git/197371

In fact, all non-native speakers said they liked the term "staging
area", like everybody else.

So please enlighten us, which non-native speakers had a problem from
the translation point of view, and why does it matter?

--=20
=46elipe Contreras
