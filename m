From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 02/18] http-push, http-walker: style fixes
Date: Mon, 25 May 2009 20:03:55 +0800
Message-ID: <be6fef0d0905250503s8a6facax94dc19ff4a462b70@mail.gmail.com>
References: <20090524221941.8670c41d.rctay89@gmail.com>
	 <7v7i06ut92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 14:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YvA-0004pb-83
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbZEYMEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 08:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbZEYMEG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 08:04:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:17689 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZEYMEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 08:04:04 -0400
Received: by wa-out-1112.google.com with SMTP id j5so700295wah.21
        for <git@vger.kernel.org>; Mon, 25 May 2009 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XaqpgNB3yF+mn/sBu+ZKC1Ni3clKlTCcCSyuTsEi/Cg=;
        b=lXxu8EOWsYfxrwpc3qdnBSkvEVtCwSn0/tjEyi5EK/tewuiyZ8P/QieFgbfU0FsPkR
         haIxvK7zFxyUAvQRVKu46DtHrrlHNN0lvkJZ+ORG1oVzKzbWc/s4jT9HJzYqEMSOsLB2
         SKTCSREDd3eyboPo7KUt/DqUk/a6HSeumNAlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UImxLzZgxXm0c/zcArJBrk6JmDSf+rAb8Hktv7L3Quf2n7ULjhzEpu/59MJ6PwMzVb
         VOcPCwfGZqyL4dBdtRJh7nfx6YDihMb0sOsdqZP6ZBTWqrFSktlXsJAJjUThJzjUBCsG
         /wVbgluVzy2B72kHiGOvvc5+UjzJ2q006Fs9A=
Received: by 10.114.182.1 with SMTP id e1mr13945304waf.163.1243253035225; Mon, 
	25 May 2009 05:03:55 -0700 (PDT)
In-Reply-To: <7v7i06ut92.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119929>

Hi,

On Mon, May 25, 2009 at 4:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> We need to apply a style fix to your commit messages first.

thanks for taking the time to go through this gargantuan series; your
suggestions and comments are really appreciated. I'll fix it soon.

-- 
Cheers,
Ray Chuan
