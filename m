From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] commit, status: #comment diff output in verbose mode
Date: Thu, 3 Mar 2011 12:25:59 +0100
Message-ID: <AANLkTinDWTEM4C2tkCyEa3zgrFNceUJW_qw7Bj94HDvL@mail.gmail.com>
References: <AANLkTikzgGY8Fryfc7n2MYiL8ZvY1Vr0cj4QStAypwBf@mail.gmail.com> <1299151419-16027-1-git-send-email-icomfort@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Ian Ward Comfort <icomfort@stanford.edu>
X-From: git-owner@vger.kernel.org Thu Mar 03 12:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv6g9-0005B0-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 12:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab1CCL0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 06:26:40 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34116 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab1CCL0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 06:26:39 -0500
Received: by yxs7 with SMTP id 7so326372yxs.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 03:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HiJ8Cj4Dr+uiHRyJnr068+wIFCXVL5kijsRo65Qjx/w=;
        b=unoZsNXBM5ekELGcitBaCSPcOQ7G53jhk5oNdbrTDhWsTMDcPujsBguNBtrc8KdC8o
         gxBvbkaM2L3G66xLOwsRH/QU8CLQ4pLu2a46chnU/8QAyIuwv5i25jCUdzVvFnOiC4pW
         bn8zuy63cHlI1i9Jv+eVoTL3VmKINUFSNxDaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=o9d9leiaEJSxLXYfGiYPniCr9a71ydTdS6y1KK7OCNlM9b7pD15OGpyTcjZOeSgZsU
         l7lzPWfffiLfeB/mIGlxkzGFZOzWNA2sldtFANA8FVhy1eIKkD34t6f5EaJZRHTFj+W6
         iDaP1PdfuzstHGsE20gg8ovU75Y6EromAuMVo=
Received: by 10.150.218.16 with SMTP id q16mr1582050ybg.349.1299151599122;
 Thu, 03 Mar 2011 03:26:39 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Thu, 3 Mar 2011 03:25:59 -0800 (PST)
In-Reply-To: <1299151419-16027-1-git-send-email-icomfort@stanford.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168386>

Heya,

On Thu, Mar 3, 2011 at 12:23, Ian Ward Comfort <icomfort@stanford.edu> wrote:
> How about something like this?

Yup, that's what I meant :)

-- 
Cheers,

Sverre Rabbelier
