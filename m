From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Sat, 27 Feb 2010 22:33:11 +0100
Message-ID: <4B898F97.90706@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUHq-0003Ma-Qi
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935223Ab0B0VdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:33:17 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:35822 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933964Ab0B0VdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:33:16 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2BA36140B67BB;
	Sat, 27 Feb 2010 22:33:15 +0100 (CET)
Received: from [78.49.132.84] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NlUHj-0005s9-00; Sat, 27 Feb 2010 22:33:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/IPTqQeyS+xUqd1T+1nfiHToc+hgvb4z8lnsOq
	sb9Me7ZW0UcW5PkK8Es7QI2XZgiZ0FrtfiEHxxZCvDPFKm7wFi
	Z+ZDzVV0fmdZuMT4DeaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141230>

> If you are starting from "if your work tree is dirty, you MUST stash
> before checking out another branch", the suggestion is understandable.
> But the thing is, that starting point is not quite correct.

Does an option exist for the command "git checkout" to return to the specified
branch without modifications in one step?
When will it not be needed to reset the work tree to the last corresponding commit?

Regards,
Markus
