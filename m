From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 17:22:08 +0200
Message-ID: <e5bfff550608190822o6d99c390he15612aa3f8afd14@mail.gmail.com>
References: <1155990772.6591@hammerfest>
	 <e5bfff550608190623j58de8c1cn6a9304249ee1ecb8@mail.gmail.com>
	 <20060819132922.GA6644@code-monkey.de>
	 <e5bfff550608190819i3cade548g28b2c95fab172a49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 19 17:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GESeL-0007eL-HH
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 17:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWHSPWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHSPWK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 11:22:10 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:53687 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751459AbWHSPWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 11:22:08 -0400
Received: by py-out-1112.google.com with SMTP id n25so1602828pyg
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 08:22:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sxknwICSQMaEylwga+vRsZFmmj3kCg/Ir45j+lx/pkwWih5q2J5JLOMcQnwg6SLUyVk+KYINvsjeV6TjtMbL/BqqyMwR88zk+0WTDmY0EcBks0SV5sanLcAr9nrXKCnfuY4Y/2j9CgVwthn9ctgD9KWuf8sCEIGnUNT/uZ7M89I=
Received: by 10.35.61.14 with SMTP id o14mr8553655pyk;
        Sat, 19 Aug 2006 08:22:08 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 19 Aug 2006 08:22:08 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <e5bfff550608190819i3cade548g28b2c95fab172a49@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25726>

> logical one. So operands must be booleans (or numerical types in case
> of C).

Operands must be numerical types of course, not booleans!!
