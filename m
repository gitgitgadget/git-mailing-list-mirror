From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 09:39:50 +0100
Message-ID: <49252256.7020001@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>	<1227098252.11370.8.camel@therock.nsw.bigpond.net.au> <vpqhc63zrz2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Arafangion <thestar@fussycoder.id.au>,
	Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L356W-0003il-DA
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 09:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbYKTIkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 03:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYKTIkW
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 03:40:22 -0500
Received: from mail.op5.se ([193.201.96.20]:60090 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbYKTIkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 03:40:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9175B24B000B;
	Thu, 20 Nov 2008 09:35:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VgDO88fOq1G4; Thu, 20 Nov 2008 09:34:53 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1280424B000D;
	Thu, 20 Nov 2008 09:34:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <vpqhc63zrz2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101392>

Matthieu Moy wrote:
> Arafangion <thestar@fussycoder.id.au> writes:
> 
>> You should probably fix your build script,
> 
> ccache should help:
> 
> http://ccache.samba.org/
> 

Not for docbook/flex/yacc stuff, which is what was causing trouble.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
