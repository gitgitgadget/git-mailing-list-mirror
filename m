From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 04:04:27 -0500
Message-ID: <5364b11b4db8d_1996f531068@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
 <87iopnwa2i.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>, Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sat May 03 11:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgW2c-0001mC-29
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 11:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbaECJPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 05:15:09 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:48666 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaECJPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 05:15:08 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so6364146obc.35
        for <git@vger.kernel.org>; Sat, 03 May 2014 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=m7biEn8uP/ARG3De4k0ImynHjEIcpEz4tZULDzGJ3Vs=;
        b=U7iA06ocUihIOcAtmQ6MHNiPlzCqbDBWT+eGnkH2sHTThwmN0zrOySrzR8SnaPDGco
         H5tF3SH0bW2Kdg0yGggI5KwoMvhTL04wcJsbB5qsWEJeMPFaXwrkPNkDHCkgGJBXMyop
         kSPskVvt5EahBj/T6uyGO9J5n0dZq8KW2ahVjYDIwFGpvkHK3w1r/kdQ2DEOVoeJZW5R
         +uOGRkoNSMsp0zP819MmGDXvXEzSM87CWLt/ah4gwy7Ky5uiUXsrFK3VWxnYUoPGFZZf
         mIz6M/PrEIqejv+aArTRt3FYZlFYDvSxl4+uimLTpntVy6Cvr8qR/hYLIYjZ9U7HKXVY
         6YgQ==
X-Received: by 10.60.133.17 with SMTP id oy17mr21364627oeb.51.1399108507757;
        Sat, 03 May 2014 02:15:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pz8sm3937024obc.11.2014.05.03.02.15.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 02:15:06 -0700 (PDT)
In-Reply-To: <87iopnwa2i.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248029>

David Kastrup wrote:
> Richard Hansen <rhansen@bbn.com> writes:
> 
> > These three usage patterns are at odds; it's hard to change the
> > default behavior of 'git pull' to favor one usage case without
> > harming another.  Perhaps this is why there's so much disagreement
> > about what 'git pull' should do.
> 
> Should a screwdriver be turning clockwise or counterclockwise by
> default?  There are valid arguments for either.

If you don't have anything to contribute don't disturb the people that
actually care and are trying to improve Git. Thanks.

-- 
Felipe Contreras
