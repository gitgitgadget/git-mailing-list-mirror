From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Nov 2009, #01; Wed, 04)
Date: Thu, 05 Nov 2009 09:38:55 +0100
Message-ID: <4AF28F1F.7020905@viscovery.net>
References: <7vmy31a5p6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:39:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xs1-0005k5-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 09:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZKEIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 03:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbZKEIiy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 03:38:54 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:15876 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbZKEIix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 03:38:53 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5xrr-0003g2-Iw; Thu, 05 Nov 2009 09:38:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4C5B24E9; Thu,  5 Nov 2009 09:38:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vmy31a5p6.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132213>

Junio C Hamano schrieb:
> * rj/maint-simplify-cygwin-makefile (2009-10-27) 1 commit.
>  - Makefile: merge two Cygwin configuration sections into one
> 
> This is one of the most obviously correct bit from "Compiling on Cygwin
> using MSVC fails" topic I didn't really look at.  If J6t is Ok with the
> series, I don't mind queueing the whole thing myself.

I'm actually expecting a resend of the remaining patches in the series
with updated commit messages and with the original patch 3/4 being first.

-- Hannes
