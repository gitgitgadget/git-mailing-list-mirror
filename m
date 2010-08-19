From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/update-contrib-example-merge in pu
Date: Wed, 18 Aug 2010 22:22:23 -0500
Message-ID: <20100819032223.GA23298@burratino>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 05:24:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olvjh-0007oJ-No
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 05:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab0HSDYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 23:24:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38473 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HSDYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 23:24:07 -0400
Received: by gxk23 with SMTP id 23so496006gxk.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1NlG0d4nMpyURilxzB5DVYIerWlvQcjiYygBT5dRo7E=;
        b=w4EP+djsfJ9JTuB61UPIR0SCmf/HOOr4j5NvjgiR1BAuo23XDygJJ8TeOHhLBmAm31
         vbX91vwLHZI3mwmR+e9Cx3p729CLNy7RWNzAzpiC7dhsu560JVAxRRS3eHxofmE0iTi0
         SiptHRELpu9YNdbXUxf1V1vWfo3QhRsyFIqNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ksFLzPBhRd0AQj09mvV+d8kSd6a7UxJoufhLIVsCstzQo7/Yi6mPg+fgKwtSL86A6E
         RlQnHDOOz74cgDYucWAvs57tckgCELmXrmEfXv5IRE+zdJctPs9/haLxkI9aVXgbaPvp
         X+vI61vhriuFB+99WJvP9pgyf8jzB8pI2/m1M=
Received: by 10.151.107.7 with SMTP id j7mr1447324ybm.130.1282188246462;
        Wed, 18 Aug 2010 20:24:06 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q36sm2888525yba.12.2010.08.18.20.24.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 20:24:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153907>

Junio C Hamano wrote:

> * jn/update-contrib-example-merge (2010-08-17) 25 commits
>  - mergetool: Skip autoresolved paths

How did that get there?

Confused,
Jonathan
