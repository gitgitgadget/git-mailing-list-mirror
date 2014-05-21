From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:14:14 -0700
Message-ID: <20140521211414.GA13540@hudson.localdomain>
References: <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
 <20140520182443.GA30533@sigill.intra.peff.net>
 <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
 <20140521164255.GA2040@sigill.intra.peff.net>
 <xmqq61kzqbi6.fsf@gitster.dls.corp.google.com>
 <20140521175930.GA4588@sigill.intra.peff.net>
 <xmqqsio3ounp.fsf@gitster.dls.corp.google.com>
 <20140521204739.GA8381@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 23:14:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDqB-0002VK-3N
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbaEUVOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:14:19 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:50912 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaEUVOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:14:19 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so1780102pbb.35
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Sx6c1F/cFMfubSbZW43wu8mnc5V5ULf27KxHJAbsuA4=;
        b=MdAaV6rGmrHsV2fGRqLybL3eS/YrVlCsELqTj8Xx7cvjFooporstg+i1sVIXsXLOBp
         LU3xcqiSiTWMJ/lWrbCFwLJq2CDGat/g2rYofAeqIr0K+hPk0E+IsofgvbhJmAmVwIGZ
         fksjOBMXoGuvDdl6Lb73GSulOgUhp0gM6ZNOOjDddRzwxpGnn/9qUZFK5cFNmyORcceW
         6OLynbOHhmJhk1UkJ6V5mPtWSI6nmYkITLj/0BVJL2xdvWHpMw9RJ9lh2ONWzk4oraQM
         M/Ane7nZ2IGL7+UPYYM1qkgxy0ViqACYziBURJhE8+BixNALZ22y19H3p3FMeNil3cNL
         xY8Q==
X-Received: by 10.66.253.170 with SMTP id ab10mr62376201pad.53.1400706858575;
        Wed, 21 May 2014 14:14:18 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id av2sm9616065pbc.16.2014.05.21.14.14.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 14:14:17 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 14:14:14 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140521204739.GA8381@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249833>

On Wed, May 21, 2014 at 04:47:39PM -0400, Jeff King wrote:
> On Wed, May 21, 2014 at 11:26:18AM -0700, Junio C Hamano wrote:
> 
...
> I think the ratio of usefulness to number of words in this sub-thread is
> getting off. I'd be OK with any of:
...
> 
> -Peff

I think this has become a discussion about the airspeed of an unladen swallow.
:-)

I think we're close to a final patch. v7 sent.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
