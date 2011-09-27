From: Anand Kumria <akumria@acm.org>
Subject: Re: git svn clone issues with buddypress subversion repository
Date: Tue, 27 Sep 2011 08:44:40 +0100
Message-ID: <CAM1C4G=EzGDgQj=RnjG+AqLyWWwWYE=CpW-qbG1qRsvAa_EX3g@mail.gmail.com>
References: <CAM1C4G=YbK5PF21UujxNRR0PX9xqQBSEvcB45Zxy1hwZuyuL8Q@mail.gmail.com>
 <CAM1C4G=o_Q5scdv=Jk3ou-3OjnZiukZV3nz0NJR7CTaKLbB2jw@mail.gmail.com> <4E803413.3080709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 09:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8SLz-00050m-Rh
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 09:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab1I0HpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 03:45:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64468 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1I0HpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 03:45:11 -0400
Received: by wyg34 with SMTP id 34so6875990wyg.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=hpELnBbiF45+gCeci3aA9OJ+OVSNAPWyG7r2zc5k2NA=;
        b=T+JsG9cQz4FKaGbOMJFNli4ZMukTjSVp5yQ8wZcT8uXz8xF49RHuUuD0yu2VBTYOJm
         wcP3bSrg+DdSG7rmVURle3QGFi0E1Z/4I8Z6rYoKN6hqqR/BbNzyiAALgyh04sFNGcUQ
         4mBSZkbdDpAONlWwVmBTIdlvXAQ3Jyw+aipcc=
Received: by 10.227.36.197 with SMTP id u5mr8250196wbd.36.1317109510101; Tue,
 27 Sep 2011 00:45:10 -0700 (PDT)
Received: by 10.180.85.33 with HTTP; Tue, 27 Sep 2011 00:44:40 -0700 (PDT)
In-Reply-To: <4E803413.3080709@drmicha.warpmail.net>
X-Google-Sender-Auth: C-pPCNRXxF-o0goRd6NFFhO2jMI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182217>

Hi Michael,

On 26 September 2011 09:13, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Anand Kumria venit, vidit, dixit 24.09.2011 18:50:
>> Hi,
>>
>> I'm trying:
>>
>> % git svn clone -s http://svn.buddypress.org/trunk/ buddypress
>
> Please try
>
> git svn clone -s http://svn.buddypress.org/ buddypress

Yup - works perfectly!

Cheers,
Anand
