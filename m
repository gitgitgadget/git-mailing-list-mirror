From: karthik nayak <karthik.188@gmail.com>
Subject: Re: Help with Getting started to Contribute
Date: Tue, 28 Apr 2015 20:25:51 +0530
Message-ID: <553F9F77.3020007@gmail.com>
References: <CAMOUyJ8_Xyw=a54VFdsJFrrxr86zA_W5--w5bpED70D4g3YY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tummala Dhanvi <dhanvicse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 16:56:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn6vd-0003T4-M0
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 16:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030615AbbD1Ozz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 10:55:55 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35221 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965724AbbD1Ozz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 10:55:55 -0400
Received: by pdbqd1 with SMTP id qd1so166327540pdb.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pyqktyx8/xHvd+sBFVLKjC1st0+1QlHs2GtR3N9uCwQ=;
        b=jypVyuzdfI8AlyaxxE6vXkXkiK58WNdAxgAub/NozH0SzmWlrOzla0A2G9A9B7Rro0
         lLL0xct5iSJ8W8KNsmC001JDsU0KY3PKfe9eTC2rZHnPiHREJv6oH9qJUnp8IYZIj6nM
         g6G3fERnmSHtxfPhttyANvqTnxXqAh+Iu5y8LD52KtOFX3cvVr6ntWqe3fDNqdxVcoyE
         UzFv5oL0cug9URDYFFmgg5KyMBKtnzEz/ibHUozQIYKxdv5/onPpPktMNistDTNcT4xv
         3QcY/DPpf2+zIjJ4vyd+pFsAPdJw9rqpv60xxngro5SM3jyxiDSL/mMNpbvn3er5nqH2
         9plw==
X-Received: by 10.68.219.42 with SMTP id pl10mr33114540pbc.154.1430232954562;
        Tue, 28 Apr 2015 07:55:54 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id kt3sm13800629pbc.90.2015.04.28.07.55.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 07:55:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAMOUyJ8_Xyw=a54VFdsJFrrxr86zA_W5--w5bpED70D4g3YY4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267926>

Hello Tummala,

On 04/28/2015 07:15 PM, Tummala Dhanvi wrote:
> Hi ,
>
> I would like to contribute to git.
>
> Can you guys point me to some useful resources to get me started to
> contribute to git.

I suggest you go through the Documentation, especially 
"Documentation/CodingGuidelines" and "Documentation/SubmittingPatches" 
to get an idea of the workflow and guidelines for contributing to Git.

>
> Also does git have something like junior jobs so that It can be done
> by new to contribution.

All issues and bugs are discussed on the mailing list, so keep going 
through the list for potential problems.

There is also Junio's Blog where he keeps a list of things to be done

http://git-blame.blogspot.de/p/leftover-bits.html

You could pick something from there and work on that.

Have Fun.

Regards,
Karthik
>
> Also searching about the git in google points to some other
> organisation which uses git  :(    (well this is because of the
> popularity of the git)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
