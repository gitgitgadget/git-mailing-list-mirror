From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Submodules: Add the new config option "ignore"
Date: Thu, 05 Aug 2010 21:08:03 +0200
Message-ID: <4C5B0C13.6020809@web.de>
References: <4C4DD33F.4020104@web.de> <alpine.DEB.1.00.1008051025451.2983@bonsai2> <7vlj8ldmyj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 21:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh5nk-0000SI-5I
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016Ab0HETIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 15:08:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57100 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548Ab0HETIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 15:08:04 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9B4FC16D6EE8B;
	Thu,  5 Aug 2010 21:08:03 +0200 (CEST)
Received: from [80.128.118.249] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Oh5nP-00046f-00; Thu, 05 Aug 2010 21:08:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <7vlj8ldmyj.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18licbJoxvIGUC13YZz3siKcB0gT+Z7O+p1vgfb
	5YNHh7V2akX/xeTwk0lE02Ul/HpL08/vyqskfU6j+kmU1hETux
	iRM8HM48kqmESOuWrnlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152704>

Am 05.08.2010 18:49, schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Date: Thu, 5 Aug 2010 10:49:55 +0200
>> Subject: [PATCH] Add the 'diff.ignoreSubmodules' config setting
>> ...
>> This commit introduces a global config setting to set a default
>> (porcelain) value for the --ignore-submodules option, keeping the
>> default at 'none'. It can be overridden by the submodule.*.ignore
>> setting and by the --ignore-submodules option.
>> ...
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
> 
> Nice, at least from a cursory look.  

Yup, makes sense to me too.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
