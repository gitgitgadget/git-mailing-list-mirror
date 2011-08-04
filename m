From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #01; Wed, 3)
Date: Thu, 4 Aug 2011 16:27:23 +0530
Message-ID: <CALkWK0nqLciGxy5NOWDQ1B48HoaFCBvKMC94Q1cwE9y7j9HZYg@mail.gmail.com>
References: <7vzkjq6mpn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:57:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qovcb-0005im-Kk
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab1HDK5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:57:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58447 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab1HDK5o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:57:44 -0400
Received: by wyf22 with SMTP id 22so431349wyf.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4HsR3NfFB2GN5IsIFdqqZe8EEzPGdaCUZlxAX5UtEO8=;
        b=uBNqzQtV69zv6WpbD4gWiNtvBWyqzUeKU80k7YZxK4ZoBAUd03bjWflZYi0Ia9ZnXc
         mb5XUV71dDOctTtzLUcRHFYVAzytU72cQd913ZGo9b8ZJfdOSXVum2L8w/prheO1w/1w
         0TMHLpAwgY8l6XbhX1Y1U6Qtgg5fNuYWok9GM=
Received: by 10.216.185.9 with SMTP id t9mr227231wem.94.1312455463040; Thu, 04
 Aug 2011 03:57:43 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 03:57:23 -0700 (PDT)
In-Reply-To: <7vzkjq6mpn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178735>

Hi Junio,

Junio C Hamano writes:
> * rr/revert-cherry-pick-continue (2011-08-01) 18 commits
[...]
> Rerolled (v5) and looked reasonably clean.
> Will merge to "next".

Please use v6 instead [1].
Thanks.

[1]: http://mid.gmane.org/1312454356-3070-1-git-send-email-artagnon@gmail.com

-- Ram
