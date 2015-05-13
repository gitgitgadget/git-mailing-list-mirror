From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Tue, 12 May 2015 22:23:47 -0700
Message-ID: <xmqqzj59aw4c.fsf@gitster.dls.corp.google.com>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
	<xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
	<20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 07:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsP99-00073e-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbbEMFXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:23:51 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37816 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbEMFXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:23:50 -0400
Received: by igbsb11 with SMTP id sb11so35312063igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rXrCXzRfLzlSJrOyRBepHZxx5VHHwo1db0wYJdeo034=;
        b=x++m+p3G9Kr80y0URC4Kb436NSA2tD0vwNmUqZ6NNLdyDQgESWV9Qvm5uwXacBkULu
         XM+TBFVPS0GKd2SDW87sAtxCtk37m3ccNxHa77zIT3PX9eq/u57qpQRu6wgAUIhlqNwu
         RWcSVw6o4HZJm3isOk9ydqJh+fpv5sq6YrcuOwjA5fOzsY0oXKKG9J5OPQxHGF72q5U8
         7X2eQq3gzi1zpnOTceonPd4zqTC9KkpDRbKaEBuKLwNCJsZ5ToyJZUQ26q1mOCr7BaH1
         bj8YYQoSCy6uEdSl1wAufHCcP3lNJzNTCma96amRRO+7BL6dQiG8JrWK1QBPjSC4ym5r
         juZA==
X-Received: by 10.42.188.19 with SMTP id cy19mr7076607icb.92.1431494629882;
        Tue, 12 May 2015 22:23:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id j4sm2854675igo.0.2015.05.12.22.23.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 22:23:48 -0700 (PDT)
In-Reply-To: <20150513045650.GA6070@peff.net> (Jeff King's message of "Wed, 13
	May 2015 00:56:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268936>

Jeff King <peff@peff.net> writes:

> Here are the patches. They do not include the code-fence fixes from
> Jean-Noel and myself that were already posted, but could easily go on
> top.

Thanks. Will queue.

Why are you guys using AsciiDoctor again?  Speed over accuracy is an
acceptable answer, as I know how slow my documentation codechain is.
