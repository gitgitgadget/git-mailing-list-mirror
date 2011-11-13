From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Sun, 13 Nov 2011 18:41:05 +0100
Message-ID: <CACBZZX7VTdc2wHYHb1BB-wCJbKLVEmbzQaBTV04S1KDrqeN73A@mail.gmail.com>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: vinassa vinassa <vinassa.vinassa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 18:41:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPe3g-00008o-Eo
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 18:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab1KMRl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 12:41:28 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54857 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1KMRl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 12:41:27 -0500
Received: by bke11 with SMTP id 11so5067275bke.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bKGI3AHKDwH7Jay8ie6CpQqC6v1fRpdecg6B+/VdBOo=;
        b=dS3UHb8Yqj9FmkQzd59+JGXn9Tw9y+kosa183YexUXLvr7Wze+i66MEFwx6nPemPDw
         7wSnVWHoRz/0rTl4FQsTZN27ehWtyZ1P9dMEa6amY1ROW9GPAg/kaIqUsSr9AqZ1Xl48
         bHCHK/z8aUUcv4RqtJ95UUS6gSJs0L5Xf8y9I=
Received: by 10.205.124.134 with SMTP id go6mr8139760bkc.129.1321206086142;
 Sun, 13 Nov 2011 09:41:26 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Sun, 13 Nov 2011 09:41:05 -0800 (PST)
In-Reply-To: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185344>

This is not something you have to worry about, just get on with using
Git and stop worrying about phenomenally unlikely edge cases that are
never going to happen.
