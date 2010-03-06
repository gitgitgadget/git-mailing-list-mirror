From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git fast-import/fast-export
Date: Sat, 6 Mar 2010 22:45:42 +0100
Message-ID: <fabb9a1e1003061345t7e261505q27453ff546e5463b@mail.gmail.com>
References: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com> 
	<7v3a0di87z.fsf@alter.siamese.dyndns.org> <fabb9a1e1003061105u70cf87b8h579fe154a24fb8f0@mail.gmail.com> 
	<20100306214321.GD2529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No1p5-0004xi-6C
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab0CFVqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 16:46:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36159 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0CFVqC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 16:46:02 -0500
Received: by pwj8 with SMTP id 8so3058687pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Sooz/XWNFukAvqpT4H6neAl6eMPejBrKDeMmjDadNFs=;
        b=nfKCU8v/BxfTMDpq6qPZtxtgYOBPOqyggov9nZcAeqZ3VVNqYKQKAXtYoiRt4bX7uo
         UcHG4WlRV/MxM5lQMQG/ICdKHddxSZZLjg8IQkvtuzO7iOxnxaKQdRHfDjAg0sBXUYem
         8KqEmHWB7MNmTQHFEm5YCDst9kh+yfu8ZgFnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hBpw3yKsBc6zpX94a8SirAk94eM3kGqLE9VpA/oko7bOyWN+PtEMSmBfinJKsG3pJ3
         +GdvZB//unVWT7oMxsFNowHPkj2/KtTQ6MTLJ55Ux/kUEhW78JZ0JASAfyBOXRbyG0wf
         +o3BPVHvzDURjiitxeDlK+iE6MbVWx/Jg+92s=
Received: by 10.143.25.9 with SMTP id c9mr1853746wfj.315.1267911962107; Sat, 
	06 Mar 2010 13:46:02 -0800 (PST)
In-Reply-To: <20100306214321.GD2529@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

On Sat, Mar 6, 2010 at 22:43, Shawn O. Pearce <spearce@spearce.org> wro=
te:
> Oh. =A0Yuck.

Why is that a bad idea?

> I guess I can give my blessing to relicense anything in fast-import
> that I've written from GPLv2 to GPLv2 or v3.

Ok, if nothing else we can use one of the earlier versions ;).

>=A0But as Dscho points
> out, there are many authors in even the parsing code. =A0You will
> need to get consent from all of them.

Right, I figured I'd first get an OK from the top N before spamming 40
people :).

--=20
Cheers,

Sverre Rabbelier
