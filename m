From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: A couple of rebase --autosquash proposals
Date: Mon, 09 Dec 2013 07:51:51 +0100
Message-ID: <52A56887.4070909@viscovery.net>
References: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Brett Randall <javabrett@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 07:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpuhY-0003uG-S7
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 07:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760538Ab3LIGv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 01:51:57 -0500
Received: from so.liwest.at ([212.33.55.18]:63251 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758Ab3LIGv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 01:51:56 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Vpuh5-0001P2-Sw; Mon, 09 Dec 2013 07:51:52 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7458816613;
	Mon,  9 Dec 2013 07:51:51 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239061>

Am 12/9/2013 3:23, schrieb Brett Randall:
> * fixup! or squash! on it's own would default to fixing-up the
> previous commit (or result of previous step of rebase if that was a
> squash/fixup).

Why would you want that? To fixup the previous commit, just use 'git
commit --amend'. What am I missing?

-- Hannes
