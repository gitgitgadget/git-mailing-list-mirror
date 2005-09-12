From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Mon, 12 Sep 2005 21:34:30 +1200
Message-ID: <46a038f905091202343306846@mail.gmail.com>
References: <46a038f905091101529e045af@mail.gmail.com>
	 <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
	 <46a038f905091200245f6330d9@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 11:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEkhy-0003gC-KY
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 11:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVILJeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 05:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVILJeg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 05:34:36 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:55003 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbVILJef convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 05:34:35 -0400
Received: by rproxy.gmail.com with SMTP id i8so324741rne
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 02:34:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sxJzwrNkDSEqpFIiwtmmdZmFUpE9UzQQb3fhgrtIdNjjxj7/onqhTu5zh8sOh+NvZWMbUVXx9ZLc4XDjYb2PS0a+8l6UQcgM0bHsqFi+UKkKKYu8b6+jggnaSrfWe3IByAG8qQbmMbPJytjggMTohXZFulm9TBYaHkGVebX5a90=
Received: by 10.38.181.5 with SMTP id d5mr270837rnf;
        Mon, 12 Sep 2005 02:34:30 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Mon, 12 Sep 2005 02:34:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <46a038f905091200245f6330d9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8374>

> Hmmm - git-format-patch is now broken. 

Strike that. PEBCAK: my branch entry was pointing to the wrong place. Sorry. 



martin
