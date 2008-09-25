From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 23:23:26 +0200
Message-ID: <200809252323.27290.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <200809251423.56983.jnareb@gmail.com> <BC7F2CB5-A31A-40C8-A22F-F0AAECB091C6@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 23:24:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiyKR-00053d-US
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYIYVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbYIYVXk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:23:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:2289 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYIYVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:23:39 -0400
Received: by ug-out-1314.google.com with SMTP id k3so280049ugf.37
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GArtbSzB+cCQ747WufWsxJHT+iRX8/Hx6UjzemBeLyA=;
        b=v9sLGmb/g/L3fhxRQy/l3sqbMMKoPe9L9fAQAV5OS1a1upFtk4LFEEI18tPNBheS0O
         l8UzO9+qTunPlelXD5MgTH8AAY5fyx7vWZCE1DYFOYmPTyQgcr+5HnAGem2s82mTgfLz
         qVSnLzxKH/YW1+Exu4gfR1i/YefTZHUKhU3Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bYgNujeifTBWluV/trB8phkvBtrV118AIhw0XNgP7ld+IWUg1jmzr0e51V98NnXwsu
         +lHCLeVMEsXEjuKxQqeYiAR85GOkxq6CzR7yRzAqQ3FnsK79uZOdi2UzTDjNDKmCPe/q
         +FT/s9qK6Nqkr571H2dI2J9bfyCazQOknTgOk=
Received: by 10.102.228.10 with SMTP id a10mr245011muh.109.1222377817698;
        Thu, 25 Sep 2008 14:23:37 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.235.56])
        by mx.google.com with ESMTPS id w5sm2378783mue.10.2008.09.25.14.23.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 14:23:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BC7F2CB5-A31A-40C8-A22F-F0AAECB091C6@simplicidade.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96803>

Pedro Melo wrote:

> While researching HTTP::Engine (I use Catalyst and they where talking  
> about moving to it), I also came across a new HTTP layer, called  
> Mango. Also on CPAN, so same conditional code applies.
> 
> Right now, I'm not sure what the Cat team is thinking, HTTP::Engine or  
> Mango, or other, but I suggest the use of the stack then end up  
> choosing. The Cat team has a very good test-driven way-of-doing  
> things, and the modules they use tend to stabilize very quickly.

I think I'll wait for results of your/Catalyst research then... ;-)

-- 
Jakub Narebski
Poland
