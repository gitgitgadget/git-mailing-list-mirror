From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git annoyances
Date: Wed, 09 Apr 2008 16:39:51 -0500
Message-ID: <47FD37A7.6030404@freescale.com>
References: <20080409101428.GA2637@elte.hu> <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 23:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jji33-000381-Ep
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 23:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbYDIVky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755607AbYDIVkx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 17:40:53 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:50027 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbYDIVkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 17:40:53 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m39LeGZ5006057;
	Wed, 9 Apr 2008 14:40:17 -0700 (MST)
Received: from [10.214.72.57] (mvp-10-214-72-57.am.freescale.net [10.214.72.57])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m39LeFMK002223;
	Wed, 9 Apr 2008 16:40:16 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79140>

Junio C Hamano wrote:
>

> The introductory documents may need to be updated to teach explicit "git
> pull $repo $branch" form first,

Hey Junio,

I'm hearing you here! :-)

I think a furtherance of this notion is to
teach "git fetch ; git merge" before "git pull".

Thanks,
jdl
