From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: use symbolic font names "sans" and "monospace"
 when available
Date: Thu, 8 Mar 2012 07:26:07 -0600
Message-ID: <20120308132607.GE2181@burratino>
References: <20120308123011.GA4355@burratino>
 <20120308124635.GA24679@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Mark Hills <mark@pogo.org.uk>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dMJ-0000yf-2h
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab2CHN0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:26:15 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42032 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815Ab2CHN0O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 08:26:14 -0500
Received: by obbuo6 with SMTP id uo6so658360obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nj28rX5hP/JJdtQFS34QdcrHVDpRnMXQ/9TkRzyvchc=;
        b=KGNbwsTIxMb2uCVAFtASpgau/ji9gTuNk2ZCTAzUO37nt0ak0edcVucemOhvJK3qtn
         PbbiFpcjGwO9nEKvC4Si5mmRsgAzn/QBIAhKDMWhY9f3Tg/XUzI1nujHce6zvwfrDsxL
         RGzQIa2TMsewjXx2PW+IbZnuo7hTl7JJHl/s8+mK3b60swpWhixL4oL7QefyyyvaVbPO
         /S4rjdaDZ5SYQeZMgY8OWO0txdEcon4G3X4YiH0ceDMmEe/hBto7Lga+ll/FtXratxD8
         6JXkPbGOyyb2qRFc+/EHsqXhXLYXIqPJ4rfJ2mfshKbJazIII++pfqe3s6MePOkisnHC
         ABKw==
Received: by 10.182.231.100 with SMTP id tf4mr2298274obc.56.1331213173813;
        Thu, 08 Mar 2012 05:26:13 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d9sm2585501obq.0.2012.03.08.05.26.12
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:26:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124635.GA24679@leaf>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192600>

Josh Triplett wrote:

> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Thanks for looking it over.
