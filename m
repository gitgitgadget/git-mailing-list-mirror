From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH 1/6] templates: Fewer subprocesses in pre-commit hook
Date: Mon, 10 Jun 2013 22:39:40 +0200
Message-ID: <CAD77+gTQQ4=gs85vnoZxvSWsPHu8-eK7DKpVvB9di_TjcPbeAA@mail.gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
 <1370889365-6239-2-git-send-email-richih.mailinglist@gmail.com> <7vy5ahg37y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um8sr-0005lY-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab3FJUkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 16:40:03 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:48987 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3FJUkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 16:40:01 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so5038592wev.8
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=44MGuxyoY3M3ttluBfpOc5jvfCCCehl5o7pZO7rb+ec=;
        b=do5R8aAmuglnFYNYEwAuK2UwFNZIRAZkPMBgcHW/rFKh8pvITF2lChk43cuc3j+1aK
         uYPTeOPeYKB+s8FFWqrl4TuI5ax1RQGRH6xAzRFZiYPNcgvQitMP+YMlACcPWn08Wusp
         IO5ryaaDuU7+6yUDOnVzUmSP75x0+FYcKVq4fQMSwYZvzA3edOkeMJo81gk96pETTutc
         wRE73fimlsbCkAhSSr5kLKr/FyTSgsLbq779+Ko/A86N0r9+Ehu6gfpdB4Mnipzz+UBL
         8vDvdtbzu/itKysmwkW0mX30RJK96SRiIKBjcdCCd3DeLwOrR3HDf9Icll7henluLUh2
         O0/Q==
X-Received: by 10.194.216.39 with SMTP id on7mr6450386wjc.4.1370896800313;
 Mon, 10 Jun 2013 13:40:00 -0700 (PDT)
Received: by 10.194.17.9 with HTTP; Mon, 10 Jun 2013 13:39:40 -0700 (PDT)
In-Reply-To: <7vy5ahg37y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227372>

Hi Junio,

if you want a new patch, just say the word.


Richard
