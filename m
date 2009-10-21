From: Eugene Sajine <euguess@gmail.com>
Subject: Re: ident hash usage question
Date: Wed, 21 Oct 2009 19:32:26 -0400
Message-ID: <76c5b8580910211632s313ddc20ub66d9bcc647ac491@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
	 <81b0412b0910201343r4ff49f9fnbdd9260dcf682416@mail.gmail.com>
	 <76c5b8580910201519s29b939f3o3f6af8ca50340db1@mail.gmail.com>
	 <81b0412b0910202325i7a2f440bxcc9ce3ab9b684b2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 01:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0kfR-0005Ze-8J
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 01:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbZJUXcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 19:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbZJUXcX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 19:32:23 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49003 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZJUXcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 19:32:22 -0400
Received: by yxe17 with SMTP id 17so6529820yxe.33
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=FkQGbksCgxT95P3cubwwr0KER95Ri1OeWD8ruiYRxlc=;
        b=MjQHH/6xp5AM5c7wlKvIk6HyP9OFuGAUZbu3sPI8XBxcYVL4MZD+HQsilFjnPZB/hP
         8Pz2QllThj8JNIVdwRqa3Uui7p8vDdfAit8sHKi9OXlZVOu6SmeILTT8bI5bBibTlXXa
         b2An1W9ekW8+uHMwJtjV7cgZFp90ZYwODgJok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qGNo+sAAr0sc5UwKD5xTAnHVv7eh0ZoUKPz+4PVXYvZDN7o/jSyWAkdJRxWrfOx8V6
         8wSZOqcoWu4Q1oWOpxlgZJB3HPD5Sd92ALezFyOtgp+WIyTkIk2Apmm1j50DJum5akku
         loYoYKw9ncZptPicQ3kJnLse+RGiFW3xfneWs=
Received: by 10.90.215.9 with SMTP id n9mr3831964agg.98.1256167946816; Wed, 21 
	Oct 2009 16:32:26 -0700 (PDT)
In-Reply-To: <81b0412b0910202325i7a2f440bxcc9ce3ab9b684b2c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130986>

Many thanks to everybody for your time and comments!

I have plenty of info to think about now...;)

With best regards,
Eugene
