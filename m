From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 7
Date: Sat, 5 Sep 2015 23:04:05 +0200
Message-ID: <CAP8UFD06wykJeVYZwUZWOZz1Qe-HvXNY8-sd5dmnjsZnDXGsMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schauer <josch@debian.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 23:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYKdG-0001Mm-Uu
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 23:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbbIEVEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 17:04:11 -0400
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34502 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbIEVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 17:04:08 -0400
Received: by lbnt2 with SMTP id t2so3103499lbn.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=d9pUOQzN7pWQYoIIQcEmkdwZrXtM9Vb2rENcLX3yXX0=;
        b=Axsh2fOSpzdndV9SxEoRdU8hPSKz21gTEGCX7g/hjkqf/DBKOgXaHZ/fzRf6lt/SDk
         i3rnffB4vO3sP0I/RRg1nEhXXsZyD6xdHCMLMl1mNAh7KAk1LrK8Kp0xREkIInUVTgi2
         8WV4TYYaNrsx9sMWw6NSx1HWU3/Hr+9Ud8ek3Roj9HEKM9nDbDnGaXZxwGTYlj0/Ts+i
         sp4PwczUa+tIbQNkhmAzUEDkqylTpLcNXn2m0Y/97PH6fl5kW7GdyrT7jRofQfodahEj
         llxQzVW0R2Nmbb+fYZyj5jTlj1/M2oeXOtdws/GIeoDx27qPAo9p13FZ3clb3wBV8OkQ
         l6wQ==
X-Received: by 10.152.7.106 with SMTP id i10mr10072666laa.114.1441487045600;
 Sat, 05 Sep 2015 14:04:05 -0700 (PDT)
Received: by 10.25.135.7 with HTTP; Sat, 5 Sep 2015 14:04:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277411>

Hi,

A draft of Git Rev News edition 7 is available here:

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-7.md

Everyone is welcome to contribute in any section, like Matthieu
already did, either by editing the above page on GitHub and sending a
pull request, or by commenting on this GitHub issue:

https://github.com/git/git.github.io/issues/94

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
the 9th of September.

Thanks,
Christian.
