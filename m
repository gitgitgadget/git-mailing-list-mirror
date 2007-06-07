From: "Bryan Childs" <godeater@gmail.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Thu, 7 Jun 2007 08:57:31 +0100
Message-ID: <5971b1ba0706070057l2d4b170emd8af733d888d6a56@mail.gmail.com>
References: <20070607043632.31891.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "linux@horizon.com" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 09:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwCsF-0000aP-Dd
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 09:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbXFGH5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 03:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbXFGH5d
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 03:57:33 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:2434 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbXFGH5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 03:57:32 -0400
Received: by py-out-1112.google.com with SMTP id a29so715609pyi
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 00:57:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d64+7tKwrcG5NbyxOcCb2YlhclD4pLCyaU88ga3IUQko/h57qudPecycYH2ji+EJbN6YKL9kCzjf0tihpZQMAa4XSrqUepqW0hmXJrT+ehVcpkk7TnFo7zIRl97lWT+KN65nSH617pSWMReKnS4iG9lrwhWbgGvPe9D6vSpeXB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWrUVneqdYGUPzF6ArT7DsyZkpZUzbE0aENOmUCjV+a6i6nvDasXjZ1KohMeIOflF5aYYPA+xaRavi2X/6y5OkvF9sbN/ysrUXcssKToajqmG06ZiaXQy5bDYI3U2fJ/Jq9JOgaWRNyHBPOa15EwOdQuyhDj0IC1hOY0WoOe+oM=
Received: by 10.65.203.3 with SMTP id f3mr1240843qbq.1181203051304;
        Thu, 07 Jun 2007 00:57:31 -0700 (PDT)
Received: by 10.65.196.14 with HTTP; Thu, 7 Jun 2007 00:57:31 -0700 (PDT)
In-Reply-To: <20070607043632.31891.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49362>

On 7 Jun 2007 00:36:32 -0400, linux@horizon.com <linux@horizon.com> wrote:
> There's no reason that git can't do everything you have svn doing.
> What SVN calls "commit access" is what git refers to as "push access",
> but it's exactly the same thing.  I don't see how it's the tiniest bit
> more difficult.

<snip>

Thanks for this extremely length and informative reply - it's answered
all our concerns, and we may well move to git sooner rather than later
now!

Bryan
