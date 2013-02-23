From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Spelling fixes.
Date: Sat, 23 Feb 2013 19:23:01 +0100
Message-ID: <51290905.10008@lsrfire.ath.cx>
References: <1361629899-8346-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Jl0-0002dp-0T
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 19:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab3BWSXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 13:23:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:40669 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3BWSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 13:23:08 -0500
Received: from [192.168.2.105] (p4FFDA907.dip.t-dialin.net [79.253.169.7])
	by india601.server4you.de (Postfix) with ESMTPSA id 1608112B;
	Sat, 23 Feb 2013 19:23:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1361629899-8346-1-git-send-email-ville.skytta@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216908>

Am 23.02.2013 15:31, schrieb Ville Skytt=C3=A4:
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>   Documentation/RelNotes/1.7.5.4.txt                 |  2 +-
>   Documentation/RelNotes/1.7.8.txt                   |  2 +-

Retroactively changing release notes for older versions is not worth it=
,=20
I think.

>   Documentation/RelNotes/1.8.2.txt                   |  2 +-

=46ixing typos in this draft for the next release is a good idea, thoug=
h.

>   kwset.c                                            |  4 ++--

>   xdiff/xdiffi.c                                     |  2 +-

These files come from external sources and it would be nice to push=20
fixes (not just for typos) upstream as well.

Ren=C3=A9
