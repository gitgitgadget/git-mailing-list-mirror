From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git annoyances
Date: Fri, 11 Apr 2008 12:27:18 +0200
Message-ID: <01C218CC-9F7C-47C9-A47B-4127E0886DFC@wincent.com>
References: <20080409101428.GA2637@elte.hu> <20080411101516.GA31248@bit.office.eurotux.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 12:29:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkGUS-0003Qm-GS
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 12:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862AbYDKK1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 06:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758814AbYDKK1b
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 06:27:31 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:59780 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758841AbYDKK1b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 06:27:31 -0400
Received: from cuzco.lan (9.pool85-53-12.dynamic.orange.es [85.53.12.9])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m3BARJfX005004
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Apr 2008 06:27:21 -0400
In-Reply-To: <20080411101516.GA31248@bit.office.eurotux.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79270>

El 11/4/2008, a las 12:15, Luciano Rocha escribi=F3:
>
> Another inconsistency:
> $ git remote prune
> usage: git remote
>   or: git remote add <name> <url>
>   or: git remote rm <name>
>   or: git remote show <name>
>   or: git remote prune <name>
>   or: git remote update [group]
>
> show specific options
>    -n, --dry-run         dry run
>
> It took me a while to parse the "show specific options" properly.
>
> Wouldn't "specific options for show" be better?

Yes, or failing that: "show-specific options:"

Without the hyphen "show specific options" reads as "verb adjective =20
noun".

Cheers,
Wincent
