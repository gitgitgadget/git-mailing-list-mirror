From: Benoit Bourbie <benoit.bourbie@gmail.com>
Subject: Re: Fixing typos
Date: Fri, 12 Apr 2013 00:20:52 -0500
Message-ID: <516799B4.7080608@gmail.com>
References: <5166291C.8070709@gmail.com> <CALkWK0kwm-sFevWhZ1XwZGzozbJ_VwGkSt16FJtb67q10sqS+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 07:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQWQB-0004BH-7m
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 07:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab3DLFU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 01:20:58 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33474 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3DLFU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 01:20:58 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so2024503obc.6
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:newsgroups
         :to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=u6aQK6PciCwD4587E7/p7uoWWFTk+wWpJIM/NLe7/Sg=;
        b=A9uxlKr7/9ttbj3rxa1nIkBx/xl2IkIXyJJ//yaNBY0r8AwRDgCd7VUPiO1JYVmdnw
         Syus0Nstlph21EgvPi1R2Si1Eb4Z5bI9/9J88mY9uy7FddMxfPWOor7vuAbvdwaIwEmJ
         u3xA3wY25mEgCEd5Ujw3r4mKBPwmSehh+LMv4nBukVsGv4o/cB+TTbBDI1Ts2/30116S
         OSVtlMDBFSsNyajXqBJ2JBkRt/5AZNZFcRlp3JxmGd5xBh1h0gh1uBICOZek8Y9p/boR
         VgX7/ihIcTKct1uX9fie2dIfG0xvXLObyCV4iZyFEnSwelQOgZNDeE07yq/vkLsg4zoY
         oLdg==
X-Received: by 10.60.30.131 with SMTP id s3mr3455649oeh.106.1365744056432;
        Thu, 11 Apr 2013 22:20:56 -0700 (PDT)
Received: from [192.168.0.16] (c-98-201-171-34.hsd1.tx.comcast.net. [98.201.171.34])
        by mx.google.com with ESMTPS id ru4sm865340obb.4.2013.04.11.22.20.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 22:20:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CALkWK0kwm-sFevWhZ1XwZGzozbJ_VwGkSt16FJtb67q10sqS+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220955>

I re-submitted it.

Thank you, Ramkumar.



On 04/11/2013 05:14 AM, Ramkumar Ramachandra wrote:
> Benoit Bourbie wrote:
>> I apologize for being picky
>
> There's nothing to apologize for.  These are good catches worth fixing.
>
>> but that patch fixes 3 typos.
>
> Please read Documentation/SubmittingPatches, particularly the parts about:
> 1. Sending patches inline using git send-email, as opposed to an attachment.
> 2. Signing off on your patch.
>
> Cheers.
>
