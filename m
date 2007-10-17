From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 21:34:24 -0400
Message-ID: <862396DD-A3EA-4850-8AE8-9E765C7FF0F2@MIT.EDU>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <Pine.LNX.4.64.0710161404220.25221@racer.site> <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu> <200710162320.14917.robin.rosenberg.lists@dewire.com> <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu> <20071017011148.GL13801@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihxo3-0000Xz-WA
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761546AbXJQBec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755636AbXJQBec
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:34:32 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44498 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755496AbXJQBeb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 21:34:31 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9H1YRf7016243;
	Tue, 16 Oct 2007 21:34:27 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9H1YQZR009049
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 21:34:26 -0400 (EDT)
In-Reply-To: <20071017011148.GL13801@spearce.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61302>


On 16 Oct 2007, at 9:11:48 PM, Shawn O. Pearce wrote:

> Sorry, but I have to say I agree with Robin here.  The tab patch
> is large, ugly, and provides relatively little value in comparsion.
>
> The first rule of git development typically is "any change is bad".
> Because anything that is already written can be assumed to already
> be tested and in use by someone.  Breaking that is bad, as then
> they have a bad experience with git.

OK. I understand.

This was really preparation for a more substantial addition
that I hope to make.

I'll just have to change one line at a time with every substantial
patch!

mfwitten
