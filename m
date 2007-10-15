From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-add (-a|-u)  and -n support
Date: Mon, 15 Oct 2007 05:09:15 -0400
Message-ID: <8ACD561E-6F12-4C64-BDBF-CDC697F95D82@MIT.EDU>
References: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu> <20071015042028.GB4844@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 11:10:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLxB-0007Mw-8v
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 11:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbXJOJJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbXJOJJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 05:09:26 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:43827 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753797AbXJOJJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 05:09:26 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9F99JvR004054;
	Mon, 15 Oct 2007 05:09:19 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9F99IKX000169
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 15 Oct 2007 05:09:19 -0400 (EDT)
In-Reply-To: <20071015042028.GB4844@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60967>


On 15 Oct 2007, at 12:20:28 AM, Jeff King wrote:

> Thank you for submitting a patch! However, please make sure you read
> SubmittingPatches carefully.

I apologize, though I got your first email about
Documentation/SubmittingPatches after I had sent
in this patch; I had gone rummaging around the homepage
for some information, but had found nothing special.

I just submitted a patch (properly!) to Petr Baudis
to add a link to that documentation on the main page.

> -Peff "policing the list with an iron fist in Junio's absence" King

Don't worry, I didn't take it personally ;-)

Sincerely,
Michael Witten
