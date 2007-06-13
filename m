From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Mail after commit
Date: Thu, 14 Jun 2007 09:19:57 +1200
Message-ID: <46a038f90706131419i66cf610flac4f3ca040a4355f@mail.gmail.com>
References: <466EBC7E.8040104@gmail.com>
	 <46a038f90706121335i79dc5967l782101bc743dc8e2@mail.gmail.com>
	 <20070613142516.GE22027@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Claudio Scordino" <cloud.of.andor@gmail.com>, git@vger.kernel.org
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:20:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyaG1-0008Si-6s
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 23:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXFMVT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXFMVT7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 17:19:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:5737 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXFMVT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 17:19:58 -0400
Received: by wx-out-0506.google.com with SMTP id t15so324330wxc
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 14:19:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fmgpTgaa/DNqH4lIMSeuVOnJ5y6PLcsYbyelRQr7O5VhEDGzjLMjkMcP2coCgi27SX8le895bgTbOLpu1+cQ7NJESBfq6hW475cp5tTKiNKKlPltVbP6+VDP8XYZzjymO+tbPLubHBk+KVBWIBdgNSx9NLRScVETQHtGhMUDvgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EUUgoPvhTYG+JV/L12fvGRg6bPtV295kw9czlOCG91oPd1Z+urvbU7dS9GqgleQBrwOsBPYMsZU1Q1bqugqQ9Hio1g5nurxhHjNMGK6bQQpzHUshn6miZP7h+TuDk+wjNlOHFiP/KXijHD2c3sT/w2kHONkzBM0Vu7hT8behiDI=
Received: by 10.90.52.18 with SMTP id z18mr1081650agz.1181769597875;
        Wed, 13 Jun 2007 14:19:57 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Wed, 13 Jun 2007 14:19:57 -0700 (PDT)
In-Reply-To: <20070613142516.GE22027@lug-owl.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50132>

On 6/14/07, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Wed, 2007-06-13 08:35:57 +1200, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > On 6/13/07, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> > > Doesn't exist any way to make it simpler ?
> >
> > I think most people setup gitweb, and follow its rss feed. Not exacty
> > the same, I know, but quite useful.
>
> Erm, no, not really.  Emailing the patches is *quite* useful when
> there's a dedicated review team.

I'm sure the review team can read the RSS feed ;-) I've also seen
RSS-to-IMAP gateways that make it easy to "reply" to the patch from
your MUA.

Not _exactly_ the same, but quite useful.


martin
