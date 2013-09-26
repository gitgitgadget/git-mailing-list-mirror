From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove ciabot from contrib
Date: Thu, 26 Sep 2013 15:54:03 -0700
Message-ID: <20130926225403.GI9464@google.com>
References: <1380227582-7836-1-git-send-email-stefanbeller@googlemail.com>
 <20130926211304.GA19056@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 00:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPKRp-0004Ko-O6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 00:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab3IZWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 18:54:08 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:53135 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab3IZWyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 18:54:07 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1742316pbc.21
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D5kamG4IHXvRPQRXzyEQVp+WLdgV3OGsg4JsP0eAEgo=;
        b=06XLCg15vgTuy30Xs52NVAOPRZC+nNT2qhsnBXen6vD5CuNK0ZHT0G36HSe4EB1t9T
         cLKqazEpTJp6X9dvw0xwgYjNweldMrL1/c+7Z+RHqyXgieuU4L/eU03WGUb36xeSUrVR
         gVsTVPPSuWBDOQlerjbjGWtq9S77eAMIIuvweyknghT9xnIQsDMWkOlc6R7R3O5k+5/x
         qLhb5nxbKAKBZYuoL3bPUej9ZaXxqkJBh3yxonDoF9929Op0a6WVa8ruO0jZQ21KA+WW
         L02nEB4jQq8epyos5kdlfJW51yKEg7BX9Df1WDxgVh4XGEeiFbls+yp6QRH36Qvw4mMI
         Omgw==
X-Received: by 10.68.215.38 with SMTP id of6mr3942570pbc.14.1380236047265;
        Thu, 26 Sep 2013 15:54:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wp8sm4554592pbc.26.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 15:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130926211304.GA19056@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235439>

Eric S. Raymond wrote:
> Stefan Beller <stefanbeller@googlemail.com>:

>> According to
>> http://thread.gmane.org/gmane.comp.version-control.git/212649
>> Eric, the original author of ciabot, doesn't want the ciabot
>> no longer be included in git.git, hence the removal of the
>> whole directory.
>
> Note: I was *not* the original author of the ciabot scripts.  I was
> their maintainer (baton passed to me by the original authors) when
> the CIA service irrecoverably crashed, and did suggest they be
> removed.
[...]
> I think enough time has passed that removal would be appropriate.

Thanks, all.
