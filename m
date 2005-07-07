From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Prevent t6000 series from dropping useless sed.script in t/
Date: Fri, 8 Jul 2005 08:40:33 +1000
Message-ID: <2cfc4032050707154014f30774@mail.gmail.com>
References: <7vd5pusbox.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:41:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqf3q-0008Ed-1f
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVGGWlD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVGGWk6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:40:58 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:31181 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262316AbVGGWkh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 18:40:37 -0400
Received: by rproxy.gmail.com with SMTP id c51so256163rne
        for <git@vger.kernel.org>; Thu, 07 Jul 2005 15:40:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tmxj7LW0YwPNnUr3rDUYQBrZBEUDku3c/+5FhjCKQT1C/Lhhh13O0/wUkrbpzrKyPz86zdRlPTfSIZDexTR+SJ4vl5rWM3mgY8w9WnByACYl29LD8H1k4hHUoLnbFEQxkq/IzKBaoQVYhgXSg+5A1NhAajCqT+dX6mPOXMg09jY=
Received: by 10.39.3.1 with SMTP id f1mr1211127rni;
        Thu, 07 Jul 2005 15:40:33 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 7 Jul 2005 15:40:33 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5pusbox.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ack - sorry I didn't notice that side effect.

jon.
