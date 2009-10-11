From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Merging non-git releases of a project
Date: Sun, 11 Oct 2009 11:32:23 -0400
Message-ID: <32541b130910110832t7e0b84adt806035bf151a16a0@mail.gmail.com>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com> 
	<32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com> 
	<26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com> 
	<32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com> 
	<26ae428a0910100158s5233841byd303377aa20eb45f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Sun Oct 11 17:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx0Sc-0000xR-8I
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 17:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZJKPdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbZJKPdU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 11:33:20 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:45515 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbZJKPdT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 11:33:19 -0400
Received: by yxe26 with SMTP id 26so2890698yxe.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fI635Desm2o40XbgMGmCj3fXY4Kdpwx8WBKyinDZxmY=;
        b=n/CCxnCT9G4z5q8OlYZ6cgCvjG4T668i7Tg7peEY7+qMB2XX2XK4LRZ7bhkxc+BnXX
         QS6P2RP6r83DjhxOJ8SAzqwpjoJ/yy3KESc2DwdE7xakaRR4pQ2VCiFD1UBR8v0f2K+c
         1zIlnrJM3KNFgmbHZ+zPMlaqTPrLAgVUBbUZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MFi9wDcLnQdLwhCSac44kxxepe01K/1S7yjE40QhygBuE8WPS0mXHMkQfGLlVDlvp4
         qANLuQcOenp4YYZKtopjh9LwEDUmqvW3tgPhFvyBfbn2Pkf4Fxcd2T88rGvfB1s030Br
         97yjvO1hNSSV7G1viLZqJmzQL/X5JahcwejDI=
Received: by 10.150.213.7 with SMTP id l7mr8287911ybg.220.1255275163500; Sun, 
	11 Oct 2009 08:32:43 -0700 (PDT)
In-Reply-To: <26ae428a0910100158s5233841byd303377aa20eb45f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129934>

On Sat, Oct 10, 2009 at 4:58 AM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I don't have cp -a (on a mac) but, IIRC, that's just -rp or somesuch?

You can obtain a non-stupid version of 'cp' (as well as 'ls' and
'grep' and 'find' and other useful tools) for your mac by using fink.
But yes.

Have fun,

Avery
