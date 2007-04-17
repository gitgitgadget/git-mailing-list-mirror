From: "Joan Ripoll Balaguer" <joan.ripsa@gmail.com>
Subject: Re: checkout Error on cygwin
Date: Tue, 17 Apr 2007 15:11:04 +0200
Message-ID: <5c08a49c0704170611p74f4cb68ja7287bac63ee1a27@mail.gmail.com>
References: <5c08a49c0704170608s4f643bf6ubc53d521149f2d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 15:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdnTN-0004iU-GQ
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 15:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbXDQNLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 09:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbXDQNLK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 09:11:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:14784 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbXDQNLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 09:11:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so163329uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 06:11:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmZT5fAQsjbBgNg1cMLliBXbdBlcDQSU2biGTmL47O4ZjphZ2JzJ7IJOLUFIErQxEY4HYKxzk9jG6YJPjqk+k4Jh/pDiYuTJKCpOzLvHlQNNkWjWgvmgGWmwbBoe8XJRZ4kK49liljmd/cy3k93vPUk6xNB36k+f95xutgSWQSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZQwWF56XGaRGcF7J6nbvYJfoxu8V8H9rHPOxUQZLKFOsresfJoemwVRRkr+1QYFGahlUwRTT7hWsPCOMckAv3sS23T9bRWNuFiYZx8giQiHzSlbFTWFkDtIXxpyuMMST85Hg1Jn8g42ltWCaOIErf7i6GS8LclI8d58MKRqFph8=
Received: by 10.82.107.15 with SMTP id f15mr10363124buc.1176815464301;
        Tue, 17 Apr 2007 06:11:04 -0700 (PDT)
Received: by 10.82.191.9 with HTTP; Tue, 17 Apr 2007 06:11:04 -0700 (PDT)
In-Reply-To: <5c08a49c0704170608s4f643bf6ubc53d521149f2d55@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44764>

2007/4/17, Joan Ripoll Balaguer <joan.ripsa@gmail.com>:
>
> $ git clean -x
> Removing ... (a lot of files)
>

And then

$ git status
# On branch cajal/20070201
nothing to commit (working directory clean)

-- 
Joan Ripoll
joan.ripsa@gmail.com
