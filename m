From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Fri, 11 Jul 2008 23:55:50 +0200
Message-ID: <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <alpine.DEB.1.00.0807112238350.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:56:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQbi-0002Bo-QL
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbYGKVzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbYGKVzw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:55:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:40811 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbYGKVzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:55:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1985656ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RXOndrkYFC+QIrtYotbQ7IY8chNBHTAENK+ULI7WiEk=;
        b=jysv05OsKfF8HcOuWonb2GFE0w6MYKharfm2OmlzCl9T9ta155DyMQTxFz12zuwjzA
         SS0PrqTeuQTgSvDfOydH3gYWQ+RX0BT6j/VefYNTpqq/mFgL923dBwfFMTUb6VjrlSCR
         i+0Jz26twTehDE9p+kl8uFbi9/fjXeSQ6mxVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=KhAZ1UBzxtjd4l+RCffAwNCYTJfRMS/24ORiRkb1JM+mQ3aYQ9K2n7o4rKfeuMmRc+
         Rr8AW+E1zsC08pRv/h/2LTNLpzZoVL7Pgf8wIux+GnXjSvO6Ew2eJBrjcIz6VXBIqmqv
         VB6EMYfKA1UdibeJn/UAwkhU00niMu4t5YI0Q=
Received: by 10.151.108.17 with SMTP id k17mr16673745ybm.31.1215813350922;
        Fri, 11 Jul 2008 14:55:50 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 14:55:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807112238350.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88185>

Heya,

On Fri, Jul 11, 2008 at 11:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> something else I just realized: you might want to use .mailmap, e.g. to
> coalesce the changes of Shawn "O." Pearce correctly.

Ah, hmmm, but I'm not sure how, as not nearly every developer is in
the .mailmap file and many devs use different e-mails while most use
the same name. A similar file containing developer aliases maybe?
E.g.:
"Shawn Pearce = Shawn O. Pearce"?


-- 
Cheers,

Sverre Rabbelier
