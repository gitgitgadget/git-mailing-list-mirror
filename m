From: Johan Herland <johan@herland.net>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Sat, 19 Apr 2014 03:13:18 +0200
Message-ID: <CALKQrgdv3xN78dvFNzR7K7dWMP-brG7r-OoHHMAus4pskmizmw@mail.gmail.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 03:13:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJqh-0005fI-U0
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 03:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbaDSBNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 21:13:37 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:49583 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbaDSBNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 21:13:34 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WbJqW-0007xs-J4
	for git@vger.kernel.org; Sat, 19 Apr 2014 03:13:32 +0200
Received: from mail-pd0-f171.google.com ([209.85.192.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WbJpB-0004j6-2q
	for git@vger.kernel.org; Sat, 19 Apr 2014 03:12:09 +0200
Received: by mail-pd0-f171.google.com with SMTP id r10so1897135pdi.16
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 18:13:18 -0700 (PDT)
X-Received: by 10.68.100.1 with SMTP id eu1mr25029424pbb.36.1397869998641;
 Fri, 18 Apr 2014 18:13:18 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Fri, 18 Apr 2014 18:13:18 -0700 (PDT)
In-Reply-To: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246498>

On Fri, Apr 18, 2014 at 9:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> An early preview release Git v2.0.0-rc0 is now available for
> testing at the usual places.

This is supposed to have _all_ the v2.0 topics, correct?

I'm unable to find the commit that actually _changes_ the default
prefix for "git svn" (as announced in Documentation/git-svn.txt and
the release notes for v1.8.5 and v1.9.0).

For reference, it was posted as patch 3/3 back in October:
http://thread.gmane.org/gmane.comp.version-control.git/232761/focus=235900

Very sorry for not discovering this earlier.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
