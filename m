From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Git 1.7.12 installer blocked by Gatekeeper - needs signing with
 an Apple developer ID
Date: Wed, 19 Sep 2012 16:57:09 -0700
Message-ID: <CAJsNXTkeNWkd9yJZk04g52ktct8HdVD3tJGD=YhfQHyiQ7=trA@mail.gmail.com>
References: <954DDAEA-30AF-4203-BD49-3AB163E4EF58@telenet.be>
	<7vr4pxhqb5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Torsten Louland <torsten.louland@telenet.be>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEU97-0007Rt-FK
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab2ISX5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:57:12 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48540 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab2ISX5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:57:11 -0400
Received: by lbbgj3 with SMTP id gj3so1688429lbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 16:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=u4Vb13qKOrM1rglWft+C0MPqbVBnwGuZ3pq91P8YPvw=;
        b=ZO1bHEpi3F28nMcJX2wEq+GAKAKyqK4FQzeLaoSjNWniJKCOZ47cE3IIoVVTFwPqwW
         LrK6GqqN5999bOmeqjDYvm6ySgBiSEWbuQkJ/XgyPktk7cm1Kemd0zHlpjmhTYiyr0D/
         4bxGvMxw3Rj9vqwVkUYgKadYvV3I7NCWUVr69Lv05e5/GSlXTZtPNdRdxSFE5sNS+Mle
         HNiVhYJNFWBaEvmAMtASWiEuXIxB4CA4FQ/gLF3tjapLb9FLV7QpAsPLPnSWJ+2hpuay
         MomAVR3DoNRuEKnnp79Tiio1mDaylxKi8rTnTZtJCAMefN0s6YstAMpU57qs9iLVuSFv
         lEuQ==
Received: by 10.112.31.197 with SMTP id c5mr102808lbi.50.1348099029500; Wed,
 19 Sep 2012 16:57:09 -0700 (PDT)
Received: by 10.112.57.16 with HTTP; Wed, 19 Sep 2012 16:57:09 -0700 (PDT)
In-Reply-To: <7vr4pxhqb5.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ve7XsnFP9_BpNwRSV-vnX9Iv8ww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206016>

On Wed, Sep 19, 2012 at 10:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Torsten Louland <torsten.louland@telenet.be> writes:
>
>> Installing latest stable git on Mac OS X Mountain Lion is blocked
>> by Gatekeeper.
>>
>> Could you provide an installer for latest stable git that is
>> signed with an Apple issued developer ID so gatekeeper will let it
>> through?
[...]
> Whoever you are, please speak up and help Torsten and fellow MacOS
> folks.

One could argue that anyone whose system requires applications to be
signed with a key that the system owner does not possess is beyond
help.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
