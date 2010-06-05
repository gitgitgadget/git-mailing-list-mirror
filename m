From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sat, 5 Jun 2010 16:03:30 +0200
Message-ID: <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
References: <20100605110930.GA10526@localhost> <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com> 
	<20100605135811.GA14862@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>,
	Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jun 05 16:03:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKtye-00059w-Up
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 16:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397Ab0FEODw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 10:03:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48401 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933319Ab0FEODv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 10:03:51 -0400
Received: by gwb15 with SMTP id 15so419714gwb.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=5UKwK7ET+xXDZkffgDaHD6NLE1vj0af8OOYRDUTFqHA=;
        b=pYFziwuG2LcnUZGiuWV/gzE09cCmOMWBT/NbiMWohqtwZ+LlpSMiB1OGiMT3n6A+BX
         7jnAAsL9qnqZzWH9i+TFFVoNegVTQZohrP8HbKOjrfn0li1yg3FxACAIYx+Mp4cdX7cz
         +vSiDNOhphW30ugBsng9A24ci9Dl1cKX3oXnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pKi4e7+tTAPXUqJ1O5VEZT/ZlziZBuffIpZymQSinHD7RLEDGr1QUF4A7NEbY6A2vR
         /WGGxnneWTuqxbRo/eRAziwBa6xR3zepBRu2blvSg44tiv5Q7W5MTAly/aiMZyBZT6g3
         c8OW7d+PEPwOc8Zref4J3I8Ocvj0iy5/nHsWw=
Received: by 10.150.170.11 with SMTP id s11mr12004049ybe.390.1275746630116; 
	Sat, 05 Jun 2010 07:03:50 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Sat, 5 Jun 2010 07:03:30 -0700 (PDT)
In-Reply-To: <20100605135811.GA14862@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148472>

Heya,

On Sat, Jun 5, 2010 at 15:58, Clemens Buchacher <drizzd@aon.at> wrote:
> Well, I just noticed this by accident, it is not documented
> anywhere, and you cannot expected me to know everything that is
> going on on the list. Should I not offer my opinion because of
> that?

No, I just meant that because you are late to the party you should
first read the original thread, and then perhaps summarize it, like
you have done below.

> I could not make much sense of the thread that came with the patch.
> The discussion first seems to conclude that it is a bad idea, only
> to implement it anyway.

I think it would be useful here to have some links to relevant posts,
or at least to the relevant thread.

> Well, I also think it is a bad idea, and I am not surprised to find
> users confused by it.

I think it was an idea from the last mentor summit, Peff?

-- 
Cheers,

Sverre Rabbelier
