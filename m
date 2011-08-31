From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] am: preliminary support for hg patches
Date: Wed, 31 Aug 2011 16:22:39 +0200
Message-ID: <CAGdFq_gerRi6REiU4HRqD4SgxBA3obMofAzw7HE4Qkxy82k7Sw@mail.gmail.com>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7v62lg6tr3.fsf@alter.siamese.dyndns.org> <CAOxFTcyqGCB3TcS2CmFuVXqrCP2H-1aBDv3JJVKrNp-Q8Zahmg@mail.gmail.com>
 <7vd3fo53oe.fsf@alter.siamese.dyndns.org> <CAOxFTczyNtyLWyXppj=0UW_zeD3t+rDtzt-vwqXkwvWOTdxi2g@mail.gmail.com>
 <7vwrdu3ka0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 16:23:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QylhO-0004P6-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 16:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab1HaOXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 10:23:20 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36371 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab1HaOXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 10:23:19 -0400
Received: by pzk37 with SMTP id 37so1388755pzk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f+Ykh/5ZPGjXuT43GSVml597+ZmyB/Ll4OkmmFRlUJk=;
        b=qlOjtm8O+1Pm9LO5Ypp4sqxY1DDO9KfbT6FVKHV8aEpn5UADk/Jt/CL3o+SMfM94ZQ
         X7WnejIE6ecEtDLGK5xsXmt2HgvU/9ZiV2t2W20Qd1qyHLx51Y8f+Hlbro3hEgHpss4t
         eAnSE+1sQKKGY4AaMLlVnzzUax1/SU71FGvfI=
Received: by 10.68.157.230 with SMTP id wp6mr577482pbb.428.1314800599073; Wed,
 31 Aug 2011 07:23:19 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 07:22:39 -0700 (PDT)
In-Reply-To: <7vwrdu3ka0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180472>

Heya,

On Tue, Aug 30, 2011 at 19:02, Junio C Hamano <gitster@pobox.com> wrote:
> These were exactly what I wanted to know. Thanks for experimenting.

And thanks for working on this, Giuseppe!

-- 
Cheers,

Sverre Rabbelier
