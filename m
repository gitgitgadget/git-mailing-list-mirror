From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Getting started with git
Date: Mon, 21 Mar 2011 08:59:31 -0500
Message-ID: <20110321135931.GA3367@elie>
References: <AANLkTinkuSJBvftDCh8++UyV5Wc=sMRr1+vc8WbeFYMs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kalle Launiala <kalle.launiala@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 14:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1fe4-0007Aq-AC
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 14:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924Ab1CUN7j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 09:59:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34859 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab1CUN7i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 09:59:38 -0400
Received: by mail-iy0-f174.google.com with SMTP id 26so6403220iyb.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=toTmHrbLnmIoSnfkmRxuKVOFsREawgCGwJMuuQpkq8c=;
        b=xGu+8g2ydWFqwxR/vs4WYJrpSav8K3C9SkaeR4OIJm/gGed6EJz9p4fz6Zknff7lKT
         fGThZhcUgukg3EFTDLNdCOPDldMfUFi5fya1wqUWiRLlPql6I3ZhQK6WcvF+vFW4bzki
         ps3UhuhNBp70iIAvDhua94w0LpwZiMrTzfZ0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Iq0QKQjzlU1A0qGwsKIrcBJzWrV+jsJrZNydxGATh6Ynfun/AnyBSD/rykyhQb7KuC
         88v/xWGBWeGVsICft+Op/c7GCjoT0dVynLBbqF7YlkjUacdcJIoOMAicweluEJFk8KGp
         cb24K5EfBsq6fQELZYU62TSNKO2PmbY45K2T8=
Received: by 10.42.221.196 with SMTP id id4mr6897873icb.141.1300715977128;
        Mon, 21 Mar 2011 06:59:37 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id wf3sm3993539icb.21.2011.03.21.06.59.35
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 06:59:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinkuSJBvftDCh8++UyV5Wc=sMRr1+vc8WbeFYMs@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169594>

Hi!

Kalle Launiala wrote:

> [Subject: Industrywide breakthrough innovation - Git as a key role of=
 distribution]
[30 lines of filler]
> =3D=3D=C2=A0End of Disclaimer.

Please don't do that.  Most of your audience isn't going to get
past that.

> However in this post I am simply asking help to understand Git
> properly

Are you a programmer?  I'd recommend starting with

 http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html

and moving on to

 http://www.kernel.org/pub/software/scm/git/docs/gittutorial-2.html

and

 http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#hacki=
ng-git

Hope that helps,
Jonathan
