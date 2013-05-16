From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-export: trivial cleanup
Date: Thu, 16 May 2013 04:18:17 -0500
Message-ID: <CAMP44s1jk=P=UhvwL_XzroqtneVDduZokYQb17qah9Z28HjT_g@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 11:18:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuKO-0006I6-6f
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab3EPJSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:18:20 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:62084 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab3EPJST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:18:19 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so823896lab.38
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=+UcOoILOgiPEoOPKSqM4ou1JMzFqCQsPw6GF5ppqkvI=;
        b=EZeKkShhZJLgHOCYP7Pc+l4aFtcDBNQSMxuHr3y3uDY9kn4j0u+5z5ppHDkRyIJRhc
         QpGmf/fwqQo0X72szHZEVN4WfYJTXKMRDjhlByUVCoeNOo3u1B/MTc3jg01w12bekmti
         SXvTKQ5Be8bm0+pEHOK9521y9oMDjGfmHUjWK7S/qP8SpxIMgzpgAVh3ldmXG1E9EkiO
         LIwhZ3tgiLhJKl5ZezqRuRU3cSWcIWK9lSexd5CCwialW/SL4XsTSWW8+/yBaANs0bZV
         m7dYUthzhktRK5hpONDABOYGDdXRki0IFB9Ll5D+b3DvAh99s6d8Pd7xardtALSpusFw
         Ek2w==
X-Received: by 10.112.63.169 with SMTP id h9mr4760751lbs.135.1368695897671;
 Thu, 16 May 2013 02:18:17 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:18:17 -0700 (PDT)
In-Reply-To: <1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224519>

On Wed, May 8, 2013 at 8:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Cast the object to a commit, only to get the object back?

I'm dropping this one.

-- 
Felipe Contreras
