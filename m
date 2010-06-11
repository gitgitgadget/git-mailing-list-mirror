From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Fri, 11 Jun 2010 22:28:24 +0000
Message-ID: <AANLkTinec7_D-WHRfetVRVvmG0EGoW4ZTdiTvoGMgJvQ@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
	<4C12B20F.3080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wincent Colaiuta <win@wincent.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 12 00:28:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONCiF-0003mv-MN
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 00:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698Ab0FKW20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 18:28:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34915 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0FKW2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 18:28:25 -0400
Received: by iwn9 with SMTP id 9so859628iwn.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=uOOZ3IC07ZQ12Tary1+pG10T3nFQQNdWtUWa/k6+j3I=;
        b=X+l4Ojd5Ln/sxiMfYCOmaCwffV8gYdUZhIT4aFF49mqTJDE4Mg2sWClwxkN64TbZM6
         n3jfMA04RpXL8uCUzj5vBbYcg9F0H8BFCKH28c3jY3EFYA8PSIutG2Cw2KSU/U127mTQ
         oN1PYbfX5PvcQqjUWkAmI9E/5KeqIQSrSQ/fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QoVIW0300dYQ30jC3sChd4/TvXdbm+AXGVx5UAz3FABAag+62U/vuE1XTyBdPH2fmq
         Nd18cICiRDltJ6ielUweGNBOyMqFytKMla3YC0T20ZaBak8F/SWNHc8vXIgdMqilKR+4
         rXSrY4qi4erUlSOov1qFbXxLeascvVZsiCi4s=
Received: by 10.231.180.166 with SMTP id bu38mr2512836ibb.193.1276295305015; 
	Fri, 11 Jun 2010 15:28:25 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Fri, 11 Jun 2010 15:28:24 -0700 (PDT)
In-Reply-To: <4C12B20F.3080709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148975>

On Fri, Jun 11, 2010 at 22:00, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Can a command be listed twice? Some of these commands _really_ belong in
> more than one category.

Of course it can. But what specific commands do you mean?
