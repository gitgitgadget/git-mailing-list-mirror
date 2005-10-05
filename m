From: Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Question on git clone
Date: Wed, 05 Oct 2005 11:42:56 -0400
Message-ID: <4343F480.30501@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 05 17:46:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBRB-0006G3-33
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 17:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVJEPnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 11:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVJEPnD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 11:43:03 -0400
Received: from magic.adaptec.com ([216.52.22.17]:35717 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965225AbVJEPm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 11:42:58 -0400
Received: from redfish.adaptec.com (redfish.adaptec.com [162.62.50.11])
	by magic.adaptec.com (8.11.6/8.11.6) with ESMTP id j95Fguc24975
	for <git@vger.kernel.org>; Wed, 5 Oct 2005 08:42:56 -0700
Received: from rtpe2k01.adaptec.com (rtpe2k01.adaptec.com [10.110.12.40])
	by redfish.adaptec.com (8.11.6/8.11.6) with ESMTP id j95Fgvg15623
	for <git@vger.kernel.org>; Wed, 5 Oct 2005 08:42:57 -0700
Received: from [10.110.10.142] ([10.110.10.142]) by rtpe2k01.adaptec.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 5 Oct 2005 11:42:57 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2005 15:42:57.0367 (UTC) FILETIME=[754C5670:01C5C9C3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9711>

Hi,

Any reason why "git clone" barfs, but cg-clone works without
a problem?

The message I get is this:

Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

Thanks,
	Luben
