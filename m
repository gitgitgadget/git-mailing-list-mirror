From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: RE: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: Mon, 21 Sep 2009 21:23:26 -0400
Message-ID: <6F87406399731F489FBACE5C5FFA0458519639@ex2k.bankofamerica.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
 <878wgcbb52.fsf@users.sourceforge.net> <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
 <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com> <4AB78910.7010402@viscovery.net>
 <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com> <4AB7A2E7.5000601@viscovery.net>
 <874oqvc0n3.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:23:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpu6k-0006xm-HW
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 03:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbZIVBXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 21:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbZIVBXp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 21:23:45 -0400
Received: from vamx04.bankofamerica.com ([171.159.192.80]:59563 "EHLO
	vadmzmailmx04.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748AbZIVBXo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 21:23:44 -0400
Received: from vadmzmailmx03.bankofamerica.com ([171.182.200.79])
	by vadmzmailmx04.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8M1NWhF024977;
	Tue, 22 Sep 2009 01:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1253582613;
	bh=Vg9q88WOcaksdVFXb9wuMwuKxRQCkUHj3fAxwMnJLJU=;
	h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
	 Content-type:Content-transfer-encoding:References;
	b=BPlyTiXDi3C9LcG2cERzw3vMo7amd8n/TSZbOrv5sBhTglgafrokyROzqxd98QqI8
	 9EyFxDJXlhr++B4Yi1s3uXw0/aGXxc6rlRJmmkTIYx6FS/Mnnl3rmHsaUgx4tZxid8
	 p0UXJcpsdwK1VuLD+nJ4R9wO5evjnJykiUYQ/LNs=
Received: from memva2mta02.bankofamerica.com (memva2mta02.bankofamerica.com [171.186.140.77])
	by vadmzmailmx03.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8M1NWc1001500;
	Tue, 22 Sep 2009 01:23:32 GMT
In-reply-to: <874oqvc0n3.fsf@users.sourceforge.net>
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Thread-index: Aco7FzYUQESxRLbpSmOvj3jQiecRCgAC3qBw
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 22 Sep 2009 01:23:29.0966 (UTC) FILETIME=[4AE164E0:01CA3B23]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-09-21_11:2009-09-17,2009-09-21,2009-09-21 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128916>

Pat Thoyts writes:

> John, if this works for you can you also check that editing and
> creating new gitk views on your real repository continues to work ok.

Works like a charm.
I look forward to it coming in a new version of git.
Thank you very much.
