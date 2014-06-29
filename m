From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Jun 2014, #06; Thu, 26)
Date: Sun, 29 Jun 2014 14:27:59 +0200
Message-ID: <53B0064F.1000206@kdbg.org>
References: <xmqqvbrn2utv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 14:28:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1EDK-000187-Gh
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 14:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbaF2M2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 08:28:06 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:14590 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752998AbaF2M2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 08:28:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 251F7130047;
	Sun, 29 Jun 2014 14:28:01 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8761219F47D;
	Sun, 29 Jun 2014 14:27:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqvbrn2utv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252641>

Am 27.06.2014 00:02, schrieb Junio C Hamano:
> Four mingw series are still in limbo--are they in good enough shape
> for Windows folks who wanted to upstream them?

I've now tested the Unicode patches a bit, and I didn't notice a
regression in my use-cases. The patches are good to go, IMHO.

-- Hannes
