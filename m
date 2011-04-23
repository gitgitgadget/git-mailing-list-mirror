From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 00/23] RFC: Introducing git-test, git-atomic, git-base and git-work
Date: Sun, 24 Apr 2011 04:37:05 +1000
Message-ID: <BANLkTi=UDYT1hjpFT0LcgL6XvAGtTXMBLw@mail.gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
	<20110423091300.GC9206@m62s10.vlinux.de>
	<BANLkTinhjMtNc257NnOCZe6askr2i=4g6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 23 20:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDhhj-0002IY-OV
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 20:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab1DWShI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 14:37:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34841 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab1DWShH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 14:37:07 -0400
Received: by ewy4 with SMTP id 4so413443ewy.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zQe9s5WimU3+MG1HCgXQeaGEFL/1kbLhT1XkHl+38Og=;
        b=D0ryAQJgjX6T7WEvSsk1NJd9mGzlhN6vzMr0IIsrV26GIoHRVvIgWCxufiaBuk53wq
         J9DhTJPdC+Jkac8ebXAqxHgYyBSFCMkM2rYwtk7OJwQtEvOs3t5Hq7Fkb31CPmGJD6Ig
         sjYV6r0RcRRBz07d4m51ycYuWGeY5p5EmyNbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Fozyx6BJ4ZpFMtRoA661i38Igod88xIHXR3CWKitNZ/f1aSEWLk3sQVAP5ahchVa4z
         +zUEC+Ls125YMGFKGmiXn2K+QtIgkzeCb+MPlmRuQn1FndcGhOeHtza9faYJ7qGrA0kT
         /PveYpmk5dbpCf72pW2VHBzSN3HEejZpZ7+1o=
Received: by 10.14.17.23 with SMTP id i23mr630762eei.234.1303583826244; Sat,
 23 Apr 2011 11:37:06 -0700 (PDT)
Received: by 10.14.45.3 with HTTP; Sat, 23 Apr 2011 11:37:05 -0700 (PDT)
In-Reply-To: <BANLkTinhjMtNc257NnOCZe6askr2i=4g6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171986>

BTW anyone interested in trying git work can fetch the tag containing
this series from my github fork

Web link here:

https://github.com/jonseymour/git/tree/work-20110423

git://github.com/jonseymour/git, tag  work-20110423

jon.
