From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 22:43:20 +0530
Message-ID: <CALkWK0mUcJ1f0xP2w-fUFr-tMSKMX23_nmYQUYXw3zjw7Hm9GQ@mail.gmail.com>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org> <CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
 <7vk3lno40x.fsf@alter.siamese.dyndns.org> <CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
 <7vtxkrmlz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:14:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4uk-0007pY-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423529Ab3FUROG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 13:14:06 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:54455 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423506Ab3FUROD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 13:14:03 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so3509060bkc.16
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OHkZ0KfgJiR+Jx35NMECFsD+VLNrLbihjTlW+X1zoIk=;
        b=N9AIN0gk6jwswLGPhgaHRivC9r3TCaY0IDNVLOAOlE8NI+uBc3jeVg6h/kCzmcXw4A
         ZnoXsiUSkcY28iCcMKCNh8eKW4ixIheM36AIzo61g0vJuGJt1LwXjKVwLyaEL+8SfKM7
         gcyESFrjdmT4I/hYNU8lHKwJZjO8h+TzkEUA3AZ00qEbK/UXngSJZA13+k3YiOfQ1Alv
         NsK0CPwUclM0Q4g4628AxEqkERhVIaz1BJj73QHK8UM1GJPf14BRv9fgwDY2gWJ6zhZf
         SCRdbLrFsa8KBiJzA5f/PNChqYo61fAjqc28B+dwiWtx4Gugaz4Z+TfrpUK44YF0l7c1
         OZtQ==
X-Received: by 10.204.240.79 with SMTP id kz15mr1953430bkb.112.1371834842227;
 Fri, 21 Jun 2013 10:14:02 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 21 Jun 2013 10:13:20 -0700 (PDT)
In-Reply-To: <7vtxkrmlz5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228636>

Junio C Hamano wrote:
>> ...  I've noticed a significant decline in
>> list-reviews in general: a lot of good code on the list hasn't been
>> reviewed.
>
> Hmph, I do not particularly see that happening.

Observer bias.  To verify either claim, could you run some stats on
the ML archives [1] and report the results?

[1]: I lost the copy Peff gave me because I kept it locally.
