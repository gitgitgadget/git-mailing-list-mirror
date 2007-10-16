From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 11:27:39 -0400
Message-ID: <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <1192522094-4988-2-git-send-email-mfwitten@mit.edu> <1192522094-4988-3-git-send-email-mfwitten@mit.edu> <Pine.LNX.4.64.0710161404220.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhoLO-00037o-Fo
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864AbXJPP1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933891AbXJPP1q
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:27:46 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63282 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933732AbXJPP1o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 11:27:44 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9GFRfrU019112;
	Tue, 16 Oct 2007 11:27:41 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9GFRefp027467
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 11:27:41 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710161404220.25221@racer.site>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61193>


On 16 Oct 2007, at 9:04:34 AM, Johannes Schindelin wrote:

> Hi,
>
> does --binary hurt?

It's a no op according to the documentation.

In my experience, the healthier the trees are,
the healthier the forest is.

Michael Witten
