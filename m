From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: reducing line crossings in gitk
Date: Wed, 15 Jun 2005 22:34:34 +1000
Message-ID: <2cfc40320506150534380bb5f8@mail.gmail.com>
References: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
	 <7v8y1gvjfz.fsf@assigned-by-dhcp.cox.net>
	 <17072.3723.242985.824999@cargo.ozlabs.ibm.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 14:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiX1S-0001OP-8w
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 14:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFOMeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 08:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVFOMeh
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 08:34:37 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:63670 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261433AbVFOMee convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 08:34:34 -0400
Received: by rproxy.gmail.com with SMTP id i8so1965297rne
        for <git@vger.kernel.org>; Wed, 15 Jun 2005 05:34:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tpFSLe6pLGU5RaeAP9QwEHFs5234m6Kj1/Mdlv3QYP7nh44qqmrD8hLjG4usdZGgzxj8Ce9tzhuvH8aXqCro11PUcUSPPmGuG1F57lDgMg/OOWLGOEtPC/ZUbt2zkuF/8m9Siil7Md8h5d1JdXChxdsJpGwAiERrjoQHvXdZuZU=
Received: by 10.38.101.26 with SMTP id y26mr1733276rnb;
        Wed, 15 Jun 2005 05:34:34 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 15 Jun 2005 05:34:34 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17072.3723.242985.824999@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul,

Another feature that would be handy is the ability to be able to
create tags by pointing to an item and selecting a "create-tag"
action. The effect would be to write the SHA1 id into
GIT_DIR/refs/tags in the expected way.

Regards, 

jon.
