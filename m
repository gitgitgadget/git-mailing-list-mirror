From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: Sporadic BSOD with msys git?
Date: Thu, 29 Jan 2009 13:18:03 +0100
Message-ID: <46d6db660901290418w6e022b6et32ac29654974c290@mail.gmail.com>
References: <20090129115442.6ce311f8@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 13:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVrp-0005vZ-Gt
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 13:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZA2MSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 07:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZA2MSF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 07:18:05 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:56854 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZA2MSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 07:18:04 -0500
Received: by mail-ew0-f21.google.com with SMTP id 14so4021975ewy.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 04:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VvJWCQLImMwwlHggoRqJFVheE53xodLbc80C0Y3WLEI=;
        b=ju5eJvWJCqHovw8gGRO0UZP54di+mQB+BgNQzFKooe/WBow038l0H+bdW7MfLg1VWM
         7rER0nYPtRp8jUFcE/GPBaWFhws8L/BSF+Bh8vtCSpzqtmAx54pfuWOofA6P/F4iUX4A
         Lg/VWoPZV9f6Z9fkR48whPwYTOHDxw0l23BAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y84VlnMYqH+KxOpgWCScg32Jnjfny4a1l/KxE66MDtFFRdoXusRsmsdJQA8lWprP2h
         gI7ov6bG0YCJi0x7Rcf+AMZgeRFKkDkMozd5PtngYItWakRhbyZVil27XOHlFovTqtLS
         6Za3+W0+1c2P4gfyx9nd4V/o7SKWeK+uz5shg=
Received: by 10.103.198.15 with SMTP id a15mr5449muq.60.1233231483652; Thu, 29 
	Jan 2009 04:18:03 -0800 (PST)
In-Reply-To: <20090129115442.6ce311f8@crow>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107667>

On Thu, Jan 29, 2009 at 12:54 PM, Mark Burton <markb@ordern.com> wrote:
>
> Hi,
>
> I occasionally have to use Windows (XP under VMWare) and thought I would try
> out msysgit so I installed the recent version (1.6.1). For what I was
> wanting to use it for, it worked OK.
>
> However, I then started getting crashes when using the Windows explorer. I would
> click on a folder to look at its contents and, whammo, Windows would crash. It
> just happened every now and again, not all the time.
>
> I uninstalled msysgit and now the crashes are not happening any more. Not
> exactly conclusive evidence but, perhaps, there's an issue there?
>
> Has anyone else seen this?
>
> Cheers,
>
> Mark
> --

no, never on virtual machines, nor on real systems (xp+vista).

could you try on a freshly installed version of xp inside a vm ? maybe
also provide please the release details (os, msysgit, etc...)

a test case allowing to reproduce with predictability would be also welcome...

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
