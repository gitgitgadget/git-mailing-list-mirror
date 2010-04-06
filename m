From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 0/7 (v5)] rev-cache
Date: Tue, 6 Apr 2010 12:14:59 +0200
Message-ID: <j2t6672d0161004060314j526e6d4q905bf427063b605f@mail.gmail.com>
References: <4BBA40B7.1060100@gmail.com>
	 <7vaathjcru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org\"" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 12:22:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz5v0-0004jk-3i
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 12:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab0DFKV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 06:21:56 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44737 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab0DFKVz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 06:21:55 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2010 06:21:55 EDT
Received: by bwz25 with SMTP id 25so3514317bwz.28
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mJza4+wU2fVEycRoKaLBWY0a5IlUL+d5801VkgjHeSU=;
        b=wlCwGPOKK0sUcgPXF4TPn5w9/H1foCIOYRYLxmZX1lsKeLOCCB1ZIbE8zLV3ukaNBA
         gCioE0zTOOqFtXAQjqDKOl5IPTPEjGlDwIxVsfs+lQRZYJsWxhez/GaY8dGbKZdfD7dR
         Ep/BxsBQRk/01+EN5iwXVvi5hC8R+jFyz71s8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OtYHrjbVHEq8fN5j4e0ubYVWBiToBnIfi3Pq43suPTTOTmxGvlWoRYbGpmicwhID3K
         5QQkdanlICY+Lbvr78pTKtdo7oneGBqSu5gByvGjr01fdvti3jh4DkURgKiLRK4X1RVj
         5QgiRTBPmB0xPaLBpk/b6vEqxKppieELYhBHc=
Received: by 10.204.101.130 with HTTP; Tue, 6 Apr 2010 03:14:59 -0700 (PDT)
In-Reply-To: <7vaathjcru.fsf@alter.siamese.dyndns.org>
Received: by 10.204.13.68 with SMTP id b4mr7966721bka.133.1270548899305; Tue, 
	06 Apr 2010 03:14:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144125>

2010/4/6 Junio C Hamano <gitster@pobox.com>:

> So don't take this as a complaint; it is unfair to call this a bug.  =
But
> it certainly feels like it is in the same area that can be improved.

Yes, I agree. I'll have a look.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
