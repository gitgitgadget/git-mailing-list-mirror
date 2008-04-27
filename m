From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Sun, 27 Apr 2008 11:03:12 +0200
Message-ID: <48144150.8040001@gnu.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 11:04:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq2nh-0003xd-Qn
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 11:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYD0JDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 05:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYD0JDP
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 05:03:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:16001 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbYD0JDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 05:03:14 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4414978fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=lUHA3M5HRBrbphChQfdCByHiVf5OpluYH4JBAx4DNBg=;
        b=hL8T1Av1Opio/jsnS9V6gRQ8mT4jXiCAgFMCGLgyAvtOLtL6LXUAJQ3eKDmO14jMeiHQXQof3hugBVxhBB6BQHE3NWL5/5NlFzz6YJWXpTUP/J5rTgm5+q3L3VlCOhs9mqbyuRDAvnw59P0dicbB/6wD29j/KQ5o3F+LOzXiPIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=E7H6ToaX6ujh+WjPSvk9rl12X5G2BlrZ0QPxLiOc115w4O2uFT/8FXpnRZQmQJKkWUpDPbBRlOTFgDwkPqgpywElj9zv94ElblaptRQM+eex7CC+Zx9fjdLCazmiUgn8+ZnmWnOhFzgx3OslPxn2xrbSsQWjQy6JU19R/TK9Jjk=
Received: by 10.86.31.18 with SMTP id e18mr5172215fge.38.1209286993360;
        Sun, 27 Apr 2008 02:03:13 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id 12sm3680239fgg.6.2008.04.27.02.03.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Apr 2008 02:03:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080427044049.GJ29771@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80434>

Patch withdrawn, I'll send a different series.

Paolo
