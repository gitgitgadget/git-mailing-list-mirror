From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 22:36:31 +0100
Message-ID: <20120210223631.17f4edad@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<20120210202008.GA5874@sigill.intra.peff.net>
	<20120210222916.2721e9e6@gmail.com>
	<20120210213209.GA7582@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:36:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvy94-0000Zf-1v
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759022Ab2BJVgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 16:36:37 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36830 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2BJVgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 16:36:36 -0500
Received: by eaah12 with SMTP id h12so1063292eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 13:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=r+Yuy/ZxhFc/GpQTPNvHMLEh4AT/tFBwNd8BgC/5JbA=;
        b=CL1qGgK2KIc+9t51zKEiydyd8RVdHSwJRNhLFixfIQy/YtfuCCdMfGRw4yly9Bdzfw
         uZlreUnQKGZv/Fz071aiNzuYxZU60y42EA0JrLKNE5MDnor/wyf+CUgdvmFPC74bPL45
         tgd3iJ1I96JHWi0vSik6dw7PO2Tqv5fH67NiY=
Received: by 10.213.16.148 with SMTP id o20mr596039eba.45.1328909795316;
        Fri, 10 Feb 2012 13:36:35 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id v51sm26791437eef.2.2012.02.10.13.36.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 13:36:35 -0800 (PST)
In-Reply-To: <20120210213209.GA7582@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190461>

Jeff King <peff@peff.net> wrote:

> On Fri, Feb 10, 2012 at 10:29:16PM +0100, Micha=C5=82 Kiedrowicz wrot=
e:
>=20
> > > Have you considered contributing back the enhancements to
> > > contrib/diff-highlight?=20
> >=20
> > Yeah, I did. In fact, at work I have a hacked version of your
> > diff-highlight that supports multiline changes and I use it every d=
ay.
> > But I just couldn't make myself fix your long README and send a
> > patch :).
>=20
> Heh. Why don't you show your hack in the meantime. Even if the code i=
s
> ugly or the documentation is missing, I'd like to see the output, and
> maybe we can fix those other things together.
>=20
> -Peff

Then just give must few minutes.
