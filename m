From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 0/8] Support coverage testing with GCC/gcov
Date: Thu, 19 Feb 2009 15:09:53 +0100
Message-ID: <bd6139dc0902190609r4718ba3as117ab79a5f3679de@mail.gmail.com>
References: <7v7i3nqk0x.fsf@gitster.siamese.dyndns.org>
	 <cover.1235041345.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 19 15:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9cZ-0000cu-44
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbZBSOJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbZBSOJz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:09:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:32657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZBSOJy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:09:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1195095fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 06:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=p66FzzgzAsvJU+UV4Jd1dvhw7ifIkwACy8FwPqSXFgw=;
        b=CZjEgt8Wwu6QE7GNjQkiyP9k+YUZvzmCaiYumQh6AuwrYfGDTaOeANBVC0X0zRRGxV
         e2LXAg1C1FxEbRh3rJ+TYDCOA8Qj28AIqQjl7ZVFbVf5l4GskSsd3xxi5uKGfR+tWsHr
         ZfpsN1a3MEjKNSgIrmvdv3f6vbU+PfXpRfC3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Xg1ahNuUA5FlEwRBBR6tJH1WOinYBNhxmcf7wJyRGy2eVVfLRWDTXtvsb5Yn7NcAzg
         wz3od9/HOGGt4Mascf0hqn6w8sGoOYZZvVWIGzvW5xlgc7UHUVMLW9VYwV1Pf/7hN6i5
         1MCbwqnzuJJYV/U1/RkdYccodvz7A0Id32S0g=
Received: by 10.86.36.11 with SMTP id j11mr323728fgj.65.1235052593050; Thu, 19 
	Feb 2009 06:09:53 -0800 (PST)
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-Google-Sender-Auth: 2b20b7ab40eba8e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110702>

Heya,

On Thu, Feb 19, 2009 at 12:13, Thomas Rast <trast@student.ethz.ch> wrote:
> I noticed two small things that I'd like to fix before this goes
> 'next', so here they are:

<snip>

> Apart from that it's the same.

I think in this case, where it is the second iteration of the series,
with only few, and minor changes to the series as a whole it's better
to just send the updates as reply to the original version?

-- 
Cheers,

Sverre Rabbelier
