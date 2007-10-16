From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 19:22:35 -0400
Message-ID: <26CC90F6-94D1-448E-ACF5-9D6CBAD196EF@MIT.EDU>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <Pine.LNX.4.64.0710161404220.25221@racer.site> <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu> <200710162320.14917.robin.rosenberg.lists@dewire.com> <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu> <Pine.LNX.4.64.0710162348260.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhvkX-0004iN-CS
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 01:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbXJPXWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbXJPXWk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 19:22:40 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:50600 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753815AbXJPXWj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 19:22:39 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9GNMaNT006386;
	Tue, 16 Oct 2007 19:22:37 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9GNMatF014694
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 19:22:36 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710162348260.25221@racer.site>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61277>


On 16 Oct 2007, at 6:49:17 PM, Johannes Schindelin wrote:

>> I think fixing the tabs is more important than removing --binary.
>>
>> It's clear the the entropy of tabulation increases over time;
>> the tab patch acts as a buffer to reconstruct a clean signal.
>
> Git.  The most advanced TCM - Tab Code Manager.  It's not about  
> source,
> it's about tabs.
>
> ;-)

I don't know whether to laugh or be miffed.

I think I'll choose to laugh. ;-D
