From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jGit Eclipse Plugin Feature
Date: Sat, 07 Mar 2009 16:58:47 +0100
Message-ID: <49B299B7.80009@gmail.com>
References: <efe536470903070205w1dbff989je6dd6126d09e4a74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Navarro <crshman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 17:00:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfyx0-0003Zn-3H
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 17:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbZCGP7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 10:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZCGP7F
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 10:59:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:45056 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZCGP7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 10:59:02 -0500
Received: by fg-out-1718.google.com with SMTP id 16so651926fgg.17
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=QP014+eFSKT8BEgA+WerQ/BRAJmDT8pvn8FtnaSgd4Q=;
        b=bWS5XTmxZtW5MeIguLKHe9vRsPwu/9agBp4oi9D7jrVLFUb8S1jyR0a9ZTe8b3ktAq
         udDi0K1e7+n0tyG29hLZG2xabNEIpB5UC3mc4GqRckOe7f8tYNB2KgQ5uqtdC/GTZRXH
         7mHX2OuswPAmX1nkldjlQnRqhBxviOWFprl+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KgFi7eERt6W5wjh8/LX8UJtvl+yR+UIIGKQ3SiuffOIgZ8fWJANr5c6lk8UuLL3urb
         FbMY/2B4+vhAKS/X12i/I+G+ZXSGoPDuqFhz5Ekj7tWjvINUHlwAUs6dJS2/EgrqpOpB
         3gF4UrDHibSFiQZyU5KgKLMNiNyOBLYfJIwCk=
Received: by 10.86.91.3 with SMTP id o3mr2749989fgb.3.1236441539955;
        Sat, 07 Mar 2009 07:58:59 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l19sm1141013fgb.27.2009.03.07.07.58.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Mar 2009 07:58:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <efe536470903070205w1dbff989je6dd6126d09e4a74@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112546>

Robert Navarro wrote:
> Hello,
> 
> Sorry about my last "subscribe" email, skipped over this part in the
> wiki...."You don't even need to be subscribed to post, just send an
> email to: "
> 
> Anyways.....I wasn't sure where to post this but I'll give it a shot
> here.....I know there is an eclipse jGit plugin in the works and I
> wanted to know if it would be possible to get a remember or recently
> used servers feature added to the push/pull feature.

I have done some initial prototyping of a Remotes View. I'll see if I
can bring that to life somehow.

Tor Arne
