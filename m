From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] request-pull: Include newline in output
Date: Wed, 09 Feb 2011 22:35:06 +0000
Message-ID: <4d531707.9104df0a.4da1.386e@mx.google.com>
References: <4d51fd61.8937e30a.096e.0a65@mx.google.com>
	<7vr5bgoow3.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 23:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnIek-0000DS-Kb
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 23:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab1BIWg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 17:36:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab1BIWg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 17:36:57 -0500
Received: by fxm20 with SMTP id 20so738964fxm.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 14:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:subject:from:to:cc:date:in-reply-to
         :references;
        bh=bio73cRRuCu0rvLWhBS+uUkA46AVbmdU7ojsCNLLodU=;
        b=K6hfxHeRk6o1wRcWa+S/R+GNEFhnpaH8JdMB5B3YZrsHGqfP+ErI1QMwX/zy4pqSsp
         /cbUXWF6kxlSz2r2JLdBbc4OF+Kf8H4dGH4CazluIDp2mEPnNSyAWnIvQyureh5uabDn
         ZOqAvXlFd6M7F9LjocVP5qhnnPkSpZmyCxWwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:cc:date:in-reply-to:references;
        b=bPvteGoPEq0HfeXk3oXViaSjoWJvfsGC3kIp7HH16Ha+xEN7Nfu/snNb9v4GlyqMlH
         ewvr7zKKmsht8aVHuRj/Q3qh5GNjephKOwDl2qv03jjFMBUsEimPhtRgQ1RaAbBL4zHs
         U+aKMd/8AtSFcjUC+z4x9yXC7vaymWveZPcEE=
Received: by 10.223.103.5 with SMTP id i5mr3204934fao.38.1297291015992;
        Wed, 09 Feb 2011 14:36:55 -0800 (PST)
Received: from gmail.com ([217.114.211.20])
        by mx.google.com with ESMTPS id 17sm422174far.19.2011.02.09.14.36.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 14:36:55 -0800 (PST)
In-Reply-To: <7vr5bgoow3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166449>

On Wed, 09 Feb 2011 13:54:04 -0800, Junio C Hamano wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> Date: Tue, 9 Feb 2011 02:17:47 +0000
>
> WTH?

Woops! I typed that by hand...

Make that 'Wed'.
