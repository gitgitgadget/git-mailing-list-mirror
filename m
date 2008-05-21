From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Git-new-workdir
Date: Wed, 21 May 2008 14:43:46 -0500
Message-ID: <lXwYKtxzN4sNGyIsKSICbezjS7G4fF4oK6wrVgqs-vVP5A9o-fmLmg@cipher.nrlssc.navy.mil>
References: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com> <20080521184446.GA23924@bit.office.eurotux.com> <MnNeABMJjOQ8gdG6gY5zubSC3c5X2sDYBwcI1MotmXFvW3kUNXzB5A@cipher.nrlssc.navy.mil> <63BEA5E623E09F4D92233FB12A9F794301FC8B2B@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Wed May 21 21:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuF5-0000lJ-9d
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762174AbYEUTny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760843AbYEUTny
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:43:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53557 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYEUTnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:43:53 -0400
Received: by mail.nrlssc.navy.mil id m4LJhlDN013142; Wed, 21 May 2008 14:43:47 -0500
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794301FC8B2B@emailmn.mqsoftware.com>
X-OriginalArrivalTime: 21 May 2008 19:43:47.0175 (UTC) FILETIME=[FC344F70:01C8BB7A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82573>

Craig L. Ching wrote:
>  
> 
>> From: Brandon Casey [mailto:casey@nrlssc.navy.mil] 
>> My take on it...
>>
>> If you want to have _multiple_different_ branches checked out 
>> from the _same_ repository, and do development in all of 
>> them, then git-new-workdir is the right choice.
>>
> Yes, that's precisely what we want to do.  So according to your
> experience, we're making the right choice then.

Yes. I feel more confident after reading your reply to Robert where
you described your use-case more thoroughly.

-brandon
