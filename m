From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 07 Dec 2010 00:14:06 +0100
Message-ID: <m2hbeqv6ip.fsf@igel.home>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 00:14:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkG6-0000oV-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208Ab0LFXOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:14:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46055 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab0LFXOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:14:08 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 067751C1DA11;
	Tue,  7 Dec 2010 00:14:07 +0100 (CET)
Received: from igel.home (ppp-88-217-122-250.dynamic.mnet-online.de [88.217.122.250])
	by mail.mnet-online.de (Postfix) with ESMTP id F07371C0011D;
	Tue,  7 Dec 2010 00:14:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C44D7CA2A0; Tue,  7 Dec 2010 00:14:06 +0100 (CET)
X-Yow: Xerox your lunch and file it under ``sex offenders!''
In-Reply-To: <7vlj42siu5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 Dec 2010 13:16:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163048>

Junio C Hamano <gitster@pobox.com> writes:

> +core.logRefDeletion::
> +	Enable logging of eletion of refs (e.g. branches), allowing `git

                         +d

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
