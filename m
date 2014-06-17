From: agi <agnes.pasztor@omixon.com>
Subject: Re: ISO 13485
Date: Tue, 17 Jun 2014 16:57:42 +0200
Message-ID: <53A05766.7060502@omixon.com>
References: <539F09B9.3050200@omixon.com> <9738CF1519014998B579C405EB4FA22B@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 16:58:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwupi-0006Hq-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 16:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933523AbaFQO5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 10:57:46 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:36175 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933167AbaFQO5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 10:57:44 -0400
Received: by mail-we0-f171.google.com with SMTP id q58so7317240wes.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 07:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3GNSSLFtkEzyIzzSaCA3X0fmyIgRXK5xJDiT+rRJa4g=;
        b=MrgAC4tfp/RpwTlLAOqGl/ODEziQG98rHpbjE58CZ/FI6zN3F+ykDb3qmkXHV0JZKg
         NSJc0/PBTw3OiQa73MNeO70xaPGw9mE05Mp8LrrFumXAQYTfT9Y8ekdkbTmnGbW+zISx
         0Q57NhUQPVhlzuiCPEYkvue+cvb++6Uk4Cys/kIpKOW3cjAo5dZvd7WazqCYo8VZq3gb
         RfabTp998EGTNn0Dy9JE1eIyGnimdDlhPYPqIN21VJK0+3CPhm9FHazARdqJKwnISql1
         yEUvmgCCY3Zb0J7KGeRTeeXJCwfoPnpSVGbt4LqVVl0JH2vFgcml3a63IAdRsbsKClPV
         Z+Lg==
X-Gm-Message-State: ALoCoQns4XKwC2qi0nZDZPt9+Tua1xUNmt/cfB8A2073sO3NKhHuhurcKwYVG7I1JYfGaSmPjv9E
X-Received: by 10.194.87.200 with SMTP id ba8mr38901603wjb.28.1403017063463;
        Tue, 17 Jun 2014 07:57:43 -0700 (PDT)
Received: from [192.168.1.143] (business-178-48-22-49.business.broadband.hu. [178.48.22.49])
        by mx.google.com with ESMTPSA id 8sm41608918eea.10.2014.06.17.07.57.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 07:57:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <9738CF1519014998B579C405EB4FA22B@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251862>

Hi Jason,

Thanks for the speedy reply. We are in the process of trying to make our 
software product ISO13485 compatible and we are assessing all systems 
that we use.
Do you have a validation document for git that could provide information 
on how to use it in order to comply with ISO legislations?
Any additional information or material you can think of is more than 
welcome.

Thanks in advance for your help!


Best Regards,
Agnes Pasztor

Senior Test Engineer
Omixon Biocomputing Ltd.


On 06/16/2014 05:20 PM, Jason Pyeron wrote:
>> -----Original Message-----
>> From: agi
>> Sent: Monday, June 16, 2014 11:14
>>
>> Hello,
>>
>> I would like to ask a question about GIT v. 1.7
>>
>> Is it compatible with ISO 13485 (quality management system)?
>> Can it be
>> used for developing a medical diagnostic software?
> Yes.
>
> Now, do you have a specific question about how to use Git in your QA process?
>
> --
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> -                                                               -
> - Jason Pyeron                      PD Inc. http://www.pdinc.us -
> - Principal Consultant              10 West 24th Street #100    -
> - +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
> -                                                               -
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> This message is copyright PD Inc, subject to license 20080407P00.
>
>   
>
