From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: 7fb9de4a830dd8969bc17a219c509a76dd3c9aad [ or: the --merge-order patch ]
Date: Tue, 7 Jun 2005 01:44:41 +1000
Message-ID: <2cfc4032050606084460ff5ce2@mail.gmail.com>
References: <20050606153940.20039.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:43:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfJit-00035I-04
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 17:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVFFPop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 11:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFFPop
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 11:44:45 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:29979 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261500AbVFFPoo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 11:44:44 -0400
Received: by rproxy.gmail.com with SMTP id i8so1991728rne
        for <git@vger.kernel.org>; Mon, 06 Jun 2005 08:44:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y+HFQNfgyjNWoKfyIi5/gG20yAipT/H70E5mcwEzgjxRCg08lGJj/CpKQMMB3GbewtFe6wCSf7oEiXp9c0BMx0rDusO67d1SglOJuVgzD91JGJfJALdVCAZRHir/WrKOwKehexrXRtMQQCHy6xztBxjZPVRgIfZ8jlVEjMG1Zag=
Received: by 10.38.97.66 with SMTP id u66mr2463614rnb;
        Mon, 06 Jun 2005 08:44:41 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Mon, 6 Jun 2005 08:44:41 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050606153940.20039.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sorry about the Subject: - my patch submission script is obviously a
little buggy.

Anyway, the referenced e-mail contains the latest --merge-order patch
which is synced with Linus' head and incorporates my earlier
rev-list.c patch.

jon.
