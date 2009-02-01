From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/5] pack-check.c: minor formatting fix to match coding style
Date: Sun, 01 Feb 2009 09:52:58 +0900
Message-ID: <20090201095258.6117@nanako3.lavabit.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com> <1233313517-24208-2-git-send-email-gitster@pobox.com> <20090201064528.6117@nanako3.lavabit.com> <4984CA0C.7010703@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 01:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTQcB-0003tp-91
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 01:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZBAAxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 19:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbZBAAxo
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 19:53:44 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49304 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbZBAAxo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 19:53:44 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 7645AC7AE0;
	Sat, 31 Jan 2009 18:53:43 -0600 (CST)
Received: from 9262.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 2GM5Z56N7XIL; Sat, 31 Jan 2009 18:53:43 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=KmGz6VC2yiJbXNKpWylmGY16EwSGIGe0sq6vE3O9cQej0T8KtR6dGuzfW99YrC80xsyMk0QkJdOOBxhYMcNActzpXsScHazhCGyXYPPZB8RuzR2PY7MT8wn87nEMv5AHDGerHOhEzT3QYJh0wQelncDM+VXHuM0aNZ7JSKUCeOs=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4984CA0C.7010703@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107955>

Quoting Marius Storm-Olsen <marius@trolltech.com>:

>Nanako Shiraishi said the following on 31.01.2009 22:45:
>> What typo did you fix?
>
>-		err = error("%s SHA1 does not match its inddex",
>+		err = error("%s SHA1 does not match its index",

Ah, you are right. Sorry for the noise.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
