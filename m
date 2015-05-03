From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v3 4/4] api-builtin.txt: explain common command groups
Date: Mon, 04 May 2015 00:32:35 +0200
Message-ID: <5546A203.6090305@gmail.com>
References: <554405D5.9080702@gmail.com>	<55456990.6000509@gmail.com>	<55456AD3.7090908@gmail.com>	<CAPig+cT0aurG9gS2CrwMPG2B4xrAbhvwNJtAjYz7UYc4x1TiEA@mail.gmail.com>	<55468C23.70306@gmail.com> <CAHYJk3S3s4RjFMUaomP2wUVBbcTLRGYrAOa-uDjrfsKqUuWPog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mikael Magnusson <mikachu@gmail.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 04 00:33:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp2S4-0002Wr-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 00:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbECWcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 18:32:39 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33332 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbECWci (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 18:32:38 -0400
Received: by wgin8 with SMTP id n8so134247149wgi.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=HewyoYwvswBbt2qeueCAZKsK1pGmIANnJPi7iHWOVj0=;
        b=e+TyYraJ/fg43sVlgnhgAXWdkuE0B2+X7NHI2D4XPSV9JdCx8pO20h+BRyQBrExXw/
         vttKQS2SOhgLYARTyXCNWcMliu2KT9ZG0GlpW9MECdcsZBbiGVefwBGzMOV6taQbuklj
         py8y7QqgM5n/hEwlEwhTKMgXV8C5yNKLKcAYKdnHBvajEIdpkUz1cTQoCPZkf4cyDL6C
         Sd2LKdakbtHEsWQurqc+Lubd+QIpF+ijac3HfioIfA+prpKuF+xhlIKSwVee7EE9wjrk
         dCVsSPT/6e/mPJkEx3q3luJuQ5tbshZ0TnfMiBE5XrLlfI3f6vUkGAD6eaT147hoprdM
         ejZw==
X-Received: by 10.194.236.66 with SMTP id us2mr37241449wjc.54.1430692357543;
        Sun, 03 May 2015 15:32:37 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id it5sm8400441wid.3.2015.05.03.15.32.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 15:32:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAHYJk3S3s4RjFMUaomP2wUVBbcTLRGYrAOa-uDjrfsKqUuWPog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268298>

On 05/03/2015 11:07 PM, Mikael Magnusson wrote:
> [sendemail]
>      smtpencryption = tls
>      smtpserver = smtp.gmail.com
>      smtpuser = sebastien.guimmara@gmail.com
>      smtpserverport = 587
>      assume8bitEncoding = UTF-8
>
> Should be all that's needed. (in ~/.gitconfig)

Thanks a lot, I was also missing packages. Now it works fine.
