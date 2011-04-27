From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for
 color.diff
Date: Wed, 27 Apr 2011 17:12:15 -0500
Message-ID: <20110427221215.GC18596@elie>
References: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
 <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net>
 <20110427090323.GA14849@elie>
 <7v7hafabsj.fsf@alter.siamese.dyndns.org>
 <7vliyv7djb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:19:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFD5L-0007a2-30
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1D0WTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 18:19:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56025 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1D0WTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 18:19:45 -0400
Received: by yia27 with SMTP id 27so777701yia.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KyuwQDIrFBx0vOEaOz27YeOda3ZcdG8LMCUHW2SJI9I=;
        b=tNPNHVu/Ju3qJn6/0S0lvcidHY4dWWRwQ965F/HAoRJdvcAOux1HiObPZiZzt81W8h
         1XMQliiO2vlgazEWgaDUsXqMqqmpw3HZjG/ngesGGhKqjZ0c+UUdH6BZHgo2LHoW86tY
         yKMxZ6iwVJXBgrj1w5a4gnkZx2uhoPhqk3zdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ctcYK+RvcCdUMLF3JQ6r50bfDBaKiUFXazzVvARF1fCL7f3dDlce13ME/qtfj77DAT
         8np+OuvvEwbl94bzJThkPcWUDyKdt/8lkFfg6BUkSqpBhDXT2N7pdy5pPcID1WKbUIHf
         HDH7F9zWUBqswN/HOy1zJmHZDM0JYmqTVaRSc=
Received: by 10.146.33.3 with SMTP id g3mr2388621yag.23.1303942339815;
        Wed, 27 Apr 2011 15:12:19 -0700 (PDT)
Received: from elie (adsl-69-209-61-200.dsl.chcgil.sbcglobal.net [69.209.61.200])
        by mx.google.com with ESMTPS id g37sm1174975anj.28.2011.04.27.15.12.17
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 15:12:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vliyv7djb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172281>

Junio C Hamano wrote:

> I'll queue the following.

Thanks; looks good.
