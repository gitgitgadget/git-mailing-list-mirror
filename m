From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/3]
Date: Thu, 14 May 2015 14:07:00 -0700
Message-ID: <xmqq1tiikgwb.fsf@gitster.dls.corp.google.com>
References: <1431541434-21884-1-git-send-email-dturner@twitter.com>
	<xmqqvbfvj7ge.fsf@gitster.dls.corp.google.com>
	<xmqqegmikj7z.fsf@gitster.dls.corp.google.com>
	<1431635466.17436.0.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0LV-00047x-4q
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbbENVHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:07:03 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38614 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422734AbbENVHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:07:02 -0400
Received: by igbhj9 with SMTP id hj9so84132791igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IlSKaZ+gfU4eHH7rcuGIXE08E/Oo3KX138xwza85cqE=;
        b=HHvip3kvLS6wGEVa8zrD8X+xSdiJijN2/BrEdB3oTSqiyhXCwYQt4IewGQOAl/hSYO
         kAU78UI7n5TCayLHHibv43IBWd2tBNRzu+0ggIqQMpu356N6fS4pH1urCvka61Xq3hU1
         dQyuTbcMecwIzzedRRM/+yOU04D19DFPRJ4+qop41JgSnAKJgxr6BBKv6Kr9VVo5eQoG
         i3c61jTBKdl6OFlfTHF5k1U2k7qI8UfMoWled7PwxG+YCZxZhb3VBtw9H8CkV3iWKPA6
         WNZW9fWTAB87U31RTGauCV1ykvqFGoRCDHDDPO76xrDw9pZtkRC+r0l7/DmKfnSio3PL
         oOKA==
X-Received: by 10.50.57.112 with SMTP id h16mr19991943igq.35.1431637621808;
        Thu, 14 May 2015 14:07:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id c16sm148193ioj.29.2015.05.14.14.07.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 14:07:01 -0700 (PDT)
In-Reply-To: <1431635466.17436.0.camel@ubuntu> (David Turner's message of
	"Thu, 14 May 2015 16:31:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269096>

David Turner <dturner@twopensource.com> writes:

> I sent v10 in response to your last mail before getting this; I will
> replace it with a v11 which includes this instead.

Yeah, I noticed that our mails crossed.  I'm deep into today's
integration cycle already, so what I'll push out will use v10 with
the fix-up for now.

Thanks.
