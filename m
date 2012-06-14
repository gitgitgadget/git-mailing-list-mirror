From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git rebase basics
Date: Thu, 14 Jun 2012 16:28:21 +0000
Message-ID: <CAMOZ1BusvR=dTSRaRxHiH_wpGnk86gBU4PRvJ=sjV8xHc4OXpA@mail.gmail.com>
References: <1339621152946-7561468.post@n2.nabble.com> <1339642794317-7561489.post@n2.nabble.com>
 <CAE1pOi3uXHcXm=fpH-e6pHyBTAACS7=KkdR9jQEuEjzoXy1w=A@mail.gmail.com> <1339689678486-7561538.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: lancelyons <llyons2@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 18:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfCup-0007vw-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 18:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab2FNQ2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 12:28:54 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35900 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339Ab2FNQ2x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 12:28:53 -0400
Received: by qcro28 with SMTP id o28so1105508qcr.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BWZlqzfH5Klio4NS90aGKGWsjKPgydmVyK0/8Y52lUs=;
        b=Yh6Pw3HTr8Gm4EZI8rSAAXRtLN1P+l0EFQtZDwtKEOBzQYgkogkGM2F5iZ47nzFeqv
         T3mXQRfCwakdqh8MlqZtDfCA4hSqAbFB35QMgx8oJ8+bxNgcdUmTvQGjnaIgkamEGKDB
         AOhnLcma/TD3PI/U0cCyjqkxJELCKIrUClEsKtBwBBsprFJRP/ufpZthhWVa03Ai50js
         cBXYzuFyKki0vomFg7O+Q9OStsxljvQjp80G9aSooiwBOCAQzwSc13FMC7KQ7Iq/+buT
         WX+TbOLsD9tpRTDyp5VB6qE2xpPdNaBnvrVJPip4acwKS2Z7KokkolnCs4RQ9bedrixj
         8HOw==
Received: by 10.229.134.212 with SMTP id k20mr1226923qct.83.1339691332349;
 Thu, 14 Jun 2012 09:28:52 -0700 (PDT)
Received: by 10.229.189.13 with HTTP; Thu, 14 Jun 2012 09:28:21 -0700 (PDT)
In-Reply-To: <1339689678486-7561538.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200017>

On Thu, Jun 14, 2012 at 4:01 PM, lancelyons <llyons2@cox.net> wrote:
>
> in my scenario =C2=A0what would git rebase origin master =C2=A0be doi=
ng?

I suggest reading the documentation for `git rebase'.
