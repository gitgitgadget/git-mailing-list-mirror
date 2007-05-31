From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 31 May 2007 08:50:16 +0200
Message-ID: <81b0412b0705302350i3ebf48e8h24537c20a413e709@mail.gmail.com>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site>
	 <20070531002030.GA15714@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 31 08:50:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HteUe-0004x2-8V
	for gcvg-git@gmane.org; Thu, 31 May 2007 08:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbXEaGuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 02:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754330AbXEaGuU
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 02:50:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:29937 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbXEaGuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 02:50:18 -0400
Received: by wr-out-0506.google.com with SMTP id 76so62907wra
        for <git@vger.kernel.org>; Wed, 30 May 2007 23:50:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uj+HY2kerCjRpMPIvzhB6dGInfEyvaH1/QDAmkRdy+1hU+3AdDPvoyB1nLkj2f5lp2FI62YXEjJouzZAG4pOFar5mgCEqwH5OQAxnHy0KiwvlRUxeBhT5Mrb/70eKHu1FXVb2ka5NmX1up0aMph0S4C6ClzohMjmEejK/b0mQBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LNP4+MCHyGADmwmcu4X4qJgK+KXt0WZKCMD8lxDor2aUS4mQN00/qpJE7YT4ld33OMdbk6rlk/5t5QPpIJihuKePVmzbrrzIDIz2zFUfPEvwx+zsWjGj2PfRNRUCLjsGfd/AS5JV3WVRs4HntawJSgtNdrux0xKELFuTYk5sAJQ=
Received: by 10.78.188.10 with SMTP id l10mr191254huf.1180594216921;
        Wed, 30 May 2007 23:50:16 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 30 May 2007 23:50:16 -0700 (PDT)
In-Reply-To: <20070531002030.GA15714@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48803>

On 5/31/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 30 May 2007, Alex Riesen wrote:
> >
> > > git-version --features?
> >
> > Melikes.
>
> Good?
>

Was just a suggestion. Good.
