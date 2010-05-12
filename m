From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 21:06:11 +0800
Message-ID: <AANLkTin0E9rd7Ld3exCA5NbGnYhlspUZ93KT1O6Zvzrq@mail.gmail.com>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	 <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	 <19428.24021.324557.517627@winooski.ccs.neu.edu>
	 <20100508044434.GC14998@coredump.intra.peff.net>
	 <19428.62170.654092.308682@winooski.ccs.neu.edu>
	 <20100508053025.GG14998@coredump.intra.peff.net>
	 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	 <19429.3589.823244.270582@winooski.ccs.neu.edu>
	 <20100512113855.GB23847@coredump.intra.peff.net>
	 <19434.39095.448649.313537@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 12 15:13:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCBkb-00019v-OO
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 15:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab0ELNNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 09:13:21 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:48700 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0ELNNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 09:13:20 -0400
Received: by qyk1 with SMTP id 1so9610326qyk.5
        for <git@vger.kernel.org>; Wed, 12 May 2010 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ra//tnxthlBMfqmWEQV0zUwgyoO+f1XS8J/Y1tpGUac=;
        b=GK7Xdy2sMqtWXjGby03fqmfTtd3inc0UhTTWi3X4YAwORRT87kW+/Jjqwa0QT30zVf
         Cvx/A7w1dIPx4ysMc0Wln7hqgkc6f5NfkdNCv3Vhi2+LvTWKf0iUoYiNZ92v69aXoVf+
         xL9wN+SURqFBbpel1LpWi7MuFEFqKbzirUG6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fs8awYCxjs8ROjhKWAX1iQ9yD0cSGQcgl1DFaocK5JfyNjOJO/rLVk7W6fTvIgxS4M
         xYZ0xGUtCdA/XGScKSTLRD8/qI+6/LXv5rW+s5hoqVQErbWj3CuopvPLCghw+/+hR6SI
         XDDvqVtTjC+GB5cNuzGVfN6vIKrGzmz5z84DU=
Received: by 10.224.18.218 with SMTP id x26mr4969656qaa.160.1273669571338; 
	Wed, 12 May 2010 06:06:11 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Wed, 12 May 2010 06:06:11 -0700 (PDT)
In-Reply-To: <19434.39095.448649.313537@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146946>

Hi,

On Wed, May 12, 2010 at 8:01 PM, Eli Barzilay <eli@barzilay.org> wrote:
>> I really wonder if it would be that hard to just fix the code to follow
>> several files. [...]
>
> That would obviously be a better solution...

The new line level history browser utility will follow multiple line
ranges of multiple files and it of course will do this. :) Please wait
for some days, I will make it possible in this summer.

Regards!
Bo
-- 
My blog: http://blog.morebits.org
