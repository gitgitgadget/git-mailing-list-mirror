From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 08/23] rebase -i: reword executes pre-commit hook on interim commit
Date: Mon, 11 Aug 2014 20:22:51 +0200
Message-ID: <874mxiant0.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<03febc7259c741a0891183bf578c93600ab0d68d.1407368621.git.bafain@gmail.com>
	<87wqaiajcs.fsf@thomasrast.ch> <53E882B8.4070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGuFT-0005mE-B3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 20:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbaHKSXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 14:23:07 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:34243 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbaHKSXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 14:23:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6ECC04D6685;
	Mon, 11 Aug 2014 20:23:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sLQaRpEdDBkU; Mon, 11 Aug 2014 20:22:52 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (roaming-195-167.host.udel.edu [128.175.195.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9E5284D6575;
	Mon, 11 Aug 2014 20:22:51 +0200 (CEST)
In-Reply-To: <53E882B8.4070209@gmail.com> (Fabian Ruch's message of "Mon, 11
	Aug 2014 10:45:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255128>

Fabian Ruch <bafain@gmail.com> writes:

> Hi Thomas,
>
> Thomas Rast writes:
>> Fabian Ruch <bafain@gmail.com> writes:
>>> Subject: Re: [PATCH v2 08/23] rebase -i: reword executes pre-commit
>>> hook on interim commit
>> 
>> I think the change makes sense, but can you reword the subjects that it
>> describes the state after the commit (i.e. what you are doing), instead
>> of before the commit?
>
> The log message subject now reads as follows:
>
>> rebase -i: do not verify reworded patches using pre-commit

Excellent wording, thanks!

-- 
Thomas Rast
tr@thomasrast.ch
