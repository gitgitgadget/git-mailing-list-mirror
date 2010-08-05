From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: tc/checkout-B
Date: Thu, 5 Aug 2010 18:18:55 +0800
Message-ID: <AANLkTi=P9cyKhQeFx4V0NsCRe7-cqEWiJMcWk0Tc=BOH@mail.gmail.com>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
	<20100805065312.GB5318@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 12:19:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgxXR-0005ZM-Sa
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 12:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863Ab0HEKS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 06:18:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab0HEKSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 06:18:55 -0400
Received: by iwn33 with SMTP id 33so31155iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jq/SP1XXJXM62PZQRO7XB/8UP4OG08Bh9J+rpggVU/g=;
        b=tTgrnhgbnJMIpdJ5WDdQMd9PpjT8rU9VceU7L1ATXPLw+tOVdsMxJhw4gS1FifGgN1
         vWdkB56obWOuBdtVNzCtDyu4jFaRfH3ULU5MiDJ+2if5reRs024vNOYcbAfrPiXxbarg
         SYiSAIj4Jm60WMj119jNYTzsGj2/xR4doi3VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tJnQ6LiTH1lDcNvxz/B+YXhqYeXFCPWN2vOHkIJEs7T5+3E4pYMrLRbn9o2+gZ1th2
         IKPaZv7MOFDEC3jnMm+9DNPb7nbd3E5Zll1nh9XtC+w1vxcExaEyWgL384aFbqj11E5Q
         v6ni6OxY57qNGK7IZ7oz265qnLuSB4ZLJR9oI=
Received: by 10.231.32.200 with SMTP id e8mr12041519ibd.66.1281003535401; Thu, 
	05 Aug 2010 03:18:55 -0700 (PDT)
Received: by 10.231.151.130 with HTTP; Thu, 5 Aug 2010 03:18:55 -0700 (PDT)
In-Reply-To: <20100805065312.GB5318@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152631>

Hi,

On Thu, Aug 5, 2010 at 2:53 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Junio C Hamano wrote:
>
>> * tc/checkout-B (2010-06-24) 3 commits
>> =A0- builtin/checkout: learn -B
>> =A0- builtin/checkout: reword hint for -b
>> =A0- add tests for checkout -b
>
> I keep on trying to use this option and then remembering it wasn=92t =
merged
> yet. =A0So for what it=92s worth, I like it.

Thanks, glad to know this was useful to you.

--=20
Cheers,
Ray Chuan
