From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Mon, 26 Apr 2010 05:28:30 -0500
Message-ID: <20100426102830.GB8841@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
 <20100426095206.GA31483@progeny.tock>
 <p2w5b9751661004260313kd1b809earb8d9fd8c4d09adef@mail.gmail.com>
 <20100426101911.GA8841@progeny.tock>
 <4BD56985.2030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 12:27:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6LXV-0005S6-Fs
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab0DZK1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 06:27:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62864 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab0DZK1i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 06:27:38 -0400
Received: by pwj9 with SMTP id 9so8164976pwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=exSLOgCIiGVbANlgtPfJheNCakAJtnJdlC05Oj2ht+E=;
        b=lZKoUJWV44pkOg7tTzz/Zv3FnPb/4F5kxcmEWCBJLrvkny1tHM3qAZOz6kpTD1DjIv
         +1b3saz9RoE0beWOsmErw+GVgkIQm4EfimX5R/JHb6kvaqmXyKbB5dhrJz02I33RN6Yk
         B+w5uZq9UP0dowRAtM6v9hNtV/J0Bf5wQN3xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CS+GTAg20XtggZ38VhKoJdW8yumIg6eg3Qi+ZbYnqmUiv7xRKsa9aMyh0AYpwKed1S
         SkGm31QaLIo9DPO42RmI7r1akxYMHgTN/6sdfgGprDaVUSZGhFdoXXLvf4vv/7ltAq8o
         mjG+JwPsbonfV+ri4MUye7vyONhcnpqJh+fzU=
Received: by 10.141.14.21 with SMTP id r21mr3277466rvi.144.1272277658026;
        Mon, 26 Apr 2010 03:27:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3034466iwn.2.2010.04.26.03.27.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 03:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BD56985.2030506@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145810>

Will Palmer wrote:

> I think the documentation / test changes are needed, but my
> own patch will probably go through several more revisions
> before it is ready to be included, which is why I suggested
> submitting your series separately.

Oh, I only took the uncontroversial part. ;-)

Jonathan
