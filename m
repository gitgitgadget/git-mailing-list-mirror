From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Tue, 15 Aug 2006 10:55:02 -0400
Message-ID: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com>
References: <20060815083303.13253.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 16:55:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD0Jx-0001P2-OL
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 16:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWHOOzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWHOOzF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 10:55:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:34393 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030336AbWHOOzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 10:55:04 -0400
Received: by nf-out-0910.google.com with SMTP id x30so351889nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 07:55:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RG+xRoZXqC3OttX+SUNuNGXUNl5w/rSrTp6P5XeOeO5jOjkuwTqwlMsT/6LagYSLwGQstgl0mhkytg1DCoIvYIANsZ4SMtmKsMq4eXRo4UDYDz3B5vJYsUTITxjLspH2DrHS8hv0pYN1ZLGT1Z8SDl9WsHIA+4ArL3A7AZ+Q5io=
Received: by 10.49.8.10 with SMTP id l10mr1454865nfi;
        Tue, 15 Aug 2006 07:55:02 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Tue, 15 Aug 2006 07:55:02 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060815083303.13253.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25458>

I explained our situation to Mark Adler, zlib author, and he recommend
checking out this book for techniques that can be used.

http://www.cs.mu.oz.au/mg/

-----
Jon Smirl
jonsmirl@gmail.com
