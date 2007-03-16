From: Len Brown <lenb@kernel.org>
Subject: Re: mercurial to git
Date: Fri, 16 Mar 2007 00:53:54 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200703160053.54699.lenb@kernel.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070315094434.GA4425@peter.daprodeges.fqdn.th-h.de> <20070315210406.GA8568@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 16 05:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS4TX-0006WN-LS
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 05:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXCPEzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 00:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXCPEzT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 00:55:19 -0400
Received: from hera.kernel.org ([140.211.167.34]:42614 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbXCPEzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 00:55:18 -0400
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l2G4s0lk004749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2007 04:55:10 GMT
User-Agent: KMail/1.9.5
In-Reply-To: <20070315210406.GA8568@thunk.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/2842/Thu Mar 15 22:21:31 2007 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,RCVD_IN_SORBS_DUL
	autolearn=no version=3.1.8
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42322>

On Thursday 15 March 2007 17:04, Theodore Tso wrote:
> So it does handle octopus merges already (it has to, the ACPI folks
> are very ocotpus merge happy :-).

Well, just to set the record straight...

So yes, I did a 12-way merge in the kernel a long while back on a lark.
I don't generally do them any more in the official kernel tree
because I think they make bisect more complicated than it needs to be.

cheers,
-Len
