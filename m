From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH v3 10/17] Move WebDAV HTTP push under remote-curl
Date: Wed, 28 Oct 2009 19:01:42 +0800
Message-ID: <be6fef0d0910280401u76033c32j5eb6823a67b204f9@mail.gmail.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
	 <1255577814-14745-11-git-send-email-spearce@spearce.org>
	 <20091019105921.d58c2728.rctay89@gmail.com>
	 <20091028010831.GP10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 12:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N36Hl-0001Nk-8G
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 12:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZJ1LBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 07:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZJ1LBi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 07:01:38 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:57553 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbZJ1LBi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 07:01:38 -0400
Received: by iwn10 with SMTP id 10so483359iwn.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=IpyjqfZT0rsonFn2Z2hOJ1oWuNPKy2c7PiSsYmW6b4U=;
        b=mmziHQcOipYQYG6AvwAuSfr1jhz8fK3OTir6G0sj3bjvF9/57sVkstoJvLBROkCcqq
         lFYkA85wsklItxv2a+9ncntfniBwcUYuV50bu4WTVCB4em2PAb2R+KFF2Nr2PO3qwOzp
         D5dVmwfQDSuG93X0qQB8ANIZIVvD/njCiXXHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aEE3CcsI1gEusvpQ2v6b1+ese4n3vg0N9u07+q654qYoGA1X1Wd3t1ELqRfg7Pzo7v
         Ux+mpfnJ98E9xG/Wi7IHwCF4N15UQw6sBxpoLAlPE3PDWLoVtPqXNSwcmnLzMVPpuN16
         f449XljC9jUVdEn+5OW5KujTpbF/U50krN9q0=
Received: by 10.231.122.208 with SMTP id m16mr6471643ibr.16.1256727702826; 
	Wed, 28 Oct 2009 04:01:42 -0700 (PDT)
In-Reply-To: <20091028010831.GP10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131445>

Hi,

On Wed, Oct 28, 2009 at 9:08 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Isn't the style I have here the standard way of adding a second
> paragraph to a list item?

sorry, I didn't catch the '+'-line style.

> I folded your patches into my series, thanks.

You're welcome.

-- 
Cheers,
Ray Chuan
