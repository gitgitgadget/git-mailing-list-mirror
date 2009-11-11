From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: gitk : french translation
Date: Wed, 11 Nov 2009 17:59:23 +0100
Message-ID: <20091111165923.GE27518@vidovic>
References: <20091111001050.GC27518@vidovic> <g1w6apsyubgonjhsvjUYAxe124vaj_firegpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Emmanuel Trillaud <etrillaud@gmail.com>,
	Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>, Guy Brand <gb@unistra.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Moulard <thomas.moulard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 17:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8GXg-0005GI-Dm
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 17:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbZKKQ7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 11:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757839AbZKKQ7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 11:59:24 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:60120 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838AbZKKQ7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 11:59:23 -0500
Received: by qw-out-2122.google.com with SMTP id 3so248278qwe.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=MOmszqNlODwgyQTxSJndsMFhD+rRoHhHvUOYCuZJJ2E=;
        b=HXBcQsuRFK/ZtHHEs++CtnbGU1niPa/2DJOAzYyeb2X2VfkXrsg0nZ6QURWR8nPVsM
         OESaZegiVy6tWIEcar06MCgQ7rGwI5USUzdJx7p8zToA1ph2WW8GYNOWhZzd4BT0zaMZ
         Xc+nxu1LB4FYvxF46CIoexeWYY02NYGfoQBk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nUTxHeT7VXUmHPI2YSxrmuVy63Y582eRwyeaEHF8H14mjHuCvVQpszJkxvg630chKQ
         c8Tugx0eaIcRnDaJREWjGBlwhKqolqulNlC8jlZmm4+7ziiR3EI6byCNu1xU6r45a3zg
         XlSxsSbcXuIDTLdzxfsCnmcp9jK50HmEQ+nPM=
Received: by 10.213.96.202 with SMTP id i10mr6624716ebn.99.1257958768441;
        Wed, 11 Nov 2009 08:59:28 -0800 (PST)
Received: from @ (91-164-133-202.rev.libertysurf.net [91.164.133.202])
        by mx.google.com with ESMTPS id 10sm655285eyd.23.2009.11.11.08.59.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 08:59:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <g1w6apsyubgonjhsvjUYAxe124vaj_firegpg@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132674>

The 11/11/09, Thomas Moulard wrote:
> 2009/11/11 Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:
> > The 10/11/09, Emmanuel Trillaud wrote:
> >
> >> +#: gitk:1793 gitk:1817 gitk:3916 gitk:8786 gitk:10322 gitk:10498
> >> +msgid "OK"
> >> +msgstr "OK"
> >
> > This one should not be required.
>
> In that case, how do you differentiate untranslated sentences from
> translated sentences which have identical translations?

I don't try because I don't need to. If a sentence is not translated,
translators understand it doesn't need a translation if the translation
is identical.

-- 
Nicolas Sebrecht
