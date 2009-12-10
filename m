From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Thu, 10 Dec 2009 15:40:43 +0100
Message-ID: <200912101540.43521.johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net> <200912101039.44526.johan@herland.net> <20091210140317.GA30665@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 10 15:41:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIkCZ-0004MB-P5
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 15:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbZLJOk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 09:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZLJOk4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 09:40:56 -0500
Received: from smtp.opera.com ([213.236.208.81]:36091 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbZLJOkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 09:40:55 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id nBAEcmH7027331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 Dec 2009 14:38:53 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20091210140317.GA30665@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 10 December 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > Do you have more comments/suggestions on this patch? Or is it ok to
> > include in fast-import as-is?
>
> Oops, sorry.
>
> No, no additional comments.  I am happy with this patch.
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks.

Junio: With the above Ack, I believe patches #1 - #4 (and possibly #5) 
from this series are ready for 'next'.

You may want to hold off on the remainder of the series until I get 
around to writing some functionality that actually _uses_ the new API.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
