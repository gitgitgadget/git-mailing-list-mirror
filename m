From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate() instead of unsigned
Date: Sat, 24 Jan 2009 06:22:58 +0100
Message-ID: <200901240622.59069.markus.heidelberg@web.de>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 06:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQazz-0006SJ-PV
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 06:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbZAXFWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 00:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbZAXFWj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 00:22:39 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56871 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZAXFWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 00:22:39 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 017F9F6F9203;
	Sat, 24 Jan 2009 06:22:38 +0100 (CET)
Received: from [89.59.96.236] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LQayb-0005vo-00; Sat, 24 Jan 2009 06:22:37 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+NoPF82yy6A3i7AfcEItXEeTl9i00ES06+QAg6
	hVHJDnfqIftq62kLunHmWKpBh2Ko+1bjQ0QXalWH5F0tPcG2ac
	rib16jfMqU83mDyo9ivQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106955>

Tim Henigan, 23.01.2009:
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>  mode change 100644 => 100755 builtin-gc.c
>  mode change 100644 => 100755 builtin-reflog.c
>  mode change 100644 => 100755 builtin-show-branch.c
>  mode change 100644 => 100755 cache.h
>  mode change 100644 => 100755 date.c
>  mode change 100644 => 100755 parse-options.c
>  mode change 100644 => 100755 reflog-walk.c
>  mode change 100644 => 100755 refs.c
>  mode change 100644 => 100755 refs.h
>  mode change 100644 => 100755 revision.c
>  mode change 100644 => 100755 revision.h
>  mode change 100644 => 100755 sha1_name.c

Oops
