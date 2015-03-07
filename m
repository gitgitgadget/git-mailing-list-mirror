From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Please consider adding a -f switch to git-clone (or something similar)
Date: Sat, 07 Mar 2015 23:26:28 +0100
Message-ID: <87d24kzbor.fsf@igel.home>
References: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Diego Viola <diego.viola@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 23:26:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUNB9-0001S2-F0
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 23:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbbCGW0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 17:26:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49265 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbCGW0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 17:26:32 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3l00lp0TM5z3hj05;
	Sat,  7 Mar 2015 23:26:30 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3l00lp04ZXzvhNG;
	Sat,  7 Mar 2015 23:26:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Ay6xkW9Ot1mx; Sat,  7 Mar 2015 23:26:29 +0100 (CET)
X-Auth-Info: FwECyqAw33kapDavA6dnQmYX5wAyS4XuOEJkNkIqi37hiNiBA7cSikDxybVEEn1p
Received: from igel.home (ppp-46-244-171-17.dynamic.mnet-online.de [46.244.171.17])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  7 Mar 2015 23:26:29 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id BEBE72C37F1; Sat,  7 Mar 2015 23:26:28 +0100 (CET)
X-Yow: If I am elected no one will ever have to do their laundry again!
In-Reply-To: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
	(Diego Viola's message of "Sat, 7 Mar 2015 18:54:25 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265006>

Diego Viola <diego.viola@gmail.com> writes:

> I know I could git-init in a empty directory

You can also git init a non-empty directory.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
