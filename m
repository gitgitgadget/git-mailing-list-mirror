From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 09:52:19 +0100
Message-ID: <38b2ab8a0701260052q517285e8l2505114a48d34558@mail.gmail.com>
References: <20070125173954.GA13276@spearce.org>
	 <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
	 <7v7ivaailb.fsf@assigned-by-dhcp.cox.net>
	 <20070125214923.GD13874@spearce.org>
	 <Pine.LNX.4.64.0701251830400.3021@xanadu.home>
	 <7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 09:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMpD-0001Fw-Qx
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 09:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030831AbXAZIwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 03:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030830AbXAZIwW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 03:52:22 -0500
Received: from hu-out-0506.google.com ([72.14.214.226]:9684 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030835AbXAZIwV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 03:52:21 -0500
Received: by hu-out-0506.google.com with SMTP id 36so616520hui
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 00:52:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jr0Ep+im1SZvK5Er/Tn4pA6WerLE/M25KXMqALLi9UTMnBK57w6El8es+YvayhNAa4FajnG7DBMkSFwnYaLLXML+mDJXthyCyVGf3vyIqOFWtZpMpJb++EBFJuhp08mEck2KVYlwwzwBmTgpzUnVB6ocoy3LH2LVTJtIN/VQa+8=
Received: by 10.49.68.6 with SMTP id v6mr5338282nfk.1169801539175;
        Fri, 26 Jan 2007 00:52:19 -0800 (PST)
Received: by 10.49.30.4 with HTTP; Fri, 26 Jan 2007 00:52:19 -0800 (PST)
In-Reply-To: <7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37812>

On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
> Another backward incompatibility to mention in the release
> notes.  I guess it is not too big a deal but makes me feel
> uneasy.
>

Sorry if I missed any discussions about that point but why not calling
the coming release 2.0 instead of 1.5 if this one implies some
backward incompabilities and a lot of change in the UI ?

thanks
-- 
Francis
