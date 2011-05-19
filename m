From: Eugene Sajine <euguess@gmail.com>
Subject: Re: plain text only policy prohibits the use of android based mobile devices
Date: Thu, 19 May 2011 10:33:56 -0400
Message-ID: <BANLkTimBxPKx1gWeeyk3YgAd4R-XtyQv3Q@mail.gmail.com>
References: <201105182217.p4IMHIk2001872@amd.spinics.net>
	<alpine.DEB.2.02.1105181612310.12174@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ellis@spinics.net, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu May 19 16:34:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN4Id-0002DW-V9
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 16:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab1ESOd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 10:33:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46808 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1ESOd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 10:33:58 -0400
Received: by wya21 with SMTP id 21so2021015wya.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z70uxAlXu9v0QZ/qzfiv5ev7hfYYGkYgpPDzV6YyaME=;
        b=BX8NUcR1w7AuATHHaT0KLpUmh7GAM0miHB1xIKRa40p+ESmRav3V/DLCRxSJelL1yg
         pdl/8GoLgqWAhQgeIEMXml28h+AB4OTpmaUWKPr5x2o+FQN5HEeyddijuttjHSqBPaIv
         5YfNY5mqRTSWCNV9iggpTBa05a+ELLhO9CsLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oNdatj9Nvdv53Ex2z7FxCHZu8dWvR08Rs7ly+cjAduMmo2sNQE8VkWi3ayw+6KVCM1
         Ry/pVncA9CdfQe8UCHFeQ8azvGRd+DeNksM8eu4xvFRPUCXHxLnoVIG67M7Tor0hQMax
         W9bJ3avOZLzBP6gmrQ/Km+liDkJTrgivAYxF0=
Received: by 10.227.197.21 with SMTP id ei21mr936165wbb.107.1305815636737;
 Thu, 19 May 2011 07:33:56 -0700 (PDT)
Received: by 10.227.12.209 with HTTP; Thu, 19 May 2011 07:33:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1105181612310.12174@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173959>

On Wed, May 18, 2011 at 7:14 PM,  <david@lang.hm> wrote:
> On Wed, 18 May 2011, ellis@spinics.net wrote:
>
>>> The necessity to use the desktop in order to send a message to the
>>> list is annoying and not quite contemporary.
>>
>> So the list should change just because your mail client is broken?
>
> if the client is sending out multipart mail with both a HTML and a text
> portion, then having the list accept the text portion and strip the HTML
> portion off seems like a reasonable request.
>
> I am very much a text e-mail person (I use pine almost exclusivly), but this
> doesn't seem that bad.
>
> David Lang
>

That is exactly what I'm thinking about.
IMHO multipart message is completely valid format and list could
preserve its integrity by just pulling out the plain text part of the
message.
And it doesn't matter which client I'm using and if it is broken or not.
I think that the gmail client of android 2+ and 3.0+ is in fact broken
in that regard, but the one from 3.1+ is not. That's is why i was not
asking about "openning up the gates for broken clients" and allowing
HTML content. I'm talking specifically about 3.1+ android versions
that will inherit this gmail client behavior and they are coming soon.

Now I posted this to the list for few reasons:
1. If only one person contacts list admins about such matter - he will
get the answer i got up in the thread. Within a blink of an eye.
2. I wanted to run it by list to understand if there are others who
are annoyed by the way this policy works and to get their input. Do
they think the list could accommodate the multipart messages or they
just using some other clients or they just don't care.

As of now i see the majority doesn't care, so it is up to me to decide
how I'm going to work with this.

Many thanks for the feedback about this bikeshedding issue.

Eugene
