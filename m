From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 11:15:00 +0100
Message-ID: <8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <4788BFA8.2030508@gmail.com>
	 <7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	 <47891658.3090604@gmail.com>
	 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	 <47893E1A.5020702@gmail.com>
	 <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoGB-0002Iu-K4
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYARKPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYARKPE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:15:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:47175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYARKPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:15:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1644286wah.23
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tTr0C1YDXgpMyXHWIujNQQDmEPtVUHYh2lpffU0JFYE=;
        b=kiHiuf716yGiuRzTKB6TLFrMaex2qIp83k/Iriwa0yRuFONGJEadW7DmpxsRFVazaU5U3ibqJ4xLN5cpQKUgcSn/SXx74GDmd3X7rtRKq2z9jB0khttsPCjmrwsgxTz5fxIQi5wCDNrWHL4PmzAx6XMW7u73y7D+nkz63pTIA/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ViGYXw1nOPbIkMd0ZQ5h8dpGH/sAUVBn8TmkLR+Ik4B/Sbhie8DNqcM9+DvRUf6pFfBmEgVdCuIDRWDU6Y1MKPl3Nb/riLwDBzZT3gqUAxrug6/pjJduM7FMhSf0iiHsZusA0DrPhNG4bq29WNkrzz1LOXGYYhl9UuUNNDAnSyY=
Received: by 10.114.184.7 with SMTP id h7mr3721140waf.28.1200651300733;
        Fri, 18 Jan 2008 02:15:00 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Fri, 18 Jan 2008 02:15:00 -0800 (PST)
In-Reply-To: <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70989>

On Jan 18, 2008 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It seems that for the past few days, people were having too much
> fun bashing how broken MacOS X is, and the real work has stalled
> in the meantime.  Well, not really stalled but they certainly
> made the patches and discussions harder to find in the list
> archive.

Here's a patch which might have been lost in the noise:

http://thread.gmane.org/gmane.comp.version-control.git/70463

--
larsh
