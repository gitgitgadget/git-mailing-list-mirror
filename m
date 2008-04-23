From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 1/3] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 16:12:25 -0400
Message-ID: <32541b130804231312n50e86ce6g2b2331ca514ba982@mail.gmail.com>
References: <1208979757-30860-1-git-send-email-apenwarr@gmail.com>
	 <alpine.DEB.1.00.0804232104160.20267@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:13:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JolL7-0000le-W8
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 22:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbYDWUM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbYDWUM1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 16:12:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:36569 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYDWUM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 16:12:26 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3977834fkr.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uz4rXd1fqF6N/gYggnx4Dj4Smlx9KIHosijldGhxz74=;
        b=nSfMhtlTVbxost0WPH3JcJEu6iXU2naC1QQuxkURDtOgp7XNzDyTYHtORcnPmtTDZ9kKkxPCOl2DPtTXFZCVrNWcCqUviBzeo2yl/xofxmppMaX5fznl+Ci01ldmsFzy47zE2SZEgvFMBympv9hDoeFt6sG4eE3ZfQoQGqk7ggE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ou03ZAkZbQlNU9din5YUjp6tmZqzgwy8rF5p5/YI5LON0Wde6HDw0sqHEGSFz3DlrkUODkEbBVnu1uIy6TiNy9CrCVCu4vwmfjR/B8HgqamoMexg/Idva7Fm9ySGx1k6exDPsul3SsfFnNU3zx74aNwz61K0FbRoBMKGJRRSSjY=
Received: by 10.82.159.2 with SMTP id h2mr1660358bue.25.1208981545043;
        Wed, 23 Apr 2008 13:12:25 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 23 Apr 2008 13:12:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804232104160.20267@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80256>

On 4/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Not all of this belongs in the commit messaage.
>
>  > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This does.
>
>  A good general rule is: if you think it would be funny/strange to read
>  this message in the output of "git log", it should be changed.

I felt uncomfortable modifying the message attached to Jeff's patch
(which actually does pretty clearly explain what's going on), since
it's not mine.  If he wants to send me a better commit message,
that'll be fine too.

Have fun,

Avery
