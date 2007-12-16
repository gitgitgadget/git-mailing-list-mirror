From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 23:26:47 +0100
Message-ID: <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
	 <fk2juf$t25$1@ger.gmane.org>
	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
	 <fk2p0f$961$1@ger.gmane.org>
	 <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
	 <fk2q1f$bbh$1@ger.gmane.org>
	 <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>
	 <fk3153$rtb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Abdelrazak Younes" <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Sun Dec 16 23:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J41x4-0007ek-9b
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 23:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760683AbXLPW0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 17:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760238AbXLPW0t
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 17:26:49 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:14078 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897AbXLPW0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 17:26:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1635720rvb.1
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 14:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=et3IM0Qr01eIns/Rpck4xsy6QgQOQBi8uhEmu2kQyp8=;
        b=EMCGu9qFvlzua68DaSGC4Hy0CL6/6ZGtsyz/BDkdMytKma7U+aMaQzpJ3H1TXYSbz/3Pw0wl+pyP/OyddstrlUgyXZR41ma57GmayHGDwlZBnG0u/5ejAOQCyacBDH8ii3CbF3zDpCdM+DxT2UKVvfyQ5SwZBNhkQIOLj4mPlN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6wX0s32JKqpaT1uTkTyV9GXsM2GDy/q5ya3TVPAGF+EmzMIe5t1Z1Z2zyozV/ds23kX+wpwautjuisnV9Nij9r6d0FprjqKnmyTVf55Z8McLHu7B/YKD75zPoo4kQl3tH6yk1D5X6ssiMH+zHfc1lxgFl2B1q3m4SNHc20Or5E=
Received: by 10.140.134.15 with SMTP id h15mr3502557rvd.48.1197844007723;
        Sun, 16 Dec 2007 14:26:47 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 16 Dec 2007 14:26:47 -0800 (PST)
In-Reply-To: <fk3153$rtb$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68497>

On Dec 16, 2007 12:11 PM, Abdelrazak Younes <younes.a@free.fr> wrote:
>
> Actually you might prefer to just use the LyX dependencies package that
> we provide for Windows developers, it contains Qt. I paste here the
> relevant part of our 'INSTALL.Win32':
>

Thanks, I've tried it but without success because I need MSVC 2005
installed, and currently is not.

Anyhow for now I have produced a version with mingw that seems more or
less to work, when I have a bit of time I will install MSVC 2005 and
try if with that compiler is better...

Thanks
Marco
