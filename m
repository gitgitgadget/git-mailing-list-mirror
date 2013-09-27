From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.8.4.1
Date: Fri, 27 Sep 2013 13:38:11 -0700
Message-ID: <20130927203811.GM9464@google.com>
References: <20130927185200.GL9464@google.com>
 <5245E3BD.60703@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 22:38:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPenr-0001BE-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 22:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab3I0UiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 16:38:17 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:55832 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab3I0UiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 16:38:15 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so3013211pbb.6
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NITCQ/cvOpFQc2v3MJR5ttwE+zDvpZ3mFlzBif4R4xg=;
        b=bKzgnxORybCl5NqpkZ9a/qc1s0Yr3sXNvBCio7SpbLwDS2rOgyMQe6fv1FTX+W0+eQ
         RX9urwMkUCvM0HjhclQVXPGz1CVfMUn+WZWcUJLEwUzCqPOovz/G6BlIpw81dpWghtTD
         nC3uj5a+kF9AoYfHpaN3rxK50K97nz4jRgMVFoUNQCkMUrv/A0ugJy1Qf+ZRiUAeaaMC
         NdQtNO1H8MvMEMq6oAStUp4oDCcbfGzagBIGdgb8fyiSecoAYRlAv9IIQRZ1lKCQoroL
         H2du/jaJRoyoC/KcUoiuPAVjAbN6xisyLhN/oroKIekU0luyv0PzcKJUzF+2RrVgO7vi
         TUAA==
X-Received: by 10.67.23.71 with SMTP id hy7mr13423715pad.99.1380314295306;
        Fri, 27 Sep 2013 13:38:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oj6sm14730848pab.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 13:38:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5245E3BD.60703@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235475>

Marc Branchaud wrote:
> On 13-09-27 02:52 PM, Jonathan Nieder wrote:

>> The following public repositories all have a copy of the v1.8.4.1
>> tag and the maint branch that the tag points at:
>>
>>   url = https://googlers.googlesource.com/jrn/git
>>   url = git://repo.or.cz/git/jrn.git
>>   url = git://gitorious.org/git/jrn.git
>>   url = https://github.com/jrn/git
>
> Are none of Junio's regular repos going to be updated while he's on vacation?

Yes, that's right.

> I don't think it's a big deal if they're not, though some mention of it in
> this annoucement would've been appreciated

True.  Next time. ;-)

Thanks,
Jonathan
