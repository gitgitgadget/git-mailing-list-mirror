From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 22 Mar 2006 11:21:45 +0100
Message-ID: <4fb292fa0603220221q5f3bf9c7pd73154a34e79a523@mail.gmail.com>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 11:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM0Tc-00016i-01
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 11:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWCVKVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 05:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCVKVz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 05:21:55 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:5386 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751194AbWCVKVy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 05:21:54 -0500
Received: by nproxy.gmail.com with SMTP id c29so75702nfb
        for <git@vger.kernel.org>; Wed, 22 Mar 2006 02:21:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJAte/GOfwaEtM7tPtnO2v+c9aKl7IphyqAGYcSqGjjBZnNg6FnYGW9XhOqqyGa2vJNfUVPoO4qcMhVYKzTPnRxH19/ZHKOxBUg5gWghoHCNMHVyOOaaogQCb1kyty0NgImzK8Gsemj9kEwgvBTAdGw+I471WYr1X17OQbND/Yk=
Received: by 10.48.254.3 with SMTP id b3mr171875nfi;
        Wed, 22 Mar 2006 02:21:45 -0800 (PST)
Received: by 10.48.30.9 with HTTP; Wed, 22 Mar 2006 02:21:45 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17811>

On 3/22/06, Junio C Hamano <junkio@cox.net> wrote:
>
>    A new configuration option, 'core.warnambiguousrefs', can be
>    set to warn you if you use "frotz" to name a ref when you
>    have more than one "frotz" under $GIT_DIR/refs (e.g. you have
>    both branch "frotz" and tag "frotz", and/or you have
>    refs/remotes/frotz/HEAD).

Ah cool :) I had the problem recently.
Also, Would could I know all configuration option ?

--
Beber
#e.fr@freenode
