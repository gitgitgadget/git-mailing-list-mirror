From: Aubrey <aubreylee@gmail.com>
Subject: Re: how to make a git-format patch
Date: Thu, 13 Apr 2006 13:36:05 +0800
Message-ID: <6d6a94c50604122236i47f3c2e9s7656118eda95a2cd@mail.gmail.com>
References: <6d6a94c50604120328ufa09f0do76c04472206ae15f@mail.gmail.com>
	 <m3sloiriu7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 07:36:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTuVD-0001Ll-8u
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 07:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWDMFgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 01:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWDMFgK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 01:36:10 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:9416 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964796AbWDMFgH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 01:36:07 -0400
Received: by nproxy.gmail.com with SMTP id g2so1159351nfe
        for <git@vger.kernel.org>; Wed, 12 Apr 2006 22:36:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DBlTpK12CyjvcoHBfsFN5NSo+uQ0nW1mbghOLQYdjEt+vwoA/wMu8kr+d5AAQTI55csLDbQCzKpcbz70NK7az2EizkmiD04F0tGyyyLqH4jPMO/6u5l3exvvXyaRYIUq0FgaCZsHx6lZ9afhrfYo53NPLG7Ka45LjE1eJALUpEQ=
Received: by 10.48.212.16 with SMTP id k16mr51749nfg;
        Wed, 12 Apr 2006 22:36:05 -0700 (PDT)
Received: by 10.48.220.18 with HTTP; Wed, 12 Apr 2006 22:36:05 -0700 (PDT)
To: "Mathieu Chouquet-Stringer" <ml2news@free.fr>
In-Reply-To: <m3sloiriu7.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18649>

On 12 Apr 2006 16:04:16 +0200, Mathieu Chouquet-Stringer
<ml2news@free.fr> wrote:
> I believe you're talking about 'git whatchanged -p' which not only displays
> the diffs but also the commit comments.

git whatchanged -p didn't include the signoff and howmany lines
changed which git-format-patch seems not include commit comments.

Is there one command to merge the two kind of message?

Thanks,
-Aubrey
