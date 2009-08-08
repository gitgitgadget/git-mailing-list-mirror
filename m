From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 0/3] commit --dry-run
Date: Sat, 8 Aug 2009 00:18:25 -0700
Message-ID: <fabb9a1e0908080018t60e9c6e5t947f6fd9029a55bd@mail.gmail.com>
References: <1249715693-9715-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 09:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgCb-0004fK-4k
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbZHHHSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbZHHHSp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:18:45 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:43266 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbZHHHSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:18:45 -0400
Received: by ewy10 with SMTP id 10so1989651ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tUJLVMAZTkoW95tQIcaRwLf6t5fm9VnVIiWxo2Kfi+c=;
        b=qOltWQpT5E5S2ZfXUKm50oB9FgfQUlRCoin2tYdVpfbxV8BJAf/JLFVxZ1I1oSKlpB
         68NtOatsJvT2gsfCE/wWYzmj2oorau25qY6zPvmuosu/sB2ebb2VBFoFDYxQoOqQolrB
         BCV0CpSqg32kWWzyRSVLxwC+RIyO1wzhb0oZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vWbLKFw4p99A6pGYPG5aWB5uq2emhznwvLxrh7/1iqBA2mGX2gAP4SjGU/BVsrjYES
         L9qJqyKUX45K5YM+yIMJVzr2Ftg9y2zXbJzp6IjyWdzsBp/OBOh33n502R0D85+AWlem
         VGyXkc9s9nWjY0VwSUL7EwN94AYG+WZJ4TEI4=
Received: by 10.216.28.193 with SMTP id g43mr411215wea.192.1249715925076; Sat, 
	08 Aug 2009 00:18:45 -0700 (PDT)
In-Reply-To: <1249715693-9715-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125251>

Heya,

On Sat, Aug 8, 2009 at 00:14, Junio C Hamano<gitster@pobox.com> wrote:
> The second commit introduces a new "git status" under a tentative name
> "git stat".

That would put 'git status' at 'git statu<tab>', instead of 'git
stat<tab>', I don't know if that's a concern though.

-- 
Cheers,

Sverre Rabbelier
