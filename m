From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Yesss! sourceforge.net and Git
Date: Mon, 2 Mar 2009 00:10:18 +0200
Message-ID: <94a0d4530903011410u67b20a38nc81d8b00b1c251f8@mail.gmail.com>
References: <alpine.DEB.1.00.0903012237360.10279@pacific.mpi-cbg.de>
	 <fabb9a1e0903011344r2a094283ge95e29d674858213@mail.gmail.com>
	 <alpine.DEB.1.00.0903012259390.10279@pacific.mpi-cbg.de>
	 <fabb9a1e0903011402y3d2878b1h7e29f720dbfe1c82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldtsz-0000dM-LF
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbZCAWKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 17:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbZCAWKW
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:10:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:35317 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbZCAWKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 17:10:21 -0500
Received: by fg-out-1718.google.com with SMTP id 16so871786fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 14:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WKVqJz9nxJil9J5PG0rtzzcSeidvuVPiy4T0AHFBca4=;
        b=fTn8CFy1fQm7dPbi2ZIeitSt+Eq9AiZY1gLptIUDuD0coJeWLxbS445z2IKBx9S0Kh
         HnV6AvC5TGh8tgRkSMbM5ffcMldiKAJKFg5AqxWhDpIwzK0609HcL1QaxAShWapegVeC
         ndlonYTMGWUAsJzVAd8Q8+u2UUbLyOMCtHaoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L2HXD7pUMHQgOhqJG7UsNOT8n6AMOgOZMVEMSLidNVXciLOJkv3DFkZc0a59Xxw0wV
         rG0LH0CkdN2iBVoAiKDeh3xDfkD9zDdDaN997P3HvydcEQrsLzfyd5L1HWagBCM4+wUr
         4HynTll+ZvGKZZW9ReTHPR/mHXXBCsYXAq62k=
Received: by 10.86.79.19 with SMTP id c19mr575960fgb.45.1235945418905; Sun, 01 
	Mar 2009 14:10:18 -0800 (PST)
In-Reply-To: <fabb9a1e0903011402y3d2878b1h7e29f720dbfe1c82@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111889>

On Mon, Mar 2, 2009 at 12:02 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
>
> On Sun, Mar 1, 2009 at 23:01, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Sun, 1 Mar 2009, Sverre Rabbelier wrote:
>>> About time! Totally awesome though.
>>> Now, code.google.com and others have no excuse anymore, right? ;)
>>
>> Except that it is run by Subversion people, and therefore it by like
>> asking git.or.cz to serve Mercurial repositories ;-)
>
> Heh, speaking of Hg, I heard they're adding DVCS support to
> code.google.com soon, if they're already adding a non-svn VCS, why not
> git? :D

Well, git has become so freakingly popular that supporting any DVCS
that is not git would generate lots of complaints.

-- 
Felipe Contreras
