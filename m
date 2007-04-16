From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 14:56:07 +0200
Message-ID: <81b0412b0704160556j6596ab03v2405eadcefe34bd8@mail.gmail.com>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
	 <20070416055111.GC23255@mellanox.co.il>
	 <7vodlox3fx.fsf@assigned-by-dhcp.cox.net>
	 <20070416061813.GD23255@mellanox.co.il>
	 <20070416065119.GF23255@mellanox.co.il>
	 <7v647wx0q3.fsf@assigned-by-dhcp.cox.net>
	 <20070416071127.GM2229@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 14:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdQl6-0002tZ-Rr
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 14:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbXDPM4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 08:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbXDPM4J
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 08:56:09 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:24965 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030573AbXDPM4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 08:56:08 -0400
Received: by an-out-0708.google.com with SMTP id b33so1723016ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 05:56:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=odwZl8Lhly0KR+yrU+sV8k2XEScBu92mA0NuE2dfxneoMI7DYhpeexTod3VaGwZw5yQWWZve5yeiGAZP8Is+p3v+19NOObLI1NNskH0eI1lMmZpN9aMiKb18Ssu+lOvWoEdEqRMG4beC4CUyQJvo/75st3IHvdD7tP7dap5QEkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hx2mXVxT6Jx6jDAIeXVnvj6qAo/wLBREuQ7fzg8zV8cemO1n55e5TSBNymotzlsj3H300RSVbT9S7yNicfvf2uVNTg6vxIIFkNBkW9QoXLSlwNSZirdajNQ3ku4VHlDOSPuQRBccfNZhtLrbwU8Abp2pKqCHFzOb4u88JzPqV0A=
Received: by 10.100.9.19 with SMTP id 19mr4439590ani.1176728167310;
        Mon, 16 Apr 2007 05:56:07 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Mon, 16 Apr 2007 05:56:07 -0700 (PDT)
In-Reply-To: <20070416071127.GM2229@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44644>

On 4/16/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > I am not quite convinced that giving a short summary is
> > necessary yet, probably for the same reason you questioned why
> > we do --shortstat.
>
> Of course I'm one of those "gah, I got more shells than I know what
> I'm doing with!" people.  ;-)
>

Me too. Please, can we have it? :)
