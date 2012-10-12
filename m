From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: A basic question
Date: Fri, 12 Oct 2012 06:28:49 +0530
Message-ID: <CAMK1S_iMxju7Q7WSExw2nXqP0KqOEXFaYTMsmicYHMu6RAT-wA@mail.gmail.com>
References: <001501cda711$8ab6f0a0$a024d1e0$@com>
	<1349897794.32696.15.camel@drew-northup.unet.maine.edu>
	<002801cda7d7$4792c260$d6b84720$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Drew Northup <drew.northup@maine.edu>,
	Skot Davis <skotd122@gmail.com>, git@vger.kernel.org
To: Jim Vahl <jv@wmdb.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 03:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMTi3-0008SD-8b
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 03:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498Ab2JLA6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 20:58:52 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33197 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393Ab2JLA6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 20:58:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1731564lbo.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CxIFhGgEXuVIWXjhvxzZafyqmzj10Mi4SGJpkOi6aSU=;
        b=DfyMeVTyQQp+NklSzhOQQlGaMCvSsKHs3eQY0iAcuxqFEwm1mVcAqTu97Bp2rGpf1s
         NzZ44qepohMwL3kpLgS/81mryqgjP1JGEXiotTJpiID2bsOsqSMYpLEeFsIwx4uTnTRp
         fanjzbsvPnyY0TvnuNTX0R9ggghAlk8dfcn5spKTGrILfLehFqVpL15bNhvDh8qgXv3r
         GWQcCBlytN+Al0dkBrBSju80H6dqSHV47J91D4OPM6TRQxAYdjp36griptsaUSF9qasT
         zJZlzhlBKPyqOojbdzfpMU/dVj2Vw8rsYybvMzM33g8oKWYD8HUQ0IeZS33KdBN2iAcr
         TPJg==
Received: by 10.112.100.129 with SMTP id ey1mr1035836lbb.10.1350003529872;
 Thu, 11 Oct 2012 17:58:49 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Thu, 11 Oct 2012 17:58:49 -0700 (PDT)
In-Reply-To: <002801cda7d7$4792c260$d6b84720$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207524>

On Thu, Oct 11, 2012 at 11:08 PM, Jim Vahl <jv@wmdb.com> wrote:
> Drew,
>
> Thanks for responding to my email!
>
> Yes, I did read most of the Book, although I admit that I skimmed over some
> of the more technical parts.  There is still a key part of how git is used
> in a commercial environment which I don't understand.
>
> When we release a new version of our product, it is comprised of over a
> hundred files.  Some of these files have not changed for years, and some
> have been revised/fixed/updated quite recently.  But what is key is that all
> of these components have passed a review and testing process.  A very
> important piece of information is what revision of each file made it into
> the release.

I'm afraid I don't have anything to add to what was already said but I
can't resist asking: are you coming from clearcase?
