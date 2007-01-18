From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 15:53:29 +0100
Message-ID: <81b0412b0701180653i7cc0c87md7a9c94a10fa3b24@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <45AF7FE8.5060003@op5.se>
	 <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
	 <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 15:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Ye1-0001iv-3t
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbXAROxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXAROxf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:53:35 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:60509 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXAROxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:53:34 -0500
Received: by an-out-0708.google.com with SMTP id b33so83073ana
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 06:53:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LLa6c5ruIJfFBWJobBopxJ6HHYM7hW+B2gUwcp/DMj4CLswFgUdYs+3k1dSsRtAMIucO9c7Ik8Zj6VRwaXL1RDSTeqLf2SsL65a/4PCTOnNPOrVT3ai4JJXYXs1ye+s01boJPzUp2qQqM0vQ44zuufRWTdC1hGu/FKghKltLHqs=
Received: by 10.78.193.19 with SMTP id q19mr946814huf.1169132009497;
        Thu, 18 Jan 2007 06:53:29 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 06:53:29 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37099>

On 1/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > BTW, Junio, how about making the _default_ settable at compile time?
> > It'd be reasonable to allow local installations choose to default to what
> > they find the most paranoid?
>
> Better control that with templates.
>

Do we have a template for config already? I thought they were only for hooks...
