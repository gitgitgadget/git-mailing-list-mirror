From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 20:00:31 +0200
Message-ID: <87a9nhhb9c.fsf@hase.home>
References: <51A11DD0.4040802@svario.it>
	<CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
	<51A24C75.3090100@svario.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Sun May 26 20:00:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgfFJ-000227-O5
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 20:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab3EZSAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 14:00:38 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40150 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab3EZSAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 14:00:37 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3bJTcx66QVz4KK67;
	Sun, 26 May 2013 20:00:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3bJTcx5xvlzbbkq;
	Sun, 26 May 2013 20:00:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id AxkK1-u1pjQX; Sun, 26 May 2013 20:00:32 +0200 (CEST)
X-Auth-Info: 6YXEO7rm3c5Jh8R7YjJqoZuSCGhXfR+s6MSB38oFJeQ=
Received: from hase.home (ppp-93-104-146-124.dynamic.mnet-online.de [93.104.146.124])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 26 May 2013 20:00:32 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
	id 1B0D1100DAA; Sun, 26 May 2013 20:00:32 +0200 (CEST)
X-Yow: Hey, I LIKE that POINT!!
In-Reply-To: <51A24C75.3090100@svario.it> (Gioele Barabucci's message of "Sun,
	26 May 2013 19:55:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225557>

Gioele Barabucci <gioele@svario.it> writes:

> Simple, I keep all my projects on the same server, so I would like to
> refer to that server + path using 'remote-repo'.
>
> "git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"

You can use "remote-repo:" instead.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
