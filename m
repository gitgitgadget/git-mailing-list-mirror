From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard file
Date: Thu, 28 Jul 2011 21:10:36 +0530
Message-ID: <CALkWK0npPDuovUav-7+ea_P=xXuzBCFv3sgH2GgT4Xu4gORUUQ@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-3-git-send-email-artagnon@gmail.com> <20110727054256.GA28821@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 28 17:41:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmSiT-0002Gm-Ju
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 17:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab1G1Pk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 11:40:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61081 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab1G1Pk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 11:40:57 -0400
Received: by wyg8 with SMTP id 8so223470wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qs1ogtrK1tTBjj+xowrm7h/5W+ggOqGz/eLQ4oCCrrs=;
        b=wmJu3B7/358e40JPtdD7l/Gxs/LeQJfWtX/aIDqsLdB2gTCtiZ4l4N2q5CxIQ1gtao
         QuZKWkHqBmbOLWJ9Ehw46JpGGiYDgT4EKLWcun6VLBERuzu+LqpvbnSaS/VwJjj9kjGu
         QcWNy2m24JGHOc75xwAXpMHwnoEekou+wr4wo=
Received: by 10.227.153.8 with SMTP id i8mr177775wbw.64.1311867656152; Thu, 28
 Jul 2011 08:40:56 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 08:40:36 -0700 (PDT)
In-Reply-To: <20110727054256.GA28821@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178070>

Hi,

Jeff King writes:
> Thanks, this one looks much nicer to me (though I also agree with
> Jonathan's style micronit).

Fixed.  Thanks.

-- Ram
