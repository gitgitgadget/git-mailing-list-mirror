From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 2 Oct 2006 22:03:44 +0200
Message-ID: <200610022203.44733.jnareb@gmail.com>
References: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 22:04:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUU0i-0001Y9-Ck
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 22:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWJBUD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 16:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWJBUD3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 16:03:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:41420 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964941AbWJBUD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 16:03:28 -0400
Received: by ug-out-1314.google.com with SMTP id o38so550829ugd
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 13:03:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j+jqIAlFQuguebb5VpWJnNrhBgh1vLvyLg2fvGCJhRhhMz9JTH5eRNi9HBqVIYDNPIkNg/aVOC0KnAFYnygPcD6qHUjRMRTQ4jgqdEFauAOTH2Thn9mUpnnFyhgJ/32yXM/1HdrJOpBb3k+/l4UORfU1yUgy3VLSIBRhtUnyPI0=
Received: by 10.67.21.11 with SMTP id y11mr2972842ugi;
        Mon, 02 Oct 2006 13:03:27 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id y1sm2762173uge.2006.10.02.13.03.26;
        Mon, 02 Oct 2006 13:03:26 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28235>

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> I think that redundancy in a visual interface (and not only visual, as 
>> seen in the example of Perl programming language) is a good idea, 
>> contrary to the redundancy in code or data (database).
> 
> Jakub,
> 
> Your opinion here is highly subjective.

Yours too.
 
> Years of experience make certain things "make sense" and other
> "make less sense".  Note that that is in itself subjective.
> 
> Give it 10 years, your opinion will change.

Perhaps. Perhaps not.

I guess we have to agree to disagree. It's Junio opinion that
matters (which patches would get accepted).

I'd like to mention that there are if I remember correctly
some other places, like "commit" view which have this hated by
you redundancy.
-- 
Jakub Narebski
Poland
