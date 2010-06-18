From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Correct typo in gitweb's Makefile's CSSMIN rule
Date: Fri, 18 Jun 2010 17:05:31 -0400
Message-ID: <AANLkTim8vle-DAkqgv2hZBtjVwddWaKB3zrrYUoc6pW5@mail.gmail.com>
References: <1276894885-2112-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 23:05:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPikx-0002NT-Pm
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 23:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0FRVFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 17:05:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40647 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0FRVFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 17:05:32 -0400
Received: by iwn9 with SMTP id 9so1452685iwn.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=wNAxA9bikpHpemFlvjPybrb/WHskQW2X6C5CtI6Bg5c=;
        b=UYx+AtflPvWi3j7zm6QSzIomhH/R4OO7AHbff/AJ1+CAy8Pl8cPRYMQK/YVp5VozM8
         dflh3xLaJ2w3jLI6msQ8mb//QrkLbEBaRJVrSP6tWkmVBMBTvkBQ+r/D1tzjLtmv/Urn
         dEyZ0OWfphNjlS7D/4JovyiH3TL3QeGORizGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CXe8oYdVOHUyfZTWz9EqL2z8TTsAKODoB+NwVPwalgq0KbtIb+t2m+++ktrESlwtof
         ySdOZTQZ5+G7Jr0P0hqyBNQeO6r9k2c/nhh5p15me8g1CUC7Pu/FXopbZe24mgZPUwMx
         sxa0t5P8pMrx6Gai7EpMtW7NZQwT2gggwLFD4=
Received: by 10.231.176.74 with SMTP id bd10mr1760459ibb.38.1276895131559; 
	Fri, 18 Jun 2010 14:05:31 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Fri, 18 Jun 2010 14:05:31 -0700 (PDT)
In-Reply-To: <1276894885-2112-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149364>

> Correct typo in gitweb's Makefile's CSSMIN rule

Excessive possessives in subject? Junio, feel free to adjust the
subject before applying to something like:

Gitweb Makefile: fix typo in gitweb.min.css rule

:-)

j.
