From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] sequencer: revert d3f4628e
Date: Mon, 7 Nov 2011 11:36:20 +0530
Message-ID: <CALkWK0k1AQt7Qr=rfpB7hRi-CNoHX2oUo4HR8eh09SwpnrXaCQ@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-6-git-send-email-artagnon@gmail.com> <20111106004257.GG27272@elie.hsd1.il.comcast.net>
 <7vlirt5aod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 07:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNIM2-0003Ph-9r
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 07:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1KGGGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 01:06:42 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42975 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1KGGGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 01:06:41 -0500
Received: by qyk27 with SMTP id 27so2029782qyk.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 22:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XSCibvnW8U6xG1v03DPG0D/Gb1RaE195eeH6A82rxKY=;
        b=XsmkJFicO3UNGEZIIDN+xQKo9m7sOQa29HnRh14qT972kEc4/YA56q+c77kmlsjHWu
         LRvcKBeNnuxOeLB2PsrzNSNaYyiIv1/e5M5g7H3RIH8YBCtwAVMFndGTdwRG50Pol/Zm
         a8tqwA4xUuPf59lniJVAhZQIlbfb56wAFFoAY=
Received: by 10.229.245.145 with SMTP id lu17mr2872220qcb.271.1320646001128;
 Sun, 06 Nov 2011 22:06:41 -0800 (PST)
Received: by 10.229.236.18 with HTTP; Sun, 6 Nov 2011 22:06:20 -0800 (PST)
In-Reply-To: <7vlirt5aod.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184955>

Hi Jonathan and Junio,

Jonathan Nieder writes:
> [...]

Junio C Hamano writes:
> Thanks for detailed reviews, Jonathan; looking forward for a re-roll, as I
> think the general direction the series seems to be aiming to go is good.

Thanks for the early feedback!  I'll polish the series this week.

-- Ram
