From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 11:09:03 +0200
Message-ID: <m2obd3ou34.fsf@igel.home>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 11:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVIB4-0000i5-2e
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 11:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3DYJJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 05:09:14 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58500 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab3DYJJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 05:09:13 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ZxCJ43vFHz4KK3C;
	Thu, 25 Apr 2013 11:09:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ZxCJ43Dfrzbc6v;
	Thu, 25 Apr 2013 11:09:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id jJJHHo1WIb81; Thu, 25 Apr 2013 11:09:05 +0200 (CEST)
X-Auth-Info: kOQlXSzO25+UcHikUJxyoTA5GubiQGii0eUJrw0SwK0=
Received: from igel.home (ppp-88-217-100-223.dynamic.mnet-online.de [88.217.100.223])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 25 Apr 2013 11:09:05 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1E8F5CA2B6; Thu, 25 Apr 2013 11:09:04 +0200 (CEST)
X-Yow: Yes, Private DOBERMAN!!
In-Reply-To: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 10:37:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222357>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> you might argue that ~<n> normally refers to a /home/<n>, but who uses
> numbers in place of usernames?

~<n> expands to the <n>th element of the dir stack.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
