From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [RFC] improving advice message from "git commit" during a merge
Date: Thu, 28 Aug 2014 14:17:50 +0200
Message-ID: <53FF1DEE.8030504@gmail.com>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 14:17:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMyeI-0007mU-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 14:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaH1MRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 08:17:50 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:55205 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaH1MRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 08:17:50 -0400
Received: by mail-wi0-f181.google.com with SMTP id e4so769300wiv.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nHa8Y/52rjSnXwMMb7Qs4iKZd61nv5gEMPqP0yJJxjY=;
        b=kGbP0yM310BuJdzEG0E8/bA5oZ5itx+FanhkYhejRfl/oP7G8rZGPuQvHR5G75Xagt
         gX8WzvLP05+y9y5qBoZWKlRNa+n0XaRpCXjMQAhuMkmYam3JfsNraT3YXR7k+AZEVx9D
         5KRM1YVk/+pZbbz4l6tFGU65BGeKh6n17zxLoIZ/C3ftqrfgtUcik4i/pMMLzWNrc50/
         PQPF4tWyVrdbaOdVJ5Ard5kfse9RPv5DmpuoahjNol78MqyYQxFrb6SsQtY3rD69IIaW
         zDkFU0nkhWf1dK1WNlpBmGBhTZCPoxFKwJKn9cFgVz8QaADdIBfozMiryp+4Dkvfjijp
         Busw==
X-Received: by 10.194.187.241 with SMTP id fv17mr4777874wjc.13.1409228268650;
        Thu, 28 Aug 2014 05:17:48 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id lm18sm34973592wic.22.2014.08.28.05.17.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2014 05:17:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256079>

On 27.08.2014 20:23, Junio C Hamano wrote:
> I am not doing this myself soon, though.  Hint, hint...

I asked once upon a time, if there was a place, 
which collects such topics for casual contributors and new comers.

Would you mind to update the leftover bits at
http://git-blame.blogspot.de/search?q=leftover&by-date=true
?

Thanks,
Stefan
