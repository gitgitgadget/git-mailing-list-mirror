From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sat, 3 Aug 2013 13:01:16 -0400
Message-ID: <20130803170116.GE945@analysisandsolutions.com>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
 <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
 <20130803163915.GB945@analysisandsolutions.com>
 <20130803165728.GB2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam A <hitsthings@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 19:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fCq-00040p-1M
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 19:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab3HCRBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 13:01:19 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:60887 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3HCRBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 13:01:18 -0400
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id E033718973; Sat,  3 Aug 2013 13:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375549276;
	bh=GXesePDDTnPuNwb4QFivF5evfgV2DG/7WI4rnagTCcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vb3lg8DCDSKImhhNk3ICdRTa8Ghsp/KHoAnoJpot/UkctBocU/QzMUORPNmzgMUiB
	 UvvdAoQEMNy3/IJ4IPd3pkd5LCml1yGEUEADqseI0Sx/v0GzrTWLP1I/uhTlFZBdiF
	 PfWeKaDTxjafw26yEac7CoQhAfaULcRDNdzXWLvs=
Content-Disposition: inline
In-Reply-To: <20130803165728.GB2893@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231607>

Heya:

On Sat, Aug 03, 2013 at 09:57:28AM -0700, Jonathan Nieder wrote:
> 
> Adam hadn't made a commit, so that wouldn't work in this case.

Oh, good catch.  I saw the add and assumed there was a commit there.

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
