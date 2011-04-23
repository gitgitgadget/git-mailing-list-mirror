From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Log not displaying properly?
Date: Sat, 23 Apr 2011 15:24:53 -0500
Message-ID: <20110423202453.GA31200@elie>
References: <1303529113364-6298788.post@n2.nabble.com>
 <1303577279897-6299742.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: adam_kb <a-kyle@hotmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDjOS-0006lP-GJ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 22:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab1DWUZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 16:25:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53158 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab1DWUZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 16:25:00 -0400
Received: by iyb14 with SMTP id 14so1094973iyb.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ddYmwoaOhEE4VUzTfHPmoPytFscRGtcQiUVffphn8qM=;
        b=f6+FVgORgE9/mK15EAD4hJxfkgatVH5qFR+TNoRIa4hwbu99Je+lRsOZuaZvpDaUrg
         85tFdf6UwskCOYoa+VbOu54cWy2aIM9tLajQocFNa7EbmFSKyufJuMESvtjibDSGr10+
         f5F3r4rPxdBqm4z4huWd92Hx8AnPv8oO76lMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ICItHobqBnqnNpT0bwzn9hkrE9TjKH+IT27nNevG7GkpFaeSKDIPp/NbXwzWcsIvIc
         +VrTY9nCccQWh6joOeJsk+P/75u2mijEwmjaeokSkKsseq4GQcaqmiaWbFOFJGUjQyt1
         vc2i/YSy+F/RJ7YognHxX/3N62Yagstu04kNw=
Received: by 10.42.108.7 with SMTP id f7mr3001837icp.460.1303590299639;
        Sat, 23 Apr 2011 13:24:59 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id i20sm1602499iby.14.2011.04.23.13.24.57
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 13:24:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303577279897-6299742.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171987>

Hi,

adam_kb wrote:

> Hi guys Could I get some help on this issue? Thanks

See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html

By this I don't mean that it's a bug necessarily, just that the
interested people on the list might have had trouble imagining what
exactly went wrong (or in other words, how to reproduce it).  So it
can help to show us.

Thanks for writing,
Jonathan
