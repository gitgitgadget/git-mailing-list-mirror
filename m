From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #04; Wed, 16)
Date: Thu, 17 Feb 2011 04:06:58 -0800 (PST)
Message-ID: <m3aahu987n.fsf@localhost.localdomain>
References: <7vk4gzh8cd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:07:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2dZ-0005rL-KL
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab1BQMHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:07:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39866 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab1BQMHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:07:02 -0500
Received: by eye27 with SMTP id 27so1305393eye.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=wpxZDnfpRUj1D3yXCNZtsuqpxxOG55B0oSC8tD5jfGg=;
        b=bC/esyW3bYIgCXpeHmp/1ztI2q/Z2moyKjsrr5ODeoJLjL8bH4IybyNHZcPOkW+d8I
         l6mmtavJmgQ0YrBK9uqXDa6fQOtsF0Tko+o3/cipYTJ4fxuZj/5bMErV2eegMpQlr6dU
         yzhs5OPJGZmyAjyt9yeXgp6ZIWpol9Px75m8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=PA9Z/QWc3ZV+F0jpA61dct2GKrqlcKwvZ3ZP764znFo7a2yKp6NwPJOnroKG7Wuy+z
         mjDhlcuGG0LNKanYzbH1+mXoEqtexHxdRFdRDGfc8spMM+poJUsSb3TIG+L7UuDlbv/2
         FeW4SY3Yz4PDgNNVRxb2ZS9juPVse1+5hZW4Q=
Received: by 10.213.16.79 with SMTP id n15mr2110323eba.69.1297944421408;
        Thu, 17 Feb 2011 04:07:01 -0800 (PST)
Received: from localhost.localdomain (abwj70.neoplus.adsl.tpnet.pl [83.8.233.70])
        by mx.google.com with ESMTPS id t5sm797123eeh.8.2011.02.17.04.06.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 04:06:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1HC6QvZ022846;
	Thu, 17 Feb 2011 13:06:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1HC65O7022842;
	Thu, 17 Feb 2011 13:06:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk4gzh8cd.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167072>

Junio C Hamano <gitster@pobox.com> writes:

> * mg/placeholders-are-lowercase (2011-02-15) 4 commits
>  - Make <identifier> lowercase as per CodingGuidelines
>  - Make <identifier> lowercase as per CodingGuidelines
>  - Make <identifier> lowercase as per CodingGuidelines
>  - CodingGuidelines: downcase placeholders in usage messages
> 
> Will merge to 'next'.

Hmmm... three different commits with the _same_ subject?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
