From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 10:45:52 +0100
Message-ID: <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 10:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLYOt-0000RE-D7
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 10:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0KYJpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 04:45:55 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46574 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab0KYJpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 04:45:54 -0500
Received: by fxm13 with SMTP id 13so591141fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HYw2NbqdGs/cKFyoPxRlpbVSDE+s/qvpaVQJECGP12c=;
        b=ZmWDqY3flLtr/fJevlBHqD69k7Yg0Jdvuq/fqcxn8zT+POEJ8MVE/yYjU5209IzEZd
         b57YsINIJvZ3HJwkyVwAMOQRmQgGWMW+N09KAPljDskBUcx1LTGaCL5wGX5jlUVrLc6N
         o7JxakvM3wRVYuagg/IbmzEKfLlpyMS0GN1ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZZ1VVC3f2aGGrupMdv5pRV12zcTReCXBy4guCDDE/Lcq1uUddqNI90C1nPWHgqw9E0
         odN8S/eKRLbb+gFhpm81sqyCtjARl173wTZeyB3arKgBotacAnOg1er63FAFJmWBFStE
         Nx3RXMQxjaliUpVYCvNlmY+c5liGRgzCSFEK8=
Received: by 10.223.93.142 with SMTP id v14mr475815fam.49.1290678352780; Thu,
 25 Nov 2010 01:45:52 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 01:45:52 -0800 (PST)
In-Reply-To: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162119>

On Thu, Nov 25, 2010 at 04:16, Junio C Hamano <gitster@pobox.com> wrote:

> It is getting ridiculously painful to keep re-resolving the conflicts with
> other topics in flight, even with the help with rerere.
>
> Needs a bit more minor work to get the basic code structure right.

Still waiting on input about what exactly needs to be fixed. See
<AANLkTikw0+FGJmj7C0B9J_3ZVXrbqCw+UzyP3sqfyVdm@mail.gmail.com.

Is there anything else than that (the builtin.h includes) that you
think needs work?
