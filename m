From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict resolution - take 2
Date: Fri, 4 Aug 2006 10:09:36 +0200
Message-ID: <81b0412b0608040109q683bd628rd9238662e0fdfb0@mail.gmail.com>
References: <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
	 <11546518271379-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 10:10:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8ukj-000728-1V
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 10:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWHDIJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 04:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWHDIJj
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 04:09:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:14764 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161099AbWHDIJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 04:09:38 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1279069nfb
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 01:09:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eJraQFK0skYuFVUqMAQXTgwc9pieCjSQBMBlNLCPRuR7rsnXyuUBQrZvtqgmtpinNG6euF+h4OikbUlvvzH+IRcUbAPrdmzU8YE1En77R521OqHKeAqOl6EuKR3uZotJN1fvqFE6nmMuk6WH/sztgtpRZPq1NLfQPiIZiXD2xm4=
Received: by 10.78.107.8 with SMTP id f8mr1437981huc;
        Fri, 04 Aug 2006 01:09:36 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Fri, 4 Aug 2006 01:09:36 -0700 (PDT)
To: "Martin Langhoff" <martin@catalyst.net.nz>
In-Reply-To: <11546518271379-git-send-email-martin@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24779>

On 8/4/06, Martin Langhoff <martin@catalyst.net.nz> wrote:
> This is a bit of a crude but really useful shortcut for conflict resolution.
> The name is bad, but git-merge-* is a different 'namespace', and git-resolve is
> also taken.

git-xxmerge?
