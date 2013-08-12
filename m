From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Mon, 12 Aug 2013 17:50:19 -0400
Message-ID: <CAPig+cQX=knOrJZ-UZBVRPbxRbNBrFg6r75uE8R468frH0aoig@mail.gmail.com>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
	<1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
	<20130809200101.GX14690@google.com>
	<7vr4e230g8.fsf@alter.siamese.dyndns.org>
	<7viozb1hh2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 23:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V900k-0004OC-IA
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 23:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab3HLVul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 17:50:41 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:42013 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab3HLVuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 17:50:21 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so5229011lab.13
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fShlF+iX++xgm1znMfbEGJqT+vhmt4ZppUhB5n/HmAo=;
        b=nvL2MDylbkYS6SAJ5v1D3R83SAQrtkfFc0KGRURyGtrWFIvKVwZKGpeBr4A2ARj7h3
         qOzHKbpnmBPAekJwuyflm7ul2nsIvU+xByJr+vRjNwuYftU9QrWIFO7tdW1Tp8ofQOQm
         G8sPY7Qm3xxCh9liUwI7FD4XKA6whIPk0HDWgPqDTergFe5t60h9RIYLGu+VIYYtsnOL
         Jc3lQEzI1zRsnXtfvrfp9327h6JmpyIZu/5Bgtj3zdAj8Wr/ecMWDu06NmoxELT/r5c/
         +IkQIvNN+TI5qJFe6gZ/xdZTeOfew/6nDjjE+Vo+1FA/8RJO/eDGBT6M3Tc2mKHmwZ5x
         NNHQ==
X-Received: by 10.152.3.201 with SMTP id e9mr770686lae.24.1376344219545; Mon,
 12 Aug 2013 14:50:19 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 12 Aug 2013 14:50:19 -0700 (PDT)
In-Reply-To: <7viozb1hh2.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: q5D50WRbLqmx1ekOwCSbMsAC7tk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232206>

On Mon, Aug 12, 2013 at 3:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: .mailmap: update long-lost friends with multiple defunct addresses
>
> A handful of past contributors are recorded with multiple e-mail
> addresses, all of which are undeliberable.  With a lot of help from

s/undeliberable/undeliverable/

> Jonathan, we located all of them except for one.  Update the found
> ones with their currently preferred address, and use the last known
> address to consolidate contributions by the lost person under a
> single entry.
>
> Helped-by: Stefan Beller <stefanbeller@googlemail.com>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
