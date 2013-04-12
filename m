From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2] Fix various typos and grammaros
Date: Fri, 12 Apr 2013 10:16:43 +0200
Message-ID: <5167C2EB.7010709@gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com> <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 10:17:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQZAO-00029T-5u
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 10:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab3DLIQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 04:16:49 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:60992 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab3DLIQr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 04:16:47 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so1110506eek.7
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=M+4wM2ZLB3ay9xh92as5oiGbjfwnGuSomAVRtPvBDWI=;
        b=yWQ6jR8O6wvC2B9IbTTNJdld8nXt9fFD1yC7TNdj6lmdh+Br10MRudq7PnpYrPNes3
         2/p4ZtxQgDVmXwV/NeMdcfDrnNNLDBwBGcULhnOkiPCb1TzdRrG22yGDa1TNWQDEjxnb
         JHtr2XdgGe/3VceZAMkE9UkssF2+Is3lnpMoSn3DEqv4RzQyQ/wH9j8B07IGGcTBhBac
         LKZQiDCa2xfIcq1aGsUMSpgDIXdZoArmbiC7GTvDQmlrDg3pWCG9dwvoWKn+zifBN6Qh
         zDKC5Ubyfhv/567zt62tNU/n/tUG1RiKlisVP+7mzodto/jP90yWXILIIWnVptWaccxL
         cBtg==
X-Received: by 10.15.48.4 with SMTP id g4mr25638270eew.28.1365754606130;
        Fri, 12 Apr 2013 01:16:46 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id u44sm9824184eel.7.2013.04.12.01.16.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 01:16:45 -0700 (PDT)
In-Reply-To: <7v4nfch90r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220971>

Hi Junio.

On 04/12/2013 02:45 AM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
> How much of this stuff have interact with real changes that are in
> flight, with various doneness cooking in different integration
> branches?
> 
I don't know, since I only follow the master branch of Git.  And
honestly, I don't have time right now to go checking for possible
conflicts, or to resubmit ...   But I see Jonathan has taken up
the ball on this (thanks Jonathan!), so I'll leave the matter to
him.

Next time I'll try to prepare a patch broken up in more digestible
pieces, so that it will be easier for you to deal with conflicts,
and/or to selectively decide which fixes are worth applying.

Thanks, and sorry for the confusion,
  Stefano
