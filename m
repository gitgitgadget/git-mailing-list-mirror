From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 00/13] New output style for git remote show
Date: Mon, 23 Feb 2009 02:56:51 -0500
Message-ID: <76718490902222356l339abf28n611297672cb28f37@mail.gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
	 <20090223065934.GD24517@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbVhn-0006dO-O7
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbZBWH4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbZBWH4x
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:56:53 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:47821 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbZBWH4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 02:56:52 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1834988rvb.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 23:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MyymYpVUT14b6I1avnK6Lgzgoh5nEBF8expAPjfKwsA=;
        b=QfOFAEmA1LCPd60n9VDxaLXkkygIkf396Ou3IO0b3sKcV2mjf6XidVM0csZdrVNUJt
         fXz9cfwR4rVufj7ZvwoxuONznf23yKAN6+8Q4GQdR5lz5YRgG96vzW91Pqw/swu1YoZX
         Zolk753KabpP8Ddg1AKxyYNmaVtfu1O5m0qiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N7E87mj+rjYTbEDN09narrDxVjcMExOn5drMj1UT2ZP+PpVLke+Xpl6srNyEJE3ZiC
         YMS94+Xsw8L2FHNa/jvH3wIYt4dTdML/C1UjVNS2EGGLAwrOulpOaCAwh0JpGfJbNtde
         eMozlBHu58asFdcvEJfCSaZMIYbSJf8HrJAro=
Received: by 10.140.139.4 with SMTP id m4mr1895706rvd.292.1235375811688; Sun, 
	22 Feb 2009 23:56:51 -0800 (PST)
In-Reply-To: <20090223065934.GD24517@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111117>

On Mon, Feb 23, 2009 at 1:59 AM, Jeff King <peff@peff.net> wrote:
> I gave these a quick read (but not any extensive apply+build+experiment
> cycle), and they all look good to me. I don't know when I'll have time
> to try breaking them, though. ;)
>
> Thank you for splitting them. It made reading a lot more pleasant.

Thank you for the review. I humbly await your breakage attempts.

j.
