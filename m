From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 13:21:16 -0500
Message-ID: <536d1c9cecc58_a3dedb2f03f@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
 <20140509015107.GA9787@sigill.intra.peff.net>
 <xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
 <536d142c3524_693d7fd30c9d@nysa.notmuch>
 <xmqq61lezv0f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:21:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WipQF-0000Nn-9q
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbaEISVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:21:23 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:60493 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186AbaEISVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:21:23 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so4138526yho.29
        for <git@vger.kernel.org>; Fri, 09 May 2014 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DmIC8mRrNXno7qEZFfPFSKN3sfkYZcbkjn9ST076ctc=;
        b=Ek/0HDQOqjSedzuew1ho1pz9hY991UJ3nuEXgD2BW3XjFqB2MaTw3sYi8J223n6mFP
         QwZfNn9Fl1+dppqI43aiaG3TcViLmvI+Vnm0Yjyuirgzdh6QQMiavMdyFAnVGHu7uXwl
         UtVTpceLK5Pg4gdz/R5Z/abm1P6M7LdOzaHAEIzKVQ50F8w+qVtW+YMnmPxVm06osMYO
         iiHbYPrSCTCai/ErkZfHNb5KHCpbYGc2MzTS6MB8bAzLX8ReuxVDDnid0tClaDCmOm2K
         sLb1485pGZ1FIV+/3YJlm11CM51BmZb5zcGaTO+jSbol1oSowQadRblpVWWlDy30ArTY
         4fhA==
X-Received: by 10.236.11.113 with SMTP id 77mr17358820yhw.70.1399659682675;
        Fri, 09 May 2014 11:21:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e64sm7224629yhc.27.2014.05.09.11.21.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 11:21:20 -0700 (PDT)
In-Reply-To: <xmqq61lezv0f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248605>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > *You* said this[1]:
> 
> If you read the context you omitted from the quote, and realize that
> it was a counter-suggestion to give a middle ground to a more
> draconian "let's divide them into two", neither which I said I want
> to see go forward immediately, you see that this message does not
> deserve any response.

So when you came with a guideline, that was only for git-remote-hg/bzr.
If you apply that guideline to other tools, you would have to remove
them too, but that won't happen regarlesss of how crappy or well
maintained they are out-of-tree already.

Why? Because you say so. OK.

-- 
Felipe Contreras
