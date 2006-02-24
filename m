From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: gitview: Use monospace font to draw the branch and tag name
Date: Fri, 24 Feb 2006 21:59:15 +0530
Message-ID: <cc723f590602240829y3ebffaf9mdd7de0cd2a9051e@mail.gmail.com>
References: <43FC8BF2.60205@gmail.com>
	 <7vr75tc8gj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 17:29:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCfom-00024u-OQ
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 17:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWBXQ3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBXQ3S
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 11:29:18 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:38525 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932357AbWBXQ3R convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 11:29:17 -0500
Received: by uproxy.gmail.com with SMTP id a2so146523ugf
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 08:29:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NVQrlqxxY5zdC5XPO8/Yj0X9/a30t/qdH3HtY9ifEpJGDLNQOszOsXamyOhso3vKyPmtm1+43QRw7c2GEEzKYFiS+eD6MuWd0Es1m7pRz7iJfu7cU8JXuI/IWPDeZCbW/VbrBAdUC4wJRI7Xsj4Ns4ahfFyQ0uUSsdQjgzfpDAU=
Received: by 10.66.243.7 with SMTP id q7mr3088624ugh;
        Fri, 24 Feb 2006 08:29:15 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Fri, 24 Feb 2006 08:29:15 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr75tc8gj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16713>

On 2/24/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
>
> > This patch address the below:
> > Use monospace font to draw branch and tag name
> > set the font size to 13.
>
> I have an impression that hardcoding UI policy like this is
> generally frowned upon.

But with that changes branch and the tag name looks neat.

May be down the  line we can add a prefernce tag that will allow the
user to change all these hardcoded values.

-aneesh
