From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-submodule - possibly use remote branch to describe
 a module
Date: Mon, 14 Apr 2008 21:55:37 -0400
Message-ID: <48040B19.5030800@gmail.com>
References: <1208217154-992-1-git-send-email-mlevedahl@gmail.com> <7viqyk6je7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 03:56:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlaPT-0006CU-T0
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 03:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759233AbYDOBzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 21:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759257AbYDOBzl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 21:55:41 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:10588 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233AbYDOBzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 21:55:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so482912and.103
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=WYSX6EuCMpTdfIlU73m/pBoamRD2P1rIdRh4fNTBBuc=;
        b=ugNNsry7bp/fKjXrJ+AhCDfZCvodEtURuDd4zF7xRGGOavGUjyE8Th5rtpd8u8SbbAQtS86iw8sqL6KsYPwz/ADARe/K2KOsiMjKl1trKjdRObwAve34C23ufyfPp8c9lApe8ovOn5cG573i+3QnEo0/tLGhzhjdP6vTu8vZrRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=wdHP2aG8JF+WfAkjpM78zJO9HExgwBb+ZSwHlBQoenxLTt00lggbcVazre8Xrmw6mlQNoYNIzRaKINuszGwqOZwPD1b61IGvnXG/E8MtfCX1GuV6dzTtxftljg96vpdKc+cxsOSpeDHNDqh7cNmb+fYvh6zOVU2LU5elZUPUN9M=
Received: by 10.100.33.13 with SMTP id g13mr13609679ang.96.1208224539214;
        Mon, 14 Apr 2008 18:55:39 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.163.252.223])
        by mx.google.com with ESMTPS id 3sm16525601wrs.22.2008.04.14.18.55.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Apr 2008 18:55:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <7viqyk6je7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79557>

Junio C Hamano wrote:
>
> I think the new fallback sequence makes sense, but your explanation made
> sense for me only after reading it two and half times.
>
>   
So, would you like for me to attempt a better log message?

Mark
