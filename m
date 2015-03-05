From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 4 Mar 2015 16:22:18 -0800
Message-ID: <CAPc5daV_igiExbvY1eH0T2SKxgawO86F0eZyoai_QK-dXc5fDg@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <54E6C78D.3070506@alum.mit.edu>
 <20150220072924.GC8763@peff.net> <vpqpp94exb5.fsf@anie.imag.fr>
 <70A3994196D94205B75660D9DEFF0A12@PhilipOakley> <CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
 <75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:22:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJYp-0005YT-RW
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbCEAWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:22:39 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:41242 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbCEAWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 19:22:38 -0500
Received: by oiav63 with SMTP id v63so8907495oia.8
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=78X+/WqG7SDgokAJxL5jf5YLQbu4fJqKUKU8bY1pyVQ=;
        b=hC8lRfFFEtS7BkRwlf+FDYjovtnm4BbsTetoNoK1oOd1GO3HQHjyX1fdBHpFCem9KT
         rsoBinInpMKimrtr5Q0QGA9iWFQRHRkBa62Ba2aZcMd7aWwoQvyGqXzdLxpDqQf+TWNU
         di2yb085DrtZ7ThVkFY1qiuIhTjOOGcFwoQiTvblEPUG59nLn778D+KbGc1WiSBmKmHA
         N/yZ7hxi/YBQ9hEKzbQxsN5oEoKlXwSRx+cuZBuyIWl0S209jAIWqK4RmMm1wWio0yau
         QdWOnLCYI0qoAdjdUwjT8cWNyc9qO4j5eOqIEAhNKl+21dw8L73IZZxxUijjzORepJsX
         M8qg==
X-Received: by 10.202.209.23 with SMTP id i23mr4739878oig.108.1425514958329;
 Wed, 04 Mar 2015 16:22:38 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 4 Mar 2015 16:22:18 -0800 (PST)
In-Reply-To: <75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
X-Google-Sender-Auth: _o_XJdInjRDEHjSVY6JN63vrHCU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264799>

On Wed, Mar 4, 2015 at 4:17 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>
>>    git clone --since 2.weeks.ago <url>
>>    git clone --since v2.10 <url>
>
> The use of --since instead of --date would be an equally valid way of
> spelling the option (coders choice;-)

I think it is a demonstration of poor taste. Everywhere else, --since
is a way to
specify the date, not a revision. Why should this one alone should be different?
