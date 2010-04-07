From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: ghost refs
Date: Wed, 7 Apr 2010 18:11:38 -0400
Message-ID: <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com> 
	<r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com> 
	<20100407210010.GB27012@coredump.intra.peff.net> <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com> 
	<k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com> 
	<89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzdTk-0006KP-CZ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab0DGWL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 18:11:59 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:48512 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab0DGWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 18:11:59 -0400
Received: by ywh2 with SMTP id 2so797699ywh.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=0z0RfkRhGb5cY4Xw5QAfc+rot2sNHWbvqzDp6PgytrM=;
        b=ebjkJNETGvpBLIkRQd9AjHschnP7qBAEFwIQnvoVOPnSssU9SSvD5H6ey+ebM6UJOb
         zHGeWCsdDo2YMyE4OlfKMW4qaMCyBBdWmXXMzPTCIb/uCzjF+Kj4mgb2/Pwvv4U0zZdI
         TjE/LswhqLlMGEyMXCaR98SvwvwlSfxvamGgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ws1IdM8BE+H7dwAQkhdlZhH06QteTx6pJLLlSWnBXF38VRVqOqkF/17F395fZbJgqH
         ZOP+WSlwdFI+CIVHwqRKKV9bafievlNjBJWXnrTlF7eXMJN81qsayZfC9O/bRVi4vuJk
         BG88447g517Df0P5h8en4hHND6RsFcPxRZRGA=
Received: by 10.150.150.20 with HTTP; Wed, 7 Apr 2010 15:11:38 -0700 (PDT)
In-Reply-To: <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
Received: by 10.150.207.5 with SMTP id e5mr5593424ybg.249.1270678318132; Wed, 
	07 Apr 2010 15:11:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144290>

On Wed, Apr 7, 2010 at 6:10 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:
> So do I still have to specify that I want a reflog when I create a branch, or does that always happen with local branches too?

Why not try it and find out?

I've never asked for a reflog explicitly and I seem to get them.

Avery
