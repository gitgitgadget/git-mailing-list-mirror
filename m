From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Suggestions to make git easier to understand
Date: Mon, 15 Aug 2011 12:15:45 +0200
Message-ID: <CAGK7Mr4ZbnHPc7Yzim4D=ABeXOCYrP-4Mc6Z-4mH+u9ZKSEBLQ@mail.gmail.com>
References: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
 <20110811221627.GA32005@elie.gateway.2wire.net> <20110812222626.GA7079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Rafael Magana <raf.magana@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 15 12:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsuDV-00030E-Ho
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 12:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1HOKQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 06:16:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53064 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab1HOKQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 06:16:15 -0400
Received: by qwk3 with SMTP id 3so2381753qwk.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=03XY0AxNQW7CS4adkswM8I1W++LLmPCo0xUsNaRDI5Q=;
        b=G1vCF2+YUb8D7nPGY/JDwbXU595WzEnQnyMZ78Uoyj4ALxXfsr0RLxk3ciHkgksd07
         wuwsyTOGISy7q64q5IItIFTdaqnwNiyx7+CZ+1IyaEBobnN58dBS7NrsPfioUMCfBWJK
         3Zb1isUbZS/MTDpDGVzXhTYL+4PNSn1G9AhjM=
Received: by 10.224.196.1 with SMTP id ee1mr2445598qab.109.1313403375087; Mon,
 15 Aug 2011 03:16:15 -0700 (PDT)
Received: by 10.229.43.224 with HTTP; Mon, 15 Aug 2011 03:15:45 -0700 (PDT)
In-Reply-To: <20110812222626.GA7079@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179362>

> Didn't we fix this already in 8009d83 (Better "Changed but not updated"
> message in git-status, 2010-11-02)? Since v1.7.4, "git status" has
> "Changes not staged for commit".

Yes, and the new text is fine for me.

Philippe
