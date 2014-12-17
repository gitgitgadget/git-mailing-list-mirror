From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Update documentation occurrences of filename .sh
Date: Tue, 16 Dec 2014 16:42:29 -0800
Message-ID: <20141217004229.GB9757@google.com>
References: <548EF174.1010705@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 01:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y12hJ-0001Tn-2W
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 01:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbaLQAmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 19:42:33 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35513 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaLQAmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 19:42:32 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so8068745igi.6
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 16:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=A8HJwRqs0AJpOsPMxWlS661y8ZPtHS7ZOQ18irYNkew=;
        b=dvjvztnyGW+EzRBXaKGGTtKWK/d1C+ND26Wn5Cy73v4M2KQWLkwpB8Ot7aswxv6c+/
         2z2MV7lUixPzyR9J5Nf/4OXCBFJcIqYrfqd0SbY0sf0nBJRL53IHmvbNAk66Dv1F3yvI
         dn2aTmke3ZlTgyIovW0UQwRNutNMPYCPTBXm3KVP6gT1gQZyBTw9ZoGPe70p+Kt6AEOe
         3vtL+WpXLdwKGVE3jf5x4D+PfR3X8aRAyblNUhs50zy3sQ9yG005gcEDf3dTaoVcTbBN
         Vor/6BoRutHJIXXIlR0AXSzVii/mjXQrhCcthpUYQicEPINwQiHcljE+7kiIa9Y7qCa+
         BsKA==
X-Received: by 10.42.199.211 with SMTP id et19mr27289321icb.9.1418776951942;
        Tue, 16 Dec 2014 16:42:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddbd:b61f:6954:5426])
        by mx.google.com with ESMTPSA id qj6sm7098280igc.1.2014.12.16.16.42.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 16:42:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <548EF174.1010705@avirtualhome.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261473>

Peter van der Does wrote:

> Documentation in the completion scripts for Bash and Zsh state the wrong filenames.
>
> Signed-off-by: Peter van der Does <peter@avirtualhome.com>
> ---
>  contrib/completion/git-completion.bash | 4 ++--
>  contrib/completion/git-completion.zsh  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
