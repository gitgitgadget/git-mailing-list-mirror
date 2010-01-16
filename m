From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] Git Wiki Move
Date: Sat, 16 Jan 2010 01:44:44 +0100
Message-ID: <fabb9a1e1001151644n65577c99qe41327b66de28114@mail.gmail.com>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> 
	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> 
	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> 
	<fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com> 
	<4B510217.8060200@eaglescrag.net> <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com> 
	<4B51082B.5030508@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>, Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwt3-0002mF-Oy
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269Ab0APAv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758262Ab0APAv3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:51:29 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:45663 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174Ab0APAv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:51:29 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2010 19:51:29 EST
Received: by pxi12 with SMTP id 12so1297348pxi.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 16:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ngTsgdq6ne9KP9NpFo5bsFhb/fVkpTxa+mL4TXnCiws=;
        b=R4zUvWMz0y/GVVkyEdhfC56Mapk4bTxC2kg6cl3db+IcKYBtPWXYqKv3kGMmJPj2Tq
         8dmtsUwN5WO15hAcHl3yW3HioFte1DmPXXt95g9M3WikUFP2trBhRSTF2hLGCr6PNv/p
         ktVduviNg1ZCje2QS2Du5ueFhg2WZTWup8mHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dxtmSPxhQrCrfQd7gCj0eII1SaKjcDrlGxKd33a8i6Iy9sYQoSuAXJTTDhryyZKqkc
         Dmh8NkSNTxqUH2flWb33cBDTzvknGl9dCM2DDgpgj4w4OeudnXkKj+knfpfxAPDCJnQt
         0ldEabWfo4QlpRf3aWvCGW+Jm2GhQ5w/tTrD8=
Received: by 10.142.75.16 with SMTP id x16mr2124539wfa.155.1263602704062; Fri, 
	15 Jan 2010 16:45:04 -0800 (PST)
In-Reply-To: <4B51082B.5030508@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137175>

Heya,

On Sat, Jan 16, 2010 at 01:28, J.H. <warthog19@eaglescrag.net> wrote:
>> <!-- GitLink[git-name] Because Linus is an egotistical git -->
>
> Probably, should be fixed now, found it on GitBot too.

I guess you removed them rather than turning them in to comments
(probably due to MediaWiki's lake of comments)? Works for me, we can
figure out something else for gitbot. A regular text file that it can
slurp or something. We being Pieter perhaps (as he is the original author)?

-- 
Cheers,

Sverre Rabbelier
