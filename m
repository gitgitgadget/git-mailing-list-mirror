From: Steven Michalske <smichalske@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sun, 6 Jun 2010 01:19:08 -0700
Message-ID: <EBDDE922-E7D4-4668-BFA4-9770D9ABD4F2@gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	<4BF7B751.7050704@pileofstuff.org>	<4BFB7F7F.5090407@drmicha.warpmail.net>	<4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com> <4C06050C.2040505@drmicha.warpmail.net> <4C0AC140.6090808@pileofstuff.org>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 10:19:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLB4j-0001fG-J0
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 10:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab0FFITP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 04:19:15 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:63455 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0FFITN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 04:19:13 -0400
Received: by pzk15 with SMTP id 15so1770979pzk.15
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=AwlWzXRwSdEFLiLSdFDQk2l/J8CTVugpYCA6v7Q8QTE=;
        b=Eg9HGpDNVTo4COPDxVBq6pnVil6O2YaEmyjFOyVP5isL8geEoGsfvWEYJHiBZn0mjc
         2mY+JLDMPeJHW9/eKoSKh54YXON83tuRzaOM0EMGpWvq4y0e+6EKmAaTsKt4tABQl8ee
         N5UQ4tLB4QiVDjm+D34KeWdUPYkA5nJJYBb2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=TyLWXPhSzQYvqyWzMlRgdgyVAsySsqArQWVo8JX+bJaGs68SJz1pBjqoWZqdAF9jO8
         cQNoFfflmJfyRCZ0Jo1Bm66qN1+OhNu2dVMzTsnA/hWIp7A8co74VA5P9iacQ+cquh+b
         0UH+hnzeot2v+1J4sdJEE0a1hC+dUwlJRX9aM=
Received: by 10.143.154.1 with SMTP id g1mr9848349wfo.36.1275812351701;
        Sun, 06 Jun 2010 01:19:11 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id b6sm26652553wam.9.2010.06.06.01.19.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 01:19:10 -0700 (PDT)
In-Reply-To: <4C0AC140.6090808@pileofstuff.org>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148509>

Resent, HTML multipart got treated as spam......

On Jun 5, 2010, at 2:27 PM, Andrew Sayers wrote:

> I remember now the
> mental anguish I went through trying to explain what a local index is,
> so I thought I'd save other people the bother :)

I liked the idea that its an envelope, and you add changes to the open  
envelope.

Committing the changes are sealing the envelope and putting it on the  
pile of papers on your desk

A push is mailing the envelope.

Fetch is going to the mail box getting the envelopes and throwing the  
letters on the table, but not opening them.

Everyone knows envelopes!
