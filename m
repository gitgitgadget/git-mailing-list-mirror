From: Eugene Sajine <euguess@gmail.com>
Subject: Re: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 13:56:11 -0400
Message-ID: <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
References: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 20:03:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Sez-0007uy-GJ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab0DZSDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:03:54 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:38405 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0DZSDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:03:52 -0400
Received: by qyk9 with SMTP id 9so17754350qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Vj6h1h8uJ31V++/KJPF4J0Sjby4peQwwo+TRpY6uqIo=;
        b=mEkkiVEcx8++S8l6/YHJSH3tnWS4j/LKi1Oio2RHd3+5+M4mxrtSJnR4MdPt2/Lp2i
         II4Fd+ZnqgO/dQgARa+nsiu8TRNCo/1+brqWSl5mamP+HT87fbZM73mMiq4nuoRmJYqA
         bvESkt6uS788HegRMqYY6LYF5g0baEKwc/tww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Z0ayN4KMxZjvvOnQPQa8ITtJOMW3+9OwsSjzj8hAgDuKd0g++W59WoLBI1sOjQYP9D
         GwHXSUYKuoc7p13WyoCSfLap2F+bgsR5b86I1cIOWViMKrOKYYtCGZQWGeRWUOyBp46s
         g2zAF76HUsL1pLGB8/h40on5tdqcMn04sJrM8=
Received: by 10.229.221.65 with SMTP id ib1mr5410633qcb.47.1272304571419; Mon, 
	26 Apr 2010 10:56:11 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Mon, 26 Apr 2010 10:56:11 -0700 (PDT)
In-Reply-To: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145837>

On Mon, Apr 26, 2010 at 1:54 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> I'm wondering if there is a way to get some repo information if the
> only thing i know is SHA-1 (no full path to the file)

I mean of course the SHA-1 of the blob, i.e. the result of git
hash-object some_file


Thanks,
Eugene
