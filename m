From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 2/4] git-gui: add smart case search mode in searchbar
Date: Tue, 18 Oct 2011 14:33:04 +1100
Message-ID: <CAH5451n6pj9ybHSo=OLAw0wMLwqT_bCB76L8Jw3Cz6MP99y59A@mail.gmail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
 <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
 <CAH5451=jUS5PpMddwML36F-mH=pxxh8FsP2ZiRH2_NFBBy+Q5g@mail.gmail.com>
 <CAKPyHN2XQYrGDhfjX4G12Ggw6DuJasuYbLQvfbmikBbMezp4=g@mail.gmail.com> <87ipnngpsj.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 05:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG0Ql-0001g3-3I
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 05:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281Ab1JRDd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 23:33:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1JRDdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 23:33:25 -0400
Received: by bkbzt19 with SMTP id zt19so262050bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7Idr4J0OUHM2z/m1uxefQvbCIfdhkGZ4b5O/dcdwUxA=;
        b=ou9o6F74P7ye7tc20C21Y60nioDpbm9B3VlpknEZqS2061HHJWHeJZ6zFVfadeaTEH
         kVI0imPFEtmyjLPM6aWOgMDUtJh4DIvaIAuIxPvcz6TTEojRvzL7itGkN+eJ+2KXhLyo
         QayECeNxh72Mph9ExzGZNjK+v7pkejZ0osR7k=
Received: by 10.223.57.139 with SMTP id c11mr1139223fah.24.1318908804223; Mon,
 17 Oct 2011 20:33:24 -0700 (PDT)
Received: by 10.152.13.100 with HTTP; Mon, 17 Oct 2011 20:33:04 -0700 (PDT)
In-Reply-To: <87ipnngpsj.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183847>

I agree that clearing the field to reset case sensitivity is a nice
compromise between easily turning smartcase off (by typing a capital)
and easily turning it on again if you accidentally turned it off, or
decided you don't want it on.

In most cases you would think an accidental capital would be the first
letter typed anyhow.

Regards,

Andrew Ardill
