From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] git-am foreign patch support
Date: Mon, 25 May 2009 21:19:33 +0200
Message-ID: <fabb9a1e0905251219q3fbd2d17hb08649b9113baba8@mail.gmail.com>
References: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 21:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fiM-0004yO-9n
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbZEYTTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbZEYTTx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:19:53 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47818 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZEYTTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:19:52 -0400
Received: by ewy24 with SMTP id 24so3208072ewy.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bIhdb1oiWciOdgZl1GZXDHLqQpAiuGm9jZxKZq3a/rY=;
        b=JR8zK6W7OrKy6hGrm3X6TMi6pQo5k1Vxa+X1MUTZOWjB4U8MvI7ohSzfMSyxSA4PAd
         q7i3WJSlMW/egTAjR/hRAcPz9PgsT8UIBjTBPK7TFnjrXj0Vk3gVsSYJ+JJnuMnmLFgr
         QvS062cvOm+J2OuE6IE/19jXFTWhnUA3s1MHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HwMIcC0NdKrU0NLn5CWsJ7xTFYjxnur2II9eA9hZtqFjTCzqDs5V0gFQwjRUM1wAdJ
         +a9HgTlWRbKEUF06YZFFX68wus6JaAcdELWvGw3IlQyeDBokeqYVH5o6nlf9VicLTEtz
         cWAjDAf1Vm9OFitFqMmg6900XGEgEDBaWTY3c=
Received: by 10.216.18.82 with SMTP id k60mr2191742wek.118.1243279193501; Mon, 
	25 May 2009 12:19:53 -0700 (PDT)
In-Reply-To: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119957>

Heya,

On Mon, May 25, 2009 at 21:14, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Autodetection for Mercurial [...] patches is also implemented, [...]

Sweet! I now have a vested interest to see this accepted :P.

-- 
Cheers,

Sverre Rabbelier
