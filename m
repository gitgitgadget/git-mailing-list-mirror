From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Sun, 08 Jan 2012 15:01:11 +0900
Message-ID: <87vcomravs.fsf@catnip.gol.com>
References: <201201072059.23074.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 08 07:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjlos-0003mI-Jv
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 07:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2AHGBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 01:01:16 -0500
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:40229 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab2AHGBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 01:01:15 -0500
Received: from 218.231.234.50.eo.eaccess.ne.jp ([218.231.234.50] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1Rjloe-0002ZC-Od; Sun, 08 Jan 2012 15:01:12 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 61A6FDFE1; Sun,  8 Jan 2012 15:01:11 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <201201072059.23074.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sat, 7 Jan 2012 20:59:22 +0100")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188095>

BTW, about the names, e.g. "darwin.c" etc -- is this code actually
Darwin-specific, or simply Systems-that-happen-to-force-decomposed-
unicode specific?

If the latter, maybe more generic names might be better.

Thanks,

-Miles

-- 
`To alcohol!  The cause of, and solution to,
 all of life's problems' --Homer J. Simpson
