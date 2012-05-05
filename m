From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Jonathan gives feedback --> flamewars inevitable?
Date: Sat, 5 May 2012 13:42:55 -0500
Message-ID: <20120505184255.GB18844@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
 <20120505155423.GA14684@burratino>
 <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
 <20120505164736.GC14684@burratino>
 <CAMP44s2NRMxuvQXk4RyqFYR=oQw_vrJhmbdwtXsrg=eHhGBS2w@mail.gmail.com>
 <20120505173327.GE14684@burratino>
 <CAMP44s1SLb6CXMKxRDFUbxkg56dU3=ObZPZh7XxQC3vovNnvdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 20:43:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQjwh-0006mE-4f
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 20:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab2EESnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 14:43:02 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33722 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab2EESnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 14:43:00 -0400
Received: by obbtb18 with SMTP id tb18so5774160obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y3pgtVzbjmXOllZOkLU4y4ITc4W6YKxgwuhy7XddJ+I=;
        b=ZM55/PVs7+TWa3KDf+nfJgLMt4rBvM48vMn4CcIYlU6SV4fAVF4He2gi6Jy7RswWAW
         GIOrem7lUhRDpsVc+/NstZ41GiXJHfpfObwjIwlLwAV1F+gB5uOfVx1gMW9pd2P3MaZs
         klThFQdYRMdH5KBlUiFmiMZ5DShH0rJ/A76lPnsy6NQHCJrr8WDLYaNk4ZU8j00qOBdG
         kh+2QqavCuXBvBihRKZvggvbZTxmnbVkObdCe1XQQUok9YC5Un/p2MGD9UKYD+23dN/0
         wfbfik3a5QNFZrvH2wjRfFez9BLMxgJi/zTXiQIZ9jyBKiWxmHA4vaiYs7xW+d4wM2Zd
         UeQg==
Received: by 10.50.187.137 with SMTP id fs9mr5438814igc.50.1336243380232;
        Sat, 05 May 2012 11:43:00 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm4932025igc.0.2012.05.05.11.42.59
        (version=SSLv3 cipher=OTHER);
        Sat, 05 May 2012 11:42:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1SLb6CXMKxRDFUbxkg56dU3=ObZPZh7XxQC3vovNnvdw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197134>

Felipe Contreras wrote:

> http://article.gmane.org/gmane.comp.version-control.git/195685
> http://article.gmane.org/gmane.comp.version-control.git/195689
> http://article.gmane.org/gmane.comp.version-control.git/195691
> http://article.gmane.org/gmane.comp.shells.bash.completion.devel/3877
>
> You could have skipped this

I'm also really confused about this.  Are you saying that trying
to figure out the bash-completion conventions was a waste of time?
It even resulted in a patch to bash-completion being applied that
improved consistency, which I thought was an attribute you valued.

Jonathan
