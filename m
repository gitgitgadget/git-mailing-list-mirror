From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH na/strtoimax] Compatibility: declare strtoimax() under
 NO_STRTOUMAX
Date: Sun, 06 Nov 2011 09:53:24 +0100
Message-ID: <4EB64B04.4010101@kdbg.org>
References: <4EB5583E.2030306@kdbg.org> <7vlirt7pdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nick Alcock <nix@esperi.org.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 09:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMyU3-0007nU-GS
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 09:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab1KFIx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 03:53:28 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:18727 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750855Ab1KFIx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 03:53:28 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8A68BA7EB4;
	Sun,  6 Nov 2011 09:53:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 355A219F34C;
	Sun,  6 Nov 2011 09:53:24 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <7vlirt7pdk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184905>

Am 06.11.2011 07:10, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Commit f696543d (Add strtoimax() compatibility function) introduced an
>> implementation of the function, but forgot to add a declaration.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
> 
> Thanks, but I think f696543d is v1.7.6 and not that patch.

Oops, sorry for that.

>  I hope you do
> not mind if I just squashed this in, instead of leaving it as a separate
> patch.

I do not mind at all.

-- Hannes
