From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] Git release notes man page
Date: Wed, 19 Feb 2014 10:06:57 +0100
Message-ID: <53047431.7070909@atlas-elektronik.com>
References: <1392460179-776-1-git-send-email-philipoakley@iee.org> <xmqqha7wcbkz.fsf@gitster.dls.corp.google.com> <1EC26D492ABB45FF8C399F84B1E30817@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 10:06:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG36k-0001SF-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 10:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbaBSJGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 04:06:13 -0500
Received: from mail96.atlas.de ([194.156.172.86]:26269 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbaBSJGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 04:06:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id AD5DC10838;
	Wed, 19 Feb 2014 10:06:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrdxQEDgwZXK; Wed, 19 Feb 2014 10:06:04 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 19 Feb 2014 10:06:04 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id ECE5427169;
	Wed, 19 Feb 2014 10:06:02 +0100 (CET)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.5; Wed, 19 Feb
 2014 10:06:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1EC26D492ABB45FF8C399F84B1E30817@PhilipOakley>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242385>

Am 18.02.2014 23:54, schrieb Philip Oakley:
> From: "Junio C Hamano" <gitster@pobox.com>
>>   I do not understand why
>> it is even a good idea to show release notes from the command line
>> "git" interface.
> 
> My looking at this came from Stefan's suggestion noted above 
> $gmane/240595. So it had at least one follower ;-)

Yes, but I could definitely live without it.
I compile git myself on most systems and that would just be a
convenient way to get an overview of the latest changes.

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: It is bad luck to be superstitious.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
