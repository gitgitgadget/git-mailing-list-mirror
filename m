From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 14:59:29 +0200
Message-ID: <CALKQrgdVf_rfsLu1NnXGk+LCTV34T-4doJ+2yyi69ZER8vTAfg@mail.gmail.com>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 15 14:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcbIx-0005Vt-O5
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 14:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679Ab3EOM7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 08:59:35 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:56165 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510Ab3EOM7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 08:59:35 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcbIr-000Cp5-Kh
	for git@vger.kernel.org; Wed, 15 May 2013 14:59:33 +0200
Received: from mail-ob0-f171.google.com ([209.85.214.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcZ5K-000KXF-BG
	for git@vger.kernel.org; Wed, 15 May 2013 12:37:26 +0200
Received: by mail-ob0-f171.google.com with SMTP id ef5so1918185obb.2
        for <git@vger.kernel.org>; Wed, 15 May 2013 05:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JM+xWqCUn/MPqmRjwslHCzIjXO/9Zsy3Dmv2V6HRILc=;
        b=DwoVeV9WkIRIMH/ej4UNAjaXlZyWf5mDaTYeKYB25lAVOC8NAE9/NNMDTxYTTd5a8Q
         dg0J6vxE/k+CeJ8UOiifXY3GiAz37mI+auwTAotKGe7W+BvC85a3Fb2dEC3vXHLH6xT3
         W0xMdbKAwtdJ2SysFWfmnojSsLQ7SJYkOjQq5JqucGo+9l3nxLyALVzi1KVSk6V28V+P
         IAySvKzEWd09HYkw1merN7j3nvEXxWPr3bbsy2ucQcRASzOfHhtAQALP7qDhHVdwnuAu
         7LaWA+cbMsT4cLDa0uVCW3Ll3tit2P8lM8pSWZO9FUsLTvQP9jttnMQcTk38p+hYX/ns
         4BpA==
X-Received: by 10.60.80.197 with SMTP id t5mr16390759oex.1.1368622769916; Wed,
 15 May 2013 05:59:29 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Wed, 15 May 2013 05:59:29 -0700 (PDT)
In-Reply-To: <1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224403>

On Wed, May 15, 2013 at 2:09 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Reviewed and supported-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
