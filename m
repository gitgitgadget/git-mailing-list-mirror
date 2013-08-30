From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Aug 2013, #07; Wed, 28)
Date: Fri, 30 Aug 2013 22:04:51 +0200
Message-ID: <5220FAE3.1070101@web.de>
References: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 22:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFUwE-0002P7-Ee
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 22:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab3H3UEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 16:04:54 -0400
Received: from mout.web.de ([212.227.15.3]:49661 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab3H3UEy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 16:04:54 -0400
Received: from [192.168.178.41] ([91.3.174.105]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MPYMT-1VK9m13bZR-004gtW for <git@vger.kernel.org>;
 Fri, 30 Aug 2013 22:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:Vmv59SVL5CFrXZZ+cyL9G79rs1VAXLJipL6otU5rgBo95d3Ascy
 U6teyp1Gx5XOwb7pjCKZSnyOFqx3DwICAZ9rSI9wbptsb0nSDLlXZ9mjoj7J9LuXQTy3Eq2
 gj6zR1bDBQVAYvhp4Lzit2jnUS/WoaknbVZBRIwX1WSAJgtB7LeAUsUt1HCj/tG8fNR8Ge1
 EiYTmaKZNraTRBmmMiRzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233466>

Am 29.08.2013 01:24, schrieb Junio C Hamano:
> * bc/submodule-status-ignored (2013-08-20) 2 commits
>  - submodule: don't print status output with ignore=all
>  - submodule: fix confusing variable name
> 
>  Originally merged to 'next' on 2013-08-22
> 
>  Will merge to 'next'.

Looks like you didn't merge it to next yet, please don't until we
sorted out the quoting issue Matthieu just brought up.
