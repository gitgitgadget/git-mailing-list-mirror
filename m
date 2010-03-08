From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Some information that git diff saves and that git status does
 not
Date: Mon, 08 Mar 2010 22:52:19 +0100
Message-ID: <4B957193.3080700@web.de>
References: <loom.20100308T111146-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 22:52:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoksJ-0004Yt-1R
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 22:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab0CHVw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 16:52:27 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51620 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab0CHVwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 16:52:25 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1685614BE55FE;
	Mon,  8 Mar 2010 22:52:24 +0100 (CET)
Received: from [80.128.106.67] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NoksA-0007ze-00; Mon, 08 Mar 2010 22:52:22 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <loom.20100308T111146-322@post.gmane.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/+7wUvILgiv2OO2lqPx1/AfcEwp0tFIT1jDN6a
	tvHlhEnb74CpTAN4WX+SbtulAPGMXm88VEc3PsUzRdR84GkxzD
	+0FdZ4VABDLiim7k+s5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141790>

Am 08.03.2010 11:46, schrieb Sergio:
> I happen to work with a (possibly somehow unusual) configuration where 2 laptops
> are syncronized via unison (a widely used file syncronizer).

Doing the same here between my desktop and my laptop, but i did enable
"times=true" in the unsion config file. The reason for that was that i
wanted to keep the creation time of my pictures (instead of replacing
them with the synchronization time) but it helps syncing git repos quite
nicely too (But keep in mind that when you enable "times=true", you'll
have to sync all files once again next time because their time stamps
seem to have changed).
