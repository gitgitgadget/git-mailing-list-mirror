From: karthik nayak <karthik.188@gmail.com>
Subject: Re: GSoC 2015: 2 accepted proposals
Date: Tue, 28 Apr 2015 17:47:20 +0530
Message-ID: <553F7A50.1080907@gmail.com>
References: <vpqoam9mjuo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pyokagan@gmail.com, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 14:17:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn4SE-0002n4-8T
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 14:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965806AbbD1MR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 08:17:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36300 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965388AbbD1MRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 08:17:25 -0400
Received: by pabsx10 with SMTP id sx10so163071662pab.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UIo78kNu9KVhtM7aXh3X/YoyWMtPNWqEhoYJCOlgBBc=;
        b=k6O5ZhJfL84fG+AUmJiIPIB+jrZi6IFBrLKg1572uqUoWhlAiIS7wySY/Yd2mucDnA
         ud0V8Qywk1cNlu/6g0oTf+WlAL+W9GxT7muVVCTxbOIXF4ztEmHOBBEoy9XdizrPyEA2
         nuJxzQ1GD5hscdYimZIQ43FYWuZ8BNfOZ7xoKwWTWxDhlGzqYYI4kAc/JhCLVx7JZCRo
         v8s+yTRRfdfKs+Yx5OxjV0OE6wZt1jlSj8dXEpd4yE1UjTIrjzpyaSIAWiVp7NaAkelu
         4+yxdvxpzsIS7mqua+9N4GrMgarVlB9Ws+y3Cns81L/7dsSAnlveepSkQNPG4uaU6Q91
         rQaw==
X-Received: by 10.68.219.1 with SMTP id pk1mr31311919pbc.18.1430223445088;
        Tue, 28 Apr 2015 05:17:25 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ki3sm22351675pdb.74.2015.04.28.05.17.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 05:17:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <vpqoam9mjuo.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267923>

Hello to Everyone,

On 04/28/2015 01:20 AM, Matthieu Moy wrote:
> Hi,
>
> The results just got offical: the Git organization has 2 students
> accepted for the summer of code 2015.
>
> Karthik Nayak will work on "Unifying git branch -l, git tag -l, and git
> for-each-ref" mentored by Christian Couder and yours truly.

Thanks a lot for accepting my proposal and giving me an opportunity to 
work with Git via GSoC. Can't express how excited I am.

As Matthieu mentioned I will be working on "Unifying git branch -l, git 
tag -l, and git for-each-ref". I plan to start off by going through the 
existing implementation of each of the above commands and come up with a 
design for unification for now. Also to take notes from Jeff King's 
attempt at unification[1].

I will be pushing all my work to my personal Git repository on Github[2].
Where anyone can get involved. Will also make sure to notify the mailing 
list on a regular basis on what is going on with my project.

Looking forward to work with Git and complete this project successfully.

Regards,
Karthik

>
> Paul Tan will work on "Make git-pull and git-am builtins", mentored by
> Johannes Schindelin and Stefan Beller.

Congrats Paul, I wish you the very best.

>
> Regards,
>

[1] https://github.com/peff/git/tree/jk/for-each-ref-contains-wip
[2] https://github.com/KarthikNayak/git
