From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] revert: Simplify passing command-line arguments around
Date: Sun, 9 Oct 2011 13:58:37 +0530
Message-ID: <CALkWK0kA=zhpsmYhjMwv11xyHNhA0Ps=BjUDao0+HFLMKnADUg@mail.gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-7-git-send-email-artagnon@gmail.com> <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 10:29:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCokt-0007KR-Rf
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 10:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab1JII27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 04:28:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40808 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1JII26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 04:28:58 -0400
Received: by wwf22 with SMTP id 22so7779279wwf.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bR95j63BeTzXy1DsRtOX3J6trEGclE7YGQiU7XJOBRg=;
        b=dGXp8W9KxMLnTjQ4DEvshfCYh+6fjeg58FeTsNi/OXd+jw2jJuibJyC3jczf+NlQt3
         ZcZAK9Lmg+OdITylNMewEyIJBIJ/iyn5tz3wfHW/aIl6S+GLtYz2vvFKchMDTS6xW20q
         rTM+UF0ktePvLzGCdZUSYUWxlbRmbm3zyLHSA=
Received: by 10.216.190.131 with SMTP id e3mr4861897wen.48.1318148937077; Sun,
 09 Oct 2011 01:28:57 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Sun, 9 Oct 2011 01:28:37 -0700 (PDT)
In-Reply-To: <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183189>

Hi Tay,

Tay Ray Chuan writes:
> On Sun, Oct 9, 2011 at 1:36 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> [rr: minor improvements, commit message]
>
> This "[]" could go below, under the 3-dash (but before the stat):

Actually, I intended to put it in the commit message.  Seems to be
idiomatic: grep the log for "\[jc:" etc.

Thanks.

-- Ram
