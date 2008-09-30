From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git/spearce.git (Sep 2008, #04; Mon, 22)
Date: Tue, 30 Sep 2008 13:00:52 +0200
Message-ID: <81b0412b0809300400i164525ealce8a3ff8dabf783@mail.gmail.com>
References: <20080929184709.GB21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 13:02:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkczV-0008Ha-W6
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYI3LAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYI3LAy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:00:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:54373 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYI3LAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:00:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so387336ywe.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yU4p0D67i/6NI8h/w5/SEaUx3qxrZwgx9dpD3R58D0Q=;
        b=aA5xWjup5+Q5s8x/FFbBqeqPScRkgs2pBFqgsHmxRihWq8k1+dto5KkkQ342kSp3SG
         foP6Gw4XMdynv56FYAvrlmmGmzB1kDKeD6vu6g/B/M7PD6qokgec5tixLi+M2VsSTftI
         kuI2dwMNIal/viiG/DxhbwfoyiwyJipS/k37Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CxpxOQ4dynQ/RzDCgzkbOZV63snKDeDntOqMyu7yJsngKrR/fDdTj24KNPdGea8bDS
         vxwcoz9FVoImsB5deRZEeHBqi9yghXKMArJJJXdlfsFjXf6hWlW9DolBiAZdt7R2wVZr
         gvCm1BJGH7UbBlYuXj3osVPgh1BhlQ+B8Jqio=
Received: by 10.100.154.19 with SMTP id b19mr5640079ane.98.1222772452399;
        Tue, 30 Sep 2008 04:00:52 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 30 Sep 2008 04:00:52 -0700 (PDT)
In-Reply-To: <20080929184709.GB21310@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97095>

2008/9/29 Shawn O. Pearce <spearce@spearce.org>:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.

Would you mind adding the remove_path factorization patches
in there somewhere?

http://marc.info/?l=git&m=122246984212129&w=4
http://marc.info/?l=git&m=122246997012269&w=4
