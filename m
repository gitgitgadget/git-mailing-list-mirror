From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 13:40:24 -0500
Message-ID: <536d2118ee65c_2bd710c13082b@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
 <20140509015107.GA9787@sigill.intra.peff.net>
 <xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
 <536d142c3524_693d7fd30c9d@nysa.notmuch>
 <xmqq61lezv0f.fsf@gitster.dls.corp.google.com>
 <536d1c9cecc58_a3dedb2f03f@nysa.notmuch>
 <xmqq1tw2zty1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wipik-0003KK-I8
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbaEISka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:40:30 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:50530 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaEISka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:40:30 -0400
Received: by mail-yh0-f41.google.com with SMTP id f73so4182870yha.28
        for <git@vger.kernel.org>; Fri, 09 May 2014 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Aa7CShcpz2zkb4XH3YpkdVwF3s+Gm/VRH7QsHU4315w=;
        b=BDM4bu7JCNT0UBNUiN90eT02Lxb6UcKk23WvlohfJCFL7Ppm/d9ToQZ6R9T1kIOiEz
         6Asd+hcdhCE9LiRBF0nBELT1nG0YsXJpmJ7YLkGAWFcBke7zFhHSRkyogHxD7YuYSkxX
         H52IvmGfE3pspNMkUV07+83jubx9ok/7fS6TFq023u6XPSQSXyI3Yu/hz/6G6TIuFxxI
         Ut0t4kxyRdMHQesGpS/f0W5QI/AmmOcOtKeAOmOVwtxPA3CJtyy9DtVM2JAxz9RWygKX
         1KXWUSACVrJQVgwOhpEWm7DZFD+PQz3mHxE3WqQfzC/EdGpWTUaswoG8vTGr1T+w8V3y
         vhCQ==
X-Received: by 10.236.170.37 with SMTP id o25mr17185045yhl.145.1399660829672;
        Fri, 09 May 2014 11:40:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e4sm7287558yhe.42.2014.05.09.11.40.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 11:40:28 -0700 (PDT)
In-Reply-To: <xmqq1tw2zty1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248609>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > *You* said this[1]:
> >> 
> >> If you read the context you omitted from the quote, and realize that
> >> it was a counter-suggestion to give a middle ground to a more
> >> draconian "let's divide them into two", neither which I said I want
> >> to see go forward immediately, you see that this message does not
> >> deserve any response.
> >
> > So when you came with a guideline, that was only for git-remote-hg/bzr.
> 
> There is no guideline involved.

Exactly. It's all arbitrary.

-- 
Felipe Contreras
