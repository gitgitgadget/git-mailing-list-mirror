From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: make tutorial a valid asciidoc article
Date: Sat, 21 Jan 2006 18:32:38 +0000
Message-ID: <b0943d9e0601211032t2d7e6ba9x@mail.gmail.com>
References: <1137142486.20073.77.camel@dv>
	 <b0943d9e0601160021t3b40ba3fp@mail.gmail.com>
	 <1137451068.5043.19.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 21 19:32:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0NXV-0000wL-Qd
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 19:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWAUScj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 13:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWAUScj
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 13:32:39 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:8658 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932236AbWAUSci convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 13:32:38 -0500
Received: by xproxy.gmail.com with SMTP id i30so457449wxd
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 10:32:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JXwv5rA6u+eg8tU2GvDcDLM56D0+zJD1mdmSIHmvp7cNWS6wsBXEugfyrj46uSDK/iF+yEOq2CJLuaMcY0yFeJrCZwI2ooWzvwDfz2stW0mgHuRE6R0gtYIBvODTgv5QqvXEBaS+/a44IiPf5+4cgJccPsN426HTpt7cKpM4z2E=
Received: by 10.70.90.19 with SMTP id n19mr3800652wxb;
        Sat, 21 Jan 2006 10:32:38 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Sat, 21 Jan 2006 10:32:38 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1137451068.5043.19.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15001>

On 16/01/06, Pavel Roskin <proski@gnu.org> wrote:
> Also, I've added a makefile.  It's not used by default, but those who
> want to read a tutorial, can generate it in html or pdf format.
>
> Here's the new patch.

That's great, thanks. I'll push it, probably tomorrow.

--
Catalin
