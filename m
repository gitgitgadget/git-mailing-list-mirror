From: Ian Hilt <ian.hilt@gmail.com>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 19:02:12 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0805141856380.30187@sys-0.hiltweb.site>
References: <1210789855-29413-1-git-send-email-ian.hilt@gmail.com> <7v7idwoh9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:03:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwQ03-0004Cj-Cc
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 01:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbYENXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYENXCL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 19:02:11 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:59603 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYENXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 19:02:10 -0400
Received: by an-out-0708.google.com with SMTP id d40so31572and.103
        for <git@vger.kernel.org>; Wed, 14 May 2008 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type;
        bh=TovVdwsdqZwXNRdL/ZpFsFn7SlNv7JuKlVPj1kTqCtQ=;
        b=WTNPfTRkZ6fg/xNntFbvmu91/67Zw/7c+gXXgqI10ziFwxRlM9X4WeOxX7cx5C67JdUyohxpr/UKl7JdxMxyTLMRY7oH0z6rmpJ/NGbGhOikDz+BXKd8wQkRgXLZIQBL2He49uz+LMZiLN5SngvDgRaTTgeyQ+vHoKnMMg5tOvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type;
        b=HSBli0jpt9ImzkpRrt9TtDYWiNCi/KnD8eM7rP9hrRivvP32c8kwvGdxqNmcDEbt2y7cFuSJnx/RV/2q2rNWgN1lGYRHPfyStVVBuNiKGupNsKpwUokvZFsq/yhLVNGs/hNTGmBjNhz92r49hKq6/iD+QND62Yd+fZEcooVleM4=
Received: by 10.100.11.7 with SMTP id 7mr2193155ank.56.1210806129712;
        Wed, 14 May 2008 16:02:09 -0700 (PDT)
Received: from ?192.168.1.1? ( [75.185.208.72])
        by mx.google.com with ESMTPS id c39sm3844374anc.29.2008.05.14.16.02.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 16:02:09 -0700 (PDT)
In-Reply-To: <7v7idwoh9m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82158>

On Wed, 14 May 2008 at 11:46am -0700, Junio C Hamano wrote:

> Ian Hilt <ian.hilt@gmail.com> writes:
>
>> git-describe: Make description more readable.
>
> Thanks, both.  I think the above is meant to be on the Subject: line, and
> the text certainly is more readable.

This is probably a stupid question, but is that all you want for
a commit message?

-- 
Ian Hilt
ian.hilt (at) gmail.com
GnuPG key: 0x4AFC1EE3
