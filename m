From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] git-gui: fetch/prune all entry appears last
Date: Wed, 23 Feb 2011 20:19:36 +0100
Message-ID: <4D655DC8.50109@web.de>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net> <20110213135714.GE31986@book.hvoigt.net> <4D640227.9090206@web.de> <20110222193021.GB28519@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsKFh-0007QB-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab1BWTTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:19:53 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:35960 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab1BWTTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:19:52 -0500
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9F79B189BE4ED;
	Wed, 23 Feb 2011 20:19:39 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsKFP-0008WR-00; Wed, 23 Feb 2011 20:19:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110222193021.GB28519@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/IcFVNqMK6kHPyRzzhRCbkfPoIYUkkQT9OcWDS
	yvt2UMCZJ9jHhneZmERXYg9xH+rbSRXH9H7EK5Z8JseIuervc9
	uVMs2lhMhOM3uVtnQI5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167715>

Am 22.02.2011 20:30, schrieb Heiko Voigt:
> The user might have got used to the order the remotes appeared previously.
> Lets add the all entry last so the all entry does not confuse previous
> users.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

I tested both patches under Linux, looks great now.

Tested-by: Jens Lehmann <Jens.Lehmann@web.de>
