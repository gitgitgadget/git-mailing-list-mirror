From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Feature Request: Passing a number as an option to git tags for displaying latest tags
Date: Wed, 22 Jul 2015 20:58:20 +0200
Message-ID: <87lhe8f29f.fsf@igel.home>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Halil =?utf-8?B?w5Z6dMO8cms=?= <halilozturk55@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzDo-0007d1-WA
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 20:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbbGVS6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 14:58:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45642 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbGVS6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 14:58:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3mc5fQ1648z3hjNt;
	Wed, 22 Jul 2015 20:58:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3mc5fQ0QC0zvh21;
	Wed, 22 Jul 2015 20:58:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Eym4IudtaCpT; Wed, 22 Jul 2015 20:58:21 +0200 (CEST)
X-Auth-Info: EgDSBF2K6460YSjuB0kf+Z9Ok0E1kYiWceFLNxXburG9PBP+C33XQyfDRwOhvz9t
Received: from igel.home (ppp-93-104-185-220.dynamic.mnet-online.de [93.104.185.220])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 22 Jul 2015 20:58:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 85E6D2C4526; Wed, 22 Jul 2015 20:58:20 +0200 (CEST)
X-Yow: I want to TAKE IT HOME and DRESS IT UP in HOT PANTS!!
In-Reply-To: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
	("Halil =?utf-8?B?w5Z6dMO8cmsiJ3M=?= message of "Wed, 22 Jul 2015 13:17:45
 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274453>

Halil =C3=96zt=C3=BCrk <halilozturk55@gmail.com> writes:

> Passing a number as an option to "git tags" command should display la=
test tags.

How do you define "the latest tags"?  By tag creation?  Lightweight
tags don't have any kind of creation time attached.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
