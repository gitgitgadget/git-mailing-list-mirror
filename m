From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sat, 2 Sep 2006 20:10:01 +0200
Message-ID: <e5bfff550609021110x2fcfdc52r2cdce9c23ff46b14@mail.gmail.com>
References: <200609021817.09296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 20:10:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJZwW-0008JH-7S
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 20:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWIBSKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 14:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWIBSKE
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 14:10:04 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:20672 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750727AbWIBSKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 14:10:02 -0400
Received: by py-out-1112.google.com with SMTP id n25so1835007pyg
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 11:10:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PPnDfXDsEDokR8WHZX19lkaZzVDf/Hp08/zsgczyh/mD3v2ZZ8RjH659Js3qgmMlUJW6qx0W5dRKRr+q4W9t4bEWLcIqIWbuUufCuphYKJ3BEGun362TYAmDIf0ItPmT2EEgh77wLiGxo3V6EgPphzc9q2D9cQCXC6I3M9WmiZ4=
Received: by 10.35.49.1 with SMTP id b1mr5868019pyk;
        Sat, 02 Sep 2006 11:10:01 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 2 Sep 2006 11:10:01 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200609021817.09296.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26349>

>
> * Code highlighting in blob view (from gitweb-xmms2), or to generalize
>   to allow for generalized filter. The higlighter should have support
>   for HTML support, it should always close elements before end of line,
>   it would be better if it used CSS for styling, and it should accept
>   file to highlight on standard input. gitweb-xmms2 uses Highlight
>     http://www.andre-simon.de/
>   but GNU Highlight (src-hilite) could be used instead
>     http://www.gnu.org/software/src-highlite/
>

Current HEAD of qgit  (I plan to release the new version very shortly)
uses GNU Highlight. I can say this tool is easy to use yet very
flexible and configurable and, last but not the least, the developer
is very responsive.

My two cents.

  Marco

-- 
VGER BF report: U 0.500001
