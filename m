From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH/RFC] introduce GIT_WORK_TREE environment variable
Date: Wed, 4 Apr 2007 09:59:57 -0700
Message-ID: <56b7f5510704040959n17795c1aj5792fef712bae1b8@mail.gmail.com>
References: <20070328141505.GA16600@moooo.ath.cx>
	 <20070404140853.GA31372@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8q8-00066c-5i
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 19:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbXDDRAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 13:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXDDRAB
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 13:00:01 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:6891 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbXDDRAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 13:00:00 -0400
Received: by ik-out-1112.google.com with SMTP id c21so176761ika
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 09:59:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BYiqdkHCSBHizeBa6PuFEwxRLHyMTFkzKHQfDjtlxsdtoovwMhLeJ2nMf5NSaozB2hxJ6xIloaGFz884shKFeFPmfokznjIyxrrsIcdhPrDDM7lssK4iqiInBZTpqYnDLZI3niFWTT10ueuRXLDuSoPDdzBBi/n+uwplkNxeUpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GrseIs2hdQuVZ8s10rzUT9Ql6lu4P9mOzwgxugF5V1oTUCivCTY+ICr7MebNPmDAxeQGykzrcn94wM2PLRBy6lESm7pKC2EtWoGTFBy7NaVjETuBY5cc8Dvrawd4P52+/pvug0PpzPsN9VLbxA5+QA8uaq6r2cU8QfeGUu7tkTY=
Received: by 10.115.60.1 with SMTP id n1mr336635wak.1175705997982;
        Wed, 04 Apr 2007 09:59:57 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Wed, 4 Apr 2007 09:59:57 -0700 (PDT)
In-Reply-To: <20070404140853.GA31372@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43758>

On 4/4/07, Matthias Lederhofer <matled@gmx.net> wrote:
> As 1.5.1 is released now: any comments on this patch?

Ditto for "Handling large repositories".
I guess I should resubmit it against 1.5.1.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
