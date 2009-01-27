From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Building Documentation in Cygwin
Date: Tue, 27 Jan 2009 13:27:54 -0500
Message-ID: <c115fd3c0901271027s61a33273lfe9dd702a66aac6@mail.gmail.com>
References: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
	 <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
	 <c115fd3c0901270944p7a4b6cc5n5dfe9b2f268f038c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsgc-00008p-Te
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZA0S15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbZA0S15
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:27:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:4069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZA0S15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:27:57 -0500
Received: by fg-out-1718.google.com with SMTP id 13so230970fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 10:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ipuwy+3RcRiLB2RlLxaDPXpMSw27vGYUGvKAyPbrdpI=;
        b=czWnzEvghkWtOFXbFwz08hEFyGey9DfoURzS3w0Bsk1pp5SV7vS4P96pmWfV/T/bsH
         ti1COcQw6SGuccW1JQgMR+qYyIVjMxMUYRvplWs6QP3V0fNSUTVKdc4Ct90TBIao4qfF
         5l2SA614LRg94pPg15u9yElUZKYd5KwKVL4zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qaWg4GzlTA+o7WX6QO4HZvidelIRj/KYTmhAJ8yJFbe8RlN3dQPPPRV4XGsA+jz61h
         jYs20gu/F16zSAh3u6Kn1Q4KeeWdBYBM03xk14xGdoGwYDhoZpeTEt2OG917xJ8GL9fX
         oZln6TvbTc4yVcjgkj2a+pe8dIhuqJd7iYcjA=
Received: by 10.181.146.14 with SMTP id y14mr1226911bkn.70.1233080874592; Tue, 
	27 Jan 2009 10:27:54 -0800 (PST)
In-Reply-To: <c115fd3c0901270944p7a4b6cc5n5dfe9b2f268f038c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107380>

On Tue, Jan 27, 2009 at 12:44 PM, Tim Visher <tim.visher@gmail.com> wrote:

>> you might also want to try getting the cygwin package docbook-xml42.
>
> Sure enough, I didn't have that installed.  Turns out I should've done
> that part first too, as it appears to have fixed my problem.  Thanks
> so much!

Well, I take that back.  I built the docs successfully on the machine
that is connected to the net.  I couldn't build them on the offline
box.  Currently my solution is to build them on this box and then
manually move them over to the offline box.  It'd be nice to not have
to do this though... :\

Anyway, further help is appreciated! :)

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
