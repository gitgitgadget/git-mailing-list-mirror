From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 23:25:15 +0200
Message-ID: <CALWbr2wrHsa7LwZcEPYKe=kCrSHKsdrU6Bwevtb=2MwLrXtMnw@mail.gmail.com>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Joern Hees <dev@joernhees.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 23:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEQlP-0007RH-08
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 23:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab3H0VZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 17:25:17 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:40625 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab3H0VZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 17:25:16 -0400
Received: by mail-qc0-f181.google.com with SMTP id i17so895238qcy.12
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tXNgYrj1DqtWZnG9J/FEkVCBPE2+l8EdvFM+0rSOvAg=;
        b=S+X+C9SZUfETohQyrJhkM9NDRTyv/ePKXxH2a0l7NTd/6Q8QsaHz1tLOtea0hBybBp
         GE15F6kO6Rh2+TwwUCH8SmVFohq/zFgC6EdTUKgvpw9s3bbCY3eESKg9hGmLR/sToW2r
         4ytWZPUvc0dHwLMZ1Me84XUAhAzx0N7FS2Rrb+Ou2AGb6uZtrOyRKmfcAtcTB3+WF1Vm
         /hjyKEQIi8ZuDlxJcpshgXLPOWSLrrmIzuKsSlFUyCq2zDycOX1Zy+Pu7+t70CDqBefa
         AfrPFkpxL+iCUIsPEZxjjWccrYYRUQKWzzQYm2y8Y5H7hyxxOKuzSwCIjwty0Sn+YpzX
         ALOQ==
X-Received: by 10.224.138.8 with SMTP id y8mr25772865qat.27.1377638715963;
 Tue, 27 Aug 2013 14:25:15 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Tue, 27 Aug 2013 14:25:15 -0700 (PDT)
In-Reply-To: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233163>

On Tue, Aug 27, 2013 at 9:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * jh/remote-hg-fetch-fix (2013-07-25) 2 commits
>   (merged to 'next' on 2013-07-25 at 33161ad)
>  + Revert "remotes-hg: bugfix for fetching non local remotes"
>   (merged to 'next' on 2013-07-24 at 9c96641)
>  + remotes-hg: bugfix for fetching non local remotes
>
>  Originally merged to 'next' on 2013-07-25
>
>  Reverted.
>
>  Waiting for the final patch to replace, after discussion settles.

I think it has already been replaced by:

> * fc/remote-hg-shared-setup (2013-08-11) 2 commits
>   (merged to 'next' on 2013-08-14 at aae6858)
>  + remote-hg: add shared repo upgrade
>  + remote-hg: ensure shared repo is initialized
>
>  Originally merged to 'next' on 2013-08-14
>
>  Will cook in 'next'.
