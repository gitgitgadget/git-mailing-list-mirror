From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 08/23] rebase -i: reword executes pre-commit hook on interim commit
Date: Fri, 08 Aug 2014 21:09:55 +0200
Message-ID: <87wqaiajcs.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<03febc7259c741a0891183bf578c93600ab0d68d.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 21:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFpYT-0003GD-N0
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 21:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaHHTKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 15:10:13 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:57808 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbaHHTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 15:10:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 646FF4D6572;
	Fri,  8 Aug 2014 21:10:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NicsqLwyEyeg; Fri,  8 Aug 2014 21:09:56 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (173-161-212-225-Philadelphia.hfc.comcastbusiness.net [173.161.212.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 179F84D65DF;
	Fri,  8 Aug 2014 21:09:54 +0200 (CEST)
In-Reply-To: <03febc7259c741a0891183bf578c93600ab0d68d.1407368621.git.bafain@gmail.com>
	(Fabian Ruch's message of "Thu, 7 Aug 2014 01:59:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255064>

Fabian Ruch <bafain@gmail.com> writes:

> Subject: Re: [PATCH v2 08/23] rebase -i: reword executes pre-commit hook on interim commit

I think the change makes sense, but can you reword the subjects that it
describes the state after the commit (i.e. what you are doing), instead
of before the commit?

-- 
Thomas Rast
tr@thomasrast.ch
