From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] urls.txt: document optional port specification in git
 URLS
Date: Thu, 05 Feb 2009 09:41:42 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <498AA646.4040009@atlas-elektronik.com>
References: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com> <20090205080913.GB27983@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 10:10:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV0G5-0002O1-WB
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 10:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759218AbZBEJJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 04:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758927AbZBEJJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 04:09:27 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:40499 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759150AbZBEJJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 04:09:24 -0500
X-Greylist: delayed 1650 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 04:09:24 EST
Received: from vssrv01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with SMTP id 66CE4138AB;
	Thu,  5 Feb 2009 09:41:50 +0100 (CET)
Received: from mgsrv01.atlas.de ([10.200.101.16])
 by vssrv01.atlas.de (SMSSMTP 4.1.9.35) with SMTP id M2009020509420603031
 ; Thu, 05 Feb 2009 09:42:06 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 304B02716C;
	Thu,  5 Feb 2009 09:41:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 086FE2716A;
	Thu,  5 Feb 2009 09:41:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <20090205080913.GB27983@ultras>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108543>

(Please don't reply to me only, CC the mailing list)

On 2/5/2009 9:09 AM, Nicolas Sebrecht wrote:
> On Wed, Feb 04, 2009 at 12:51:35PM +0100, Stefan Naewe wrote:
> 
>>  Documentation/urls.txt |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> [...]
> 
>> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
>> +- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
>>  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
>>  - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
>>  - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
> 
> I did not understood. To what does '{startsb}' and '{endsb}' refer ?

Look at the generated documentation.

Regards,
Stefan
-- 
----------------------------------------------------------------
/dev/random says: Useless Invention: Fireproof kindling.
