From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 12:09:40 -0700
Message-ID: <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com> <1302721187.21900.4.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5Rn-0002DM-2l
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab1DMTJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:09:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38865 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1DMTJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:09:44 -0400
Received: by iyb14 with SMTP id 14so813001iyb.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=PoNq9BAZK5mGz2VNXuTECqpFo6AEJwJdA1FrEWXOZ4g=;
        b=lriN+TS+P2OzjWWPt2xjrBUacao6zafkcGVI7c4vyvMTUb5QnDuwD9re1bPGq1M7jK
         VLbyLFT4y0digzHpqb1VeC7WJjMWP4GhY9lpYClxFFzIJmoeZiumI/Cx18h+nA5ZNz8G
         rfhh8sgMNCNoc5R1GT9CBXaZ516cuOBM9qSuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=iCf0dfrJJqBzW013vjeh9xbp4EnjoEp26tiDKQ7nNrK2EG4ojPjTSV5J9WY8Jk9EFP
         cRFpb67Jfsy25kbDFmHxkcwISo43wyOnL1oewj6N8S1hAEiLjxOIUtA/p50OokC2vmix
         tsNTpsneRrKuGQZnuFz9fOWaya5sre4oVeZ7A=
Received: by 10.42.8.72 with SMTP id h8mr3496045ich.193.1302721783594;
        Wed, 13 Apr 2011 12:09:43 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id jv9sm577801icb.13.2011.04.13.12.09.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 12:09:42 -0700 (PDT)
In-Reply-To: <1302721187.21900.4.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171474>

On Apr 13, 2011, at 11:59 AM, Drew Northup wrote:

> On Wed, 2011-04-13 at 11:16 -0700, Daniel Searles wrote:
>> Hi All,
>>
>> I'm curious if Gitbox is in violation of the Git's GPL.
>> http://www.gitboxapp.com/
>>
>> Thank you,
>> Daniel Searles
>> Tech Support
>> Media Lab, Inc.
>
> Well, it appears that he may have implemented "git" on his own, or at
> the very least he's trying to imply that he did.
>
> http://www.gitboxapp.com/faq.html#gpl

He very clearly says that he ships Git, not a reimplementation.

Josh
