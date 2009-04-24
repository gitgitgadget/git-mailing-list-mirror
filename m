From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: auto commit merge using the default merge message
Date: Fri, 24 Apr 2009 13:50:57 -0400
Message-ID: <81bfc67a0904241050t26a0ed62vbf17e471ddc10672@mail.gmail.com>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com>
	 <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com>
	 <49F025E7.7090404@drmicha.warpmail.net>
	 <7vocunwz1n.fsf@gitster.siamese.dyndns.org>
	 <81bfc67a0904231831y31bfb057pa5eaa86d0e153824@mail.gmail.com>
	 <20090424140606.GB10761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxPZl-0006dP-Q4
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 19:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761097AbZDXRvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761048AbZDXRu7
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 13:50:59 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:53681 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760965AbZDXRu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 13:50:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so758962and.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z+bAhOxxU0MorqbF3+AzvyA3VPKiHZZJnbQQGu6stpg=;
        b=q6A7KrvnTsPgomjw1OzX77LoyTSgzsgcNM1IzwSk0YxClafGey+7BU6uzOwdgWHm4J
         Ujcpfi3y4MOoLebykIABiEaeUCtuROvoAjwbBgZ/qbw/YSqL7ArkYCmXcAwsQOp22kSs
         nymQavI1RZE5gpUU5Vi9B81Kcna3lpu+MX8sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Inb/4whH+v+2LAUwjsPWr0uPubk0yE24fuCd3+x/dQ+Umf/9v6BjD18dRZ4gNyvXjX
         ntO45Z+4dgUt9o0UwxQz/qvqqckQY6Q6apEXnhzVKyCPytp5YkmGw5FAsUwE6mUSmIdQ
         vszPvE2L/tu0K3Ctt2Zq+7zyn1ExsT3XEY5hc=
Received: by 10.100.10.15 with SMTP id 15mr3595615anj.6.1240595457260; Fri, 24 
	Apr 2009 10:50:57 -0700 (PDT)
In-Reply-To: <20090424140606.GB10761@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117474>

On Fri, Apr 24, 2009 at 10:06 AM, Jeff King <peff@peff.net> wrote:
> export GIT_EDITOR
>

maybe I'm being silly, but won't that then affect my interactive shells?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
