From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Thu, 18 Nov 2010 16:25:28 +0100
Message-ID: <AANLkTikLt+=ffsqY1=-fN49fVZ_Q4HVWnzn5qSftg=T3@mail.gmail.com>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
	<AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
	<4CE32062.6010308@gmail.com>
	<AANLkTimm2unZoUNH=wgnAFjPpeF_C=tJAZ0DkNK4mMv_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 16:25:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ6My-0005FJ-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 16:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758903Ab0KRPZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 10:25:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34754 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886Ab0KRPZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 10:25:30 -0500
Received: by fxm10 with SMTP id 10so14574fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 07:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Qb7BC9qdkYHyCBhQrfCxBoC/LKqfaxkTNqqLCHKbuuU=;
        b=CK2be2KT8Y5Dka0KUc3PKgixap6D4dwXwZRSVKu/2Sc1Gqd39gm1f+Nh0noNgX0H6k
         v9pwTv+LwVvEshWkyjCVyV00JNfgA3RddNgiaQdHWC0f58u2rxPsAqlHqztlULEz6WKE
         a3454XGAjfz7crFmxe9seiYb3+LRHvwQ97ovU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hVe+VlLDxBRmGk74d1VkdJFhKgIQoQVm0wdT4OGzd/JOAWISAVQT7xQtgLmDL05lSc
         uN7C1QcigzFegg74tD3kX11Ee8XNJivZNUEs262dbOyJ3wx8jASIz03HkdCMxp0xscHj
         YYUcICgqk//XNoR5A3tJz/tYSdSa/XFYE3alU=
Received: by 10.223.78.143 with SMTP id l15mr692512fak.30.1290093928460; Thu,
 18 Nov 2010 07:25:28 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 18 Nov 2010 07:25:28 -0800 (PST)
In-Reply-To: <AANLkTimm2unZoUNH=wgnAFjPpeF_C=tJAZ0DkNK4mMv_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161675>

On Thu, Nov 18, 2010 at 15:34, Dmitri Pissarenko
<dmitri.pissarenko@gmail.com> wrote:
> However, I had to give up this idea due to an "out of memory" error
> during bzr-export.

Buy more memory or use more swap?
