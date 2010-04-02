From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v4] gitk: Use git-difftool for external diffs
Date: Fri, 2 Apr 2010 12:32:53 +0100
Message-ID: <201004021332.53562.markus.heidelberg@web.de>
References: <201003281259.06947.markus.heidelberg@web.de> <1270001399-26031-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 13:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxf5l-000845-0i
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 13:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360Ab0DBLbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 07:31:08 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35329 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351Ab0DBLbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 07:31:04 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7C4C015B26C8E;
	Fri,  2 Apr 2010 13:31:01 +0200 (CEST)
Received: from [91.19.8.199] (helo=pluto.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1Nxf5Z-00071x-00; Fri, 02 Apr 2010 13:31:01 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <1270001399-26031-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+jGyUjmU1xSt7QNYiQE4VXKkEY4yPhk4iT+Yw3
	JdZ33B8zBxNDQqcVP4kijtLYK7tIaHUH9FmhtGMK/XptJgXjGY
	s/w11Xe6Sp0EUfH0t8cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143807>

David Aguilar, 2010-03-31 04:09:
> This teaches gitk about git-difftool.  A benefit of this change
> is that gitk's external diff feature now works with read-only
> repositories.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>

Tested-by: Markus Heidelberg <markus.heidelberg@web.de>
