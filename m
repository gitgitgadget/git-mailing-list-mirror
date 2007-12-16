From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 10:05:37 +0100
Message-ID: <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
	 <fk2juf$t25$1@ger.gmane.org>
	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
	 <fk2p0f$961$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Abdelrazak Younes" <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Sun Dec 16 10:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3pRl-0005Jm-Tb
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 10:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbXLPJFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 04:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbXLPJFj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 04:05:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:52029 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbXLPJFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 04:05:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1476349rvb.1
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MpYY1X4xVwDjViuNFtmPx9M3lsZn3uwEpOBw1tw98qA=;
        b=ragVkpHEwLa90ntKF+olQpsCVZYlOvtN1jwq1KUF/fRuw76Loo3W5AI0agHFVoiohvHgRPBhp+6gHXnBW4r5pQIDkNUIn7exjrd5mvFBNjypMeE2cVxQXB2d+2IltQmlffjHe5pZvhnmU4nUidK13ka/x4yoJa2UnOdK1rReNdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VgePHRqI6+kVuz0SEGe7p1fNiZY4fbrP2JeKCjxmzGXUnP5D4/hYRQokpLK4/wmo2TPaaDG3sdQPic2U8uDT3Mt0RZazO/njo9hSKQ2knMyKnVQ/1BvJpXa6yytN0yUgzwHWfG4SrW0zaF9KGC/bWeSCmSfHHBceNWmK8CQS0cg=
Received: by 10.140.125.21 with SMTP id x21mr3092244rvc.234.1197795937474;
        Sun, 16 Dec 2007 01:05:37 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 16 Dec 2007 01:05:37 -0800 (PST)
In-Reply-To: <fk2p0f$961$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68447>

On Dec 16, 2007 9:52 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
>
> Hum, I can't imagine this is the reason, it might be for another reason,
> most certainly the static compiling.
>

Static compiling is indeed a highly suspect. I'm now compiling as
shared libraries, we will see...

>
> Well, for the LyX project we used to use and distribute the patched
> version of Qt in order to compile it with MSVC. Now, since Qt4.3.2 the
> MSVC compilation support is enabled in the official release so you don't
> even have to patch it anymore. I can send you precompiled dll if you
> want.

Sorry for the stupid question, but, what ddl ??

Marco
