From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 12/14] remote-hg: add biridectional tests
Date: Tue, 30 Oct 2012 05:49:19 +0100
Message-ID: <CAMP44s27Sw1ohCRkvqBwWgfs5A4THiy1-c1CDjXjVbLUp2_Q0A@mail.gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
	<1351571736-4682-13-git-send-email-felipe.contreras@gmail.com>
	<CAPc5daUuCsiQd4MoQzQm_aQ6c88b_E8vYfA5btXMW4yCBX8E=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:49:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3lc-0003JH-Nn
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab2J3EtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:49:20 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46701 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2J3EtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:49:19 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5455607oag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ibj9j5cjtkW/fijz/D69FoJeZzOmPd4laHAaM+l+ghs=;
        b=Q9nu4soa9At6qtb2Q0lbv9nMyldIUh4zK2In9MPS12XTj7I4EwHQ8ahVM6tdjVynNK
         TURwBiWbshT8jqBI5H4CsDtiXZ/pcC6d0Kt3NtgOQNArSifKydrfoVtzMzJLctOICL1R
         XRZCSHsOUSj2PW20yjHdIBfN6W8/0S/lf5e+mLRM2o2kGBB2NSs3VhqBOVoUe+w4g3gy
         yUrWpRLEYvGuDf1YVaFToqfxQHM+Geto3YZg+Njc7wlOwyrW1ZtTDzbC6EQEvjIM/icA
         IRB7MHbOwFDVpPPguQVZ22eWrsvFte6CMYSc+YzKdZfHUNjYCpTkBfF6LRtwjbUdH/Ug
         u++Q==
Received: by 10.60.32.5 with SMTP id e5mr8864398oei.46.1351572559059; Mon, 29
 Oct 2012 21:49:19 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 29 Oct 2012 21:49:19 -0700 (PDT)
In-Reply-To: <CAPc5daUuCsiQd4MoQzQm_aQ6c88b_E8vYfA5btXMW4yCBX8E=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208680>

On Tue, Oct 30, 2012 at 5:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> What's the copyright status of the part this borrows from? Is there an
> in-file copyright notice needed to *name* the original author?
>
> The set-up part may become easier to read if done with here document.
>
> Pardon terseness, typo and HTML from a tablet.

I'm the original author. Some chunks are borrowed from the hg-git
project, but they had no copyright, I'll contact them and ask.

Cheers.

-- 
Felipe Contreras
