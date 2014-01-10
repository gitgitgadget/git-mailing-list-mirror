From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Fri, 10 Jan 2014 09:18:03 +0100
Message-ID: <52CFACBB.7000805@atlas-elektronik.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org> <xmqqppo090m7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 09:28:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1XSZ-0000K1-5B
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 09:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbaAJI2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 03:28:52 -0500
Received: from mail96.atlas.de ([194.156.172.86]:26377 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbaAJI2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 03:28:50 -0500
X-Greylist: delayed 673 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2014 03:28:50 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 6616A108E2;
	Fri, 10 Jan 2014 09:17:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qF52MZ5hRjn8; Fri, 10 Jan 2014 09:17:35 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 10 Jan 2014 09:17:35 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 8F36E27169;
	Fri, 10 Jan 2014 09:17:34 +0100 (CET)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.5; Fri, 10 Jan
 2014 09:17:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqppo090m7.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240296>

Am 10.01.2014 00:49, schrieb Junio C Hamano:
> I think we already use a nicer way to set up a page alias to keep
> old links working than making a copy in Documentation/; please mimic
> that if possible.
> 
> It may be overdue to refresh the suggested set of "top 20" commands,
> as things have vastly changed over the past 8 years.  Perhaps we
> should do that after reorganizing with something like this series.

I'd really like to see 'git help relnotes' working as well...

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Despite the high cost of living, it remains popular.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
