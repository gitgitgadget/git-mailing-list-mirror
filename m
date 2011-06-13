From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: file mode
Date: Mon, 13 Jun 2011 23:18:58 +0200
Message-ID: <BANLkTimgby8-aBmXiZ72vtxoLO6Tr7zi2g@mail.gmail.com>
References: <alpine.DEB.1.10.1106122055210.6124@localhost>
	<BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
	<20110613053814.GA2680@sigill.intra.peff.net>
	<BANLkTikZZsuQ9PoNvMOoRCg=kAnwQOvOSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Peter Kleiweg <pkleiweg@xs4all.nl>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 23:30:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWEif-0000Fu-3N
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 23:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab1FMVaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 17:30:30 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:52502 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab1FMVaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 17:30:18 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jun 2011 17:30:17 EDT
Received: by fxm6 with SMTP id 6so4595757fxm.11
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=196AoqD4JJsWBeZ3jMrd8uYxvq9obWUEIgn6mnqU7KI=;
        b=sS2I1PTZHIQA5yF5dQBOSj2Q3arhAWTiB+YhSpQ4uy3H5yh5MyTdgUuM4RRdKIxMIr
         TM6RCzvZyMPDFtgLxGK08QdM+8VaPht6G2AqwJ4I6BM9zfg40L/aOqCAl1HD+lWziEMa
         76zer9tx6Msj2mAtPQdlBnm7lNIBFzEFLwA7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NqrUGV0QRjDzOfUPqAbwMMYjV27pzoRRJ0hEkvbFLYEwvXOrZ17NP/BDzMS+JkLrzz
         bhFOXgJ1Jfy8o9+/ioVeFiO7SQTqJ5MlisHDadpxOLzWXfH9+8RjER+JxYBpdOzLUIZH
         eIDMdvzZDInHcl5Pses+1DlhCpvwc+nV473Ls=
Received: by 10.223.73.139 with SMTP id q11mr152299faj.56.1307999938638; Mon,
 13 Jun 2011 14:18:58 -0700 (PDT)
Received: by 10.223.117.65 with HTTP; Mon, 13 Jun 2011 14:18:58 -0700 (PDT)
In-Reply-To: <BANLkTikZZsuQ9PoNvMOoRCg=kAnwQOvOSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175732>

On Mon, Jun 13, 2011 at 15:58, Michael Witten <mfwitten@gmail.com> wrote:

> Firstly: My response shows that there are abundant answers, which is a
> nicer answer to receive than no answer at all.

I think having answers like yours is much worse than having no answer
at all. I happen to know how git handles the storage of file
permissions, but like Jeff I couldn't find anything useful either with
some quick searching around.

But it's very useful that the list have a friendly atmosphere where
people of different technical capability, or those that haven't found
the right terms to feed into a search engine can ask questions without
getting back an answer which at least to me seems very snarky.

There's a tendency in a lot of mailing list to accumulate a
self-congratulating air from regulars "in the know" where people
asking questions aren't made to feel welcome. Let's try to not become
one of those lists.
