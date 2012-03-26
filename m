From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Merge-friendly text-based data storage
Date: Mon, 26 Mar 2012 21:06:30 +0200
Message-ID: <CAD77+gQVDtoK0vJnSgX-+i9EeJo6QErUGuzd25_cfBmUfPvW4g@mail.gmail.com>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
 <7vfwcvp6pi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:06:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFFp-00042b-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094Ab2CZTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:06:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42223 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab2CZTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:06:52 -0400
Received: by lbbgm6 with SMTP id gm6so4231418lbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xHv7sk65pXmUA08VsH6SvNIIQSmiGyAfO1szOj7nU4A=;
        b=JNvewjMf9S4EK4H/Ppg3UKndMkGcDZjkyfBtURQfMj4AJrlCMeJDgKEFv7FLECHLEN
         1R36Pvn1QymvoF7bezrst0/Vf2MwGmgve50V1HN6NoVGuouWkv4M3+CL737uiiuZHdHT
         6PGXr4c6O48krghrgiesYhPIXepawkvNXJ0b5HhLMVOdaI+09D9+sqDCuiwWR7xLQsWt
         Cv/hPW3gZwyiPF4zACnxTMhsDbPaPBC9vIMKw38pcgUEaUpwt2aPyr0ibHu66uq86G/f
         VN40AdmtSNb5b1vdDfAhFg3iI3dOc07YqNPdDbzZaUPR/lCpOsd1I++N6YGp4QcWcVyH
         cI6w==
Received: by 10.152.131.66 with SMTP id ok2mr17134309lab.10.1332788810927;
 Mon, 26 Mar 2012 12:06:50 -0700 (PDT)
Received: by 10.112.99.233 with HTTP; Mon, 26 Mar 2012 12:06:30 -0700 (PDT)
In-Reply-To: <7vfwcvp6pi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193956>

On Mon, Mar 26, 2012 at 20:17, Junio C Hamano <gitster@pobox.com> wrote:

> It may be of interest to run "git help attributes" and read up on
> "Defining a custom merge driver" section.

Sounds good, thanks.

My file layout looks fine?


-- 
Richard
