From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] qgit4: Add a header and set the font family appropriately to the log message
Date: Fri, 9 Feb 2007 06:44:35 +0100
Message-ID: <e5bfff550702082144h7ae6de5ai23853f43fb27f345@mail.gmail.com>
References: <200702082158.56463.andyparkins@gmail.com>
	 <200702082331.13095.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 06:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFOYq-00069h-JY
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 06:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946122AbXBIFoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 00:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946124AbXBIFoh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 00:44:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23965 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946122AbXBIFog (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 00:44:36 -0500
Received: by wr-out-0506.google.com with SMTP id 68so799433wri
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 21:44:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s2bqYrgdy4pTxDWOCVfIUBiYaRXOTjyTvoEi4L4rksDarED0E5b7cVmhZVi5b8q3YEhUSyrFZlizqHhV57Bf+ECURNNw7xQS7CxTSWa1x5/0nzl9gdtsaR/U3+qfl4v6H74O9JbwS2e+9PmDTSdgrGVIA2tiwWJ3/yeEAexp6+Y=
Received: by 10.114.211.1 with SMTP id j1mr4666928wag.1170999875460;
        Thu, 08 Feb 2007 21:44:35 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Thu, 8 Feb 2007 21:44:35 -0800 (PST)
In-Reply-To: <200702082331.13095.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39155>

On 2/9/07, Andy Parkins <andyparkins@gmail.com> wrote:
> I've moved the short log to be the first header row, and highlighted it
> more strongly.  I've also set the font family of the log div based on
> TYPE_WRITER_FONT as suggested by Marco.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---

This patch does not apply on my qgit4 repo, it seems it is on the top
of a your not published previous patch. Could you please rebase
against current public qgi4 repo (git://repo.or.cz/qgit4.git)

Other two patches has been applied and pushed.

Thanks
Marco
