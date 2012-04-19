From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Delete gitlink entry but keep .gitmodules file unmodified
Date: Thu, 19 Apr 2012 11:10:58 +0200
Message-ID: <4F8FD6A2.5090605@web.de>
References: <4F8EBF5D.5070301@tmatesoft.com> <4F8EC4E2.6070507@web.de> <4F8ED0F6.5070106@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Semen Vadishev <semen.vadishev@tmatesoft.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 11:12:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKnPG-00053H-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 11:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab2DSJL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 05:11:57 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:58207 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab2DSJL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 05:11:56 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id D9FA36DD1CA6
	for <git@vger.kernel.org>; Thu, 19 Apr 2012 11:11:01 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.175.87]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0M5fhI-1S5BK11JZQ-00xbMi; Thu, 19 Apr 2012 11:11:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F8ED0F6.5070106@tmatesoft.com>
X-Provags-ID: V02:K0:Nw2sWh4K2EysdPe4k4BCF6xVKTxNfcErQLejuh5E3sm
 ra2tiAEeWWxJUwWogFyt/MksDAAJRQ6Z0yzO1XOdecxkDZgSWw
 7BfVkbm6M4LaeI2Dcy+xgYzMSa3UnkJw0NXpRTXpIC6QNBPCt9
 IswwXT6pm4lGQVvGlvyGmEp0GU66EFOb+Xrp1Bk/YduJW7w591
 8UIeKfi6SZ810ZXV7Kf7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195931>

Am 18.04.2012 16:34, schrieb Semen Vadishev:
> And what about these obsolete [submodule "foo"] sections left in .gitmodules and .git/config files? Do they bring any problems? Maybe for some older git versions?

None that I'm aware of, that should work just fine.
