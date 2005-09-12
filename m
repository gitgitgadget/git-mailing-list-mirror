From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: Add "git grep" helper
Date: Mon, 12 Sep 2005 16:57:56 -0400
Message-ID: <118833cc0509121357698005fe@mail.gmail.com>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
Reply-To: mwelinder@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:00:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvNS-0003AZ-LM
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVILU6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVILU6H
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:58:07 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:16173 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932238AbVILU6G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 16:58:06 -0400
Received: by rproxy.gmail.com with SMTP id r35so378477rna
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 13:57:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cK1b/tZDy93wRqfyR/SoqzSNAsmVJuRa2bQxQUq3+zYy+MXILKHTcl+zMK5GbU3qjsXJUw4Xr1I1wAKOo1vjuiJa+V8vXt0Mjo9ETOEy2lUhhmBopyuEx9/kpKLzYfMO2CaqqVRLr+acsaN08/jh6MzilitI8wxD8JLnZLgPsoM=
Received: by 10.38.24.69 with SMTP id 69mr382568rnx;
        Mon, 12 Sep 2005 13:57:56 -0700 (PDT)
Received: by 10.38.76.38 with HTTP; Mon, 12 Sep 2005 13:57:56 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8427>

Cute, but what about grep flags like "-w", "-n", and "-c"?

M.
