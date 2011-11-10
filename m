From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 03:31:14 -0500
Message-ID: <CAG+J_DzfW8oZ7Mytb16q7mgnYxKxo13F2-HGgW4-esJ4GUn--Q@mail.gmail.com>
References: <4EB9C7D1.30201@nextest.com>
	<20111109220128.GA31535@sigill.intra.peff.net>
	<20111109222032.GB31535@sigill.intra.peff.net>
	<4EBB8596.6040507@nextest.com>
	<20111110080851.GA28342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Raible <raible@nextest.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:32:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROQ3o-0005vJ-F2
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933628Ab1KJIcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 03:32:32 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65425 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab1KJIcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 03:32:31 -0500
Received: by ywf7 with SMTP id 7so2689142ywf.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rUohITUG4iIqLOvZXddbZG1CN2mQuVNapHt8FqtjGy4=;
        b=Ea07ABM7WD11C3Uc63FJbadcv7WduEWMI8/xJtu0jMuZKrA4Mg0GEFKEM/WQToZMZc
         VD47PMNjU/cvGdhj9nVaMyu+m2Tnt42sR+DPsfaimkHfs+6i6IFMTcGFERFeE2JlApjm
         8h7AkTvJ5lsemwrsvyvTxW6HFtPyl0ZMGOCSA=
Received: by 10.147.152.17 with SMTP id e17mr1427195yao.22.1320913874745; Thu,
 10 Nov 2011 00:31:14 -0800 (PST)
Received: by 10.147.125.14 with HTTP; Thu, 10 Nov 2011 00:31:14 -0800 (PST)
In-Reply-To: <20111110080851.GA28342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185218>

On Thu, Nov 10, 2011 at 3:08 AM, Jeff King <peff@peff.net> wrote:
> it to Junio. But also, I'd like to gather more opinions on whether the
> design is the right thing (hopefully the implementation is Obviously

Makes sense to me, so you're at +3.

j.
