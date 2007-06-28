From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Build git on HP/UX
Date: Thu, 28 Jun 2007 13:22:13 +0200
Message-ID: <81b0412b0706280422u54150ed9nefc4ae716ffb03c6@mail.gmail.com>
References: <20070628105952.GC8925@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: michal.rokos@nextsoft.cz, GIT <git@vger.kernel.org>
To: "Thomas Glanzmann" <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 13:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3s4n-0006gi-Bm
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 13:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759953AbXF1LWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 07:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759948AbXF1LWP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 07:22:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:31496 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759878AbXF1LWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 07:22:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so554222ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 04:22:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=drPDZy3y7UL882NqJUpstnwTT+/JhJkqPsDAHu54XSNwDlyDvcfyCaHP0xCuBpLx3Gzo3nDYYNDle5WfHuwUcEQj4qxJk9fKd6ROAZpqo2/CGoSWLsX6vM5vu/0v8z42xzLGpjSZ1frjgA3OagWPSFd5SuuA/ZJCCloDnWupPAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qEQptZ+uIVD5GmID2Er+7iJMchCZheqWPbkFBKZ/d97dDe19MqB8xb919Bs46oYJ3/howSlLk7QVCcqGUgiCwJPTPdkFDBEw4V7k+UzeJxdm97RwN26P6+0V/PLQRbR9KtUcO6ybnqfqPFJCritmG8YrdCID+XRvYSgbRubab24=
Received: by 10.78.201.10 with SMTP id y10mr837050huf.1183029733293;
        Thu, 28 Jun 2007 04:22:13 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 28 Jun 2007 04:22:13 -0700 (PDT)
In-Reply-To: <20070628105952.GC8925@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51098>

On 6/28/07, Thomas Glanzmann <thomas@glanzmann.de> wrote:
> Hello,
> could someone here describe what he did to build git on HP/UX?

what did you already tried? Do you have a build log? (with either gcc or acc)
