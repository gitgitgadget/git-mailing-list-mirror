From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Clean termination of remote-helpers (was Re: [PATCH 2/2] Add a
 remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 17:00:44 +0200
Message-ID: <CAGdFq_giHLBgGOLDhj3zuxV0pnJ8twDfY7DD9ckfp4s4O7E8_g@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <vpqd3flzrow.fsf_-_@bauges.imag.fr>
 <CAGdFq_gSpFm8D1qHs5smUgsqyZXRjw73QFCCkBjTi0n4pwzmHA@mail.gmail.com> <vpqty8x3a5b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 31 17:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QymII-0001W9-6d
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 17:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab1HaPB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 11:01:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61767 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130Ab1HaPBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 11:01:25 -0400
Received: by gya6 with SMTP id 6so614045gya.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9RC0yFU2tW8A012uVDDMnadvV4jXUPLqmEeZe5fv5m0=;
        b=hG5mhRjT6iWwX5pjC4XI5qot1cxf81qbxGE0CJPDFnIfYIhlc2ryyR8lf/X0Qqf3pP
         sm24jf2CXmSYiHTQNWmt0LRD+xjmPooyznMqv1buHusxJCLrf9TE/NwGzIZnJiHYFeb1
         8DXn2JBYOZrwEFUAEXGEUj7FWyFeEHFacTJzw=
Received: by 10.68.56.199 with SMTP id c7mr665939pbq.495.1314802884098; Wed,
 31 Aug 2011 08:01:24 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 08:00:44 -0700 (PDT)
In-Reply-To: <vpqty8x3a5b.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180474>

Heya,

On Wed, Aug 31, 2011 at 16:53, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> So it seems the only bug I've found is insufficient documentation. A
> patch follows.

Yay! Thanks :)

-- 
Cheers,

Sverre Rabbelier
