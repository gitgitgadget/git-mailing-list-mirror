From: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Thu, 18 Nov 2010 15:34:55 +0100
Message-ID: <AANLkTimm2unZoUNH=wgnAFjPpeF_C=tJAZ0DkNK4mMv_@mail.gmail.com>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
	<AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
	<4CE32062.6010308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 15:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ5Zz-0000qP-Be
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 15:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994Ab0KROfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 09:35:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62669 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948Ab0KROfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 09:35:07 -0500
Received: by wwa36 with SMTP id 36so3404892wwa.1
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3rOu5flAarNVUdRoUVrZVCPUxGwCzDLgcru98YeRe1M=;
        b=l3RC2QRlK/YT98qk11WomhKOfjXnR3aGKCtmGGCSpyk2HmgXbJUEFGQahGAajnYeWO
         MAIi4GLVZ5HWWmOrfItuIfM2xv37iKwzDQupSn6c64s9rGJJiCMlI4/oG6TdCdi7ezXJ
         WZE4f/FLgWttIIwPOoz1lSLDXRd3f9CnjhzaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gD/e/WrrO8kY1+bu9VQgHXH0ZETFs5uloC2hkfeeaxar8ctULfk2Sm46DZunU8KCef
         rl7XJk4Jlnz4qMX2FxYKjqffsQ1kTfV+8OHj1wr8vulZAzZr9ND402aMe5Ka2mhG5vxR
         HeFHxGjDUKuJUg/169xd/99qCFxBm/v7OBCsM=
Received: by 10.227.148.17 with SMTP id n17mr710730wbv.223.1290090895476; Thu,
 18 Nov 2010 06:34:55 -0800 (PST)
Received: by 10.227.27.131 with HTTP; Thu, 18 Nov 2010 06:34:55 -0800 (PST)
In-Reply-To: <4CE32062.6010308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161672>

Hello!

Thanks for your answers!

However, I had to give up this idea due to an "out of memory" error
during bzr-export.

Best regards

Dmitri
