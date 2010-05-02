From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitweb: Add ignore rule for GITWEB-BUILD-OPTIONS
Date: Sun, 2 May 2010 16:13:57 +0200
Message-ID: <k2zfabb9a1e1005020713we8e8b581u76aaaac838239264@mail.gmail.com>
References: <y2wd2e97e801005020408w1e7407e0p1f7606eac101699b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 16:14:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ZwB-0002Gd-Th
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 16:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab0EBOOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 10:14:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:6611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab0EBOOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 10:14:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so729816fga.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qZFjDVHe0S0VdEAyox6FIxWCGv/gZv3MvL1boD8Sdg8=;
        b=DZvYDU/ubmcsaL4ub/70Qdui17hpl2DzMQTF8CBaYw60kBjjZQPOGmubtLx/bFfNrk
         qeszefXCGfaOCf2sXqyEMbT2jVXp+CnSaRRO+RamvD1ZYfe6apZR1jZnlgJZkwr22xOt
         1Ea1IATlvwg1vpVL5W7eNclG4oVOcNhZxqhtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AnujDn6Hur81/xykl4o5fJyj28sdpcH+/M/OZ5RsLijVzBmROSr8EWONxSKsagXR8Z
         9anIgrOd57FWX2bIyKjiPaerzD4mw2s/thN4vFrvlQLiovMAfh1YuhYo8LWZG1X0OHOm
         sihrNrE6EmtMdKcMiKw0in69OH9H+hQlye+VU=
Received: by 10.102.198.39 with SMTP id v39mr7960059muf.129.1272809658209; 
	Sun, 02 May 2010 07:14:18 -0700 (PDT)
Received: by 10.103.107.13 with HTTP; Sun, 2 May 2010 07:13:57 -0700 (PDT)
In-Reply-To: <y2wd2e97e801005020408w1e7407e0p1f7606eac101699b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146177>

Heya,

On Sun, May 2, 2010 at 13:08, Michael Wookey <michaelwookey@gmail.com> wrote:
> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>

I sent this patch around a week ago, but it hasn't been applied yet, Junio?

-- 
Cheers,

Sverre Rabbelier
