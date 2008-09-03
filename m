From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show
 decoration
Date: Wed, 3 Sep 2008 22:06:45 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809032200490.32548@pollux>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191732.GC31195@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:08:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KayeA-0005wq-MX
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 22:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbYICUHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYICUHE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:07:04 -0400
Received: from mailout01.t-online.de ([194.25.134.80]:33261 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYICUHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:07:03 -0400
Received: from fwd28.aul.t-online.de 
	by mailout01.t-online.de with smtp 
	id 1Kaycu-0001KN-03; Wed, 03 Sep 2008 22:06:52 +0200
Received: from [192.168.2.100] (ST6nrUZbYhIv7VuTzkcwXD7NOKHWBUOxehhqhZ8UmH78CwCinKrON4pu4vYqQ3XQup@[84.163.235.210]) by fwd28.t-online.de
	with esmtp id 1Kaycm-1VMNV20; Wed, 3 Sep 2008 22:06:44 +0200
X-X-Sender: michael@pollux
In-Reply-To: <20080903191732.GC31195@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: ST6nrUZbYhIv7VuTzkcwXD7NOKHWBUOxehhqhZ8UmH78CwCinKrON4pu4vYqQ3XQup
X-TOI-MSGID: d9fd53c7-dd3f-425d-93c9-adc523bf55a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94847>



On Wed, 3 Sep 2008, Jeff King wrote:

> On Wed, Sep 03, 2008 at 08:40:08PM +0200, Michael Dressel wrote:
>
>> Signed-off-by: Michael Dressel <MichaelTiloDressel@t-online.de>
>
> Also, I don't recall whether it was in the original message, but feel
> free to add my
>
>  Signed-off-by: Jeff King <peff@peff.net>
>
> for my portions.
>
I'm sorry for not properly citing you. I did mention you in the commit
message which is wrong. So what would be the right way? Just adding a
line 
Signed-off-by: Jeff King <peff@peff.net>
before the ---?
Or resending your original patch and than my patch on top of yours?

Cheers,
Michael
