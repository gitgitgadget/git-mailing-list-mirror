From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] Make XDF_NEED_MINIMAL default in blame.
Date: Sun, 16 Mar 2014 13:12:01 +0100
Message-ID: <8738iixrzi.fsf@thomasrast.ch>
References: <154997837.FlSR2gFiUN@river>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Andreen <harv@ruin.nu>
X-From: git-owner@vger.kernel.org Sun Mar 16 13:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP9vQ-0003AM-Ki
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 13:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaCPMMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 08:12:15 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:56908 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbaCPMMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 08:12:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 3C8184D6510;
	Sun, 16 Mar 2014 13:12:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uGcz44eYeMa6; Sun, 16 Mar 2014 13:12:02 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 6A39E4D64BD;
	Sun, 16 Mar 2014 13:12:02 +0100 (CET)
In-Reply-To: <154997837.FlSR2gFiUN@river> (Michael Andreen's message of "Sun,
	16 Mar 2014 11:43:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244190>

Michael Andreen <harv@ruin.nu> writes:

> The --minimal flag is still there, but didn't want to break scripts
> depending on it.

If I specify --no-minimal, does that turn it off again?

-- 
Thomas Rast
tr@thomasrast.ch
