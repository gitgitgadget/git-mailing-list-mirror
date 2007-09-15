From: "Nikodemus Siivola" <nikodemus@random-state.net>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 20:14:51 +0300
Message-ID: <6bcc356f0709151014j9606a3ape6b62770304560ba@mail.gmail.com>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	 <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	 <7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	 <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	 <20070915025129.GY3099@spearce.org>
	 <20070915073845.GB3782@efreet.light.src>
	 <20070915075144.GB3099@spearce.org>
	 <6bcc356f0709150611i97d31f0yb91016e53c4f5e9f@mail.gmail.com>
	 <85myvoav1g.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, "Jan Hudec" <bulb@ucw.cz>,
	"Brian Scott Dobrovodsky" <brian@pontech.com>, git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWbEQ-0001gZ-1p
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbXIOROy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbXIOROx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:14:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:35701 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbXIOROx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 13:14:53 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1066193fkz
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Nli6sM5Aj3jSEls/hCRljioRe/E8jcb9gztsJ2l6uz4=;
        b=aIfF3hbFp3VjPKsRg8HUGeKSfpvoQVDHHuE7pWdXXUMSekH2I40XdlI6lPpJxYwr01HkAIj/XKYOlCUpPT7NyrjaLZhlPJ3rTuYaIBwWnrgOiBeUsbMe7z2qnql1/VVF07PtH8U+N72RUTRDMmt6hbGXFUvjarANB3FLObki454=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fTvVsVbrP17Tzw0lfKE/umZ6TzRwKQeywZzpf4o1LPvBwYST4y+W4ehlh5h4Xi8TsTccXBd6QSyfiU6J5/y8KRU14p46hUuzt0r3NbcCVPcuaryibuqkHdXFOYlEVoKmUzFXrOSBLqOtWmVCGQmKWhQFnx2PuKTz1/0iwn3Dfwo=
Received: by 10.86.70.8 with SMTP id s8mr2242146fga.1189876491426;
        Sat, 15 Sep 2007 10:14:51 -0700 (PDT)
Received: by 10.86.4.5 with HTTP; Sat, 15 Sep 2007 10:14:51 -0700 (PDT)
In-Reply-To: <85myvoav1g.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Google-Sender-Auth: 955f2c6f3f5ec6ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58264>

On 9/15/07, David Kastrup <dak@gnu.org> wrote:

> "Take a while"?  What's wrong with git-reflog?

Not needing it as a part of my regular workflow, and therefore
not thinking about it. *blush*

Cheers,

 -- Nikodemus
