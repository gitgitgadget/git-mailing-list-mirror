From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH 0/4] Proposed patches
Date: Sun, 13 Jul 2008 20:57:54 +0200
Message-ID: <487A5032.9090307@etek.chalmers.se>
References: <20080713113853.18845.37686.stgit@localhost.localdomain> <b0943d9e0807130442k36a10747q7bcbd996cdc774dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI6mc-0006LR-Qm
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbYGMS54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 14:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYGMS54
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:57:56 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:33274 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbYGMS54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:57:56 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 004C085A8;
	Sun, 13 Jul 2008 20:57:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <b0943d9e0807130442k36a10747q7bcbd996cdc774dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88324>

Catalin Marinas wrote:
> 2008/7/13 Catalin Marinas <catalin.marinas@gmail.com>:
>> A new post of the proposed patches after implementing Karl's comments.
> 
> BTW, these are StGIT patches, I forgot to add the prefix in the subject line.
> 
If you run "git config format.subjectprefix 'StGIT PATCH'" in your repo,
git format-patch will add the prefix automatically for you.

StGIT might have a similar option.

/Lukas
