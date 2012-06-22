From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] Documentation: Fix misspellings
Date: Fri, 22 Jun 2012 16:09:16 -0400
Message-ID: <CAA3EhHK7uTncri85DhaAk1dNF1c3=1V76vyav5hh5PzywPAE1Q@mail.gmail.com>
References: <1340389329-18325-1-git-send-email-muhtasib@gmail.com>
 <7vehp7p28d.fsf@alter.siamese.dyndns.org> <CAA3EhHLUj0Ft5nuMpC8vqzx7d2B0YPr+crp2oaANFGKqWx0stQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:09:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiAAn-0004BF-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab2FVUJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 16:09:38 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34781 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2FVUJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 16:09:37 -0400
Received: by vbbff1 with SMTP id ff1so1057824vbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8lzjM8rXvI1Tv5ZjUs6A7xKG/wa5xKhqE+22ALQJoek=;
        b=y0gUV1Cht9mz/gFZGNyXZi7TxMzboFuF7wWyBF3siEXXe0vOdFdNvnKrdaYjSPlt3e
         n8pSUd41VykKRgty8djSvXkj+mJgxGc/00fTboq9HT9jTtEyexiY8PsLUB6A8hUO32U7
         TSJC8cfx018j08cn3tSJAeLnk8J1WDkSRSERk3sY2oUJqKme3gsYuOghbwcQCjjZL9zu
         sBDwk1X+dGH1IEfwi0DhXp6lvwB5ypvL2CK1M/lR/aEzS0ao2WxRSPcTJ7zVdg6Icb6P
         9oM326BBYo/E1h1e9XnFOspwXy9lKeF+5bsPmkMn/4On6z2u47GSxcsXOPuGJaf3ipHR
         5pWw==
Received: by 10.52.155.193 with SMTP id vy1mr1391190vdb.123.1340395776355;
 Fri, 22 Jun 2012 13:09:36 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Fri, 22 Jun 2012 13:09:16 -0700 (PDT)
In-Reply-To: <CAA3EhHLUj0Ft5nuMpC8vqzx7d2B0YPr+crp2oaANFGKqWx0stQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200464>

I meant to type "current one" instead of "correct one".

I just submitted an updated patch that contains them all.

On Fri, Jun 22, 2012 at 3:43 PM, Leila <muhtasib@gmail.com> wrote:
> Ok, I'll fix them too. Should I submit another patch or just update
> the correct one?
>
> On Fri, Jun 22, 2012 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks; "git grep overriden" finds a few more hits in t/, which we
>> may also want to fix.
