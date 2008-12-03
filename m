From: "Tzury Bar Yochay" <tzury.by@gmail.com>
Subject: Re: Is there a way to control the number of revisions will be saved by git
Date: Wed, 3 Dec 2008 20:20:14 +0200
Message-ID: <2f5ea7490812031020l57ec1a04x257c66549f3dac8a@mail.gmail.com>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 19:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7wLv-0006c8-Iz
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 19:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYLCSUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbYLCSUS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 13:20:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:41191 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYLCSUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 13:20:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2560633fgg.17
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=zLVdQlbnIGUhmbT/CmjbvrjUPKjSBfrlEJ8yugS/4ws=;
        b=cZ7vu+LguNdlccc0MfV43BISw2xDMPu9/sZlDKZkoY45X4fgKDUma13acqGzgvcBIy
         LtJ0diAU1PYvj2QdGKXoLS0PQ5bsyxvaVQsPGP1B79U/EpfaFnij7dJ0RjboMJVoWqbJ
         TGBcFQBrXAd98CW5B9vka5b1TzZmJmLTsDgVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=NkwOUVREWzjF5uWVWLj8F8lF78h2ndIYsexJWX/QK6gqCiTU6dsBu+DJmvHLUJaZRA
         S/U9G1NFgoDTVgB5ss4Bkep1iKvVDAC9bMsdFaUFlfMHoWh34qYj4kcRUtI08bDKf3Au
         vKzzpTw6Qt9SJ8/8H7Vldd3tDLzrb5fVkji/M=
Received: by 10.181.31.16 with SMTP id i16mr4733958bkj.129.1228328414695;
        Wed, 03 Dec 2008 10:20:14 -0800 (PST)
Received: by 10.180.249.13 with HTTP; Wed, 3 Dec 2008 10:20:14 -0800 (PST)
In-Reply-To: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 29c0b16aad8638ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102275>

> Why would you want that, by the way?
I was thinking of building some experimental application on top of git
