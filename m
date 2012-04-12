From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #04; Tue, 10)
Date: Wed, 11 Apr 2012 23:35:39 -0700
Message-ID: <CACz_eycyOFmPqsJiB+1OvM4GwpOi-xD0RoxGvn3SJiwqVKS4mw@mail.gmail.com>
References: <7vty0rnrwy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Zbyszek Jedrzejewski-Szmek <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 08:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIDdB-0006ja-Qn
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 08:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761501Ab2DLGfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 02:35:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54130 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415Ab2DLGfk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 02:35:40 -0400
Received: by iagz16 with SMTP id z16so2372849iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tgdBO1WP1PAF27rxPQ5HDXdgXW5GBAZVOZ458PvPa+g=;
        b=nP5tckSe1Hv8ggJNVP6hx/jZIMNO5cdPUY9fh3VNVPLW9HKibd1qGFI1PuduTOPnNx
         WHn3bZT/77ULA1kLciYUDaK4JT0sjNs9V3+hWkidl3pgYcp856WrKVY++gx2qZfp2tQh
         11NwkGhP/7P+81Rjdz33qoS0AfevDG5/tDvJQ5SdjdEMEZxA4Bh8ERAEljC7rfJjfoyU
         DT8mSh/8MRa2p8bOVE8uEIjLFmE1YQfpc/47FhXorkzI/CxWKuEzFhgnFk+EQXBLfOIQ
         xziziy26zNhO1SpuNkUEcbC54YLxpjitYHWUDSjqcOYTpZV3KjuLNY55WueI/XTSgYad
         5lMw==
Received: by 10.50.212.3 with SMTP id ng3mr1287728igc.39.1334212539831; Wed,
 11 Apr 2012 23:35:39 -0700 (PDT)
Received: by 10.64.73.138 with HTTP; Wed, 11 Apr 2012 23:35:39 -0700 (PDT)
In-Reply-To: <7vty0rnrwy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195301>

On Tue, Apr 10, 2012 at 15:27, Junio C Hamano <gitster@pobox.com> wrote=
:
> --------------------------------------------------
> [Stalled]
>
> * lp/maint-diff-three-dash-with-graph (2012-03-20) 3 commits
> =C2=A0- t4202: add test for "log --graph --stat -p" separator lines
> =C2=A0- log --graph: fix break in graph lines
> =C2=A0- log --graph --stat: three-dash separator should come after gr=
aph lines
>
> With a review from Zbigniew, I have been expecting that this would be
> rerolled, but that didn't happen.
>
> Will discard shortly unless nothing happens.

This weekend I'll post an updated version of the patch Zbigniew reviewe=
d.
