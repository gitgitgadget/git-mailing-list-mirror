From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Tabs and spaces
Date: Thu, 21 Apr 2011 12:46:04 +0200
Message-ID: <BANLkTimgVCh19saLiJJfFnoWKny8-MiHrA@mail.gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net> <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
 <20110421000701.GA10987@elie> <1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com>
 <20110421021825.GA23373@elie> <BANLkTi=XqynMpRkR=cRMTXYjr+p=Jxt=Ng@mail.gmail.com>
 <BANLkTin4kD96Fw_hpJCGW1K8Khfc=A=n_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Witten <mfwitten@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 12:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCrP4-0001dk-G8
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 12:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab1DUKq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 06:46:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42596 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab1DUKqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 06:46:25 -0400
Received: by bwz15 with SMTP id 15so1313366bwz.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HWFIETo5tHDFyxetpt9iLUm6PyDEoViOqb0zx8dHJ5o=;
        b=LmckaDz3NxkbUZLX1mYJMVidDTp1d6JdblYQF/j+l2aHNvECR/bIqB+VlaWpl79tkn
         bVbZrJfscT5nElGvpFNmvHcTUXqRmlULq5TzuQF7caVzbte1d1jvRz4NiGOwFzXUdAi8
         FU/uTeCKrrXwmnufIh/uCfAVK5b05773o6jOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GU5pBH0X+2oChfNTWPUmtb0t7TMy5js8jAAb8m4rEZmrscQAFNuyb/JpPLD+v1W8TW
         7XXggmA/7CsXw07auzzrwVEwaLNgt5fMs/pw6SoZOv+mB156uMQQC1gVVOPvlqo8e8El
         sRhfO5TugmbIkN/ytZxgop0BnGx8uk/beXvoc=
Received: by 10.204.130.16 with SMTP id q16mr4528936bks.192.1303382784145;
 Thu, 21 Apr 2011 03:46:24 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Thu, 21 Apr 2011 03:46:04 -0700 (PDT)
In-Reply-To: <BANLkTin4kD96Fw_hpJCGW1K8Khfc=A=n_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171900>

On Thu, Apr 21, 2011 at 05:25, Thiago Farina <tfransosi@gmail.com> wrote:
> On Thu, Apr 21, 2011 at 12:15 AM, Michael Witten <mfwitten@gmail.com> wrote:
>>> Oh, I still think a tabstop of 2 is insane (for various reasons, some
>>> explained in the thread you mentioned).
>>
> tabstop of 2 is what we use on Chromium code (with spaces, no tabs).

It's indentation. You indent your code by 2 space.
It has nothing to do with tabstop.
