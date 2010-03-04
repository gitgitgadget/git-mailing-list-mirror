From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Thu, 04 Mar 2010 20:55:18 +0100
Message-ID: <4B901026.4090002@web.de>
References: <4B67227A.7030908@web.de> <4B8B9BF1.10408@web.de> 	<7v1vg4ufas.fsf@alter.siamese.dyndns.org> <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> 	<7vk4tvsu6x.fsf@alter.siamese.dyndns.org> <4B8C2F90.8080104@web.de> 	<b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com> 	<4B8CDBCA.4030101@web.de> <7vvdde62ai.fsf@alter.siamese.dyndns.org> 	<4B8E8677.8060003@web.de> <b4087cc51003032346o4e8f338ub703c460e33c3f1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 22:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnH8t-0007mN-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 20:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab0CDTz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 14:55:26 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48641 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab0CDTzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 14:55:25 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 391EA151ED9AF;
	Thu,  4 Mar 2010 20:55:24 +0100 (CET)
Received: from [78.49.172.30] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NnH8m-0005pj-00; Thu, 04 Mar 2010 20:55:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <b4087cc51003032346o4e8f338ub703c460e33c3f1e@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+D1d8Xs5tSb3EAriZ4C+kZTdA+fHtWo/GvZpUo
	VpLb/9BNbI8Iotmj3DBYtjeKXRmhz2LsMIidh6R+musR7WW5lA
	WQxh3ZcsO4AKV4IHqkKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141542>

> I'm not sure how often WIP commits become accidentally published or
> left in the history, but perhaps it would be advantageous to provide
> a means of specifying officially that a particular commit is in fact
> a WIP commit such that no other commits can be made on top of this WIP
> commit and it can't be merged with other branches or pushed or whatever.

When will such blocking commits be useful?
Would you really like to support a stopper or barrier for branches?

Regards,
Markus
