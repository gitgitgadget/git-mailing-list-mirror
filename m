From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git gui and gitk documentation
Date: Sat, 17 Oct 2009 21:45:32 +0530
Message-ID: <2e24e5b90910170915u9331898tbc87095a3f1b040b@mail.gmail.com>
References: <BLU149-W532BC93AF99F2B8D4C90F1E3C50@phx.gbl>
	 <4AD870CD.1040709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: chris miles <chrismileswales@hotmail.co.uk>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Oct 17 18:15:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzBwR-0005I2-4C
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 18:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbZJQQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 12:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbZJQQP3
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 12:15:29 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:41997 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbZJQQP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 12:15:28 -0400
Received: by iwn8 with SMTP id 8so1608295iwn.33
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=1Io4hOO4LinkNfcpQoGTxAgo+zE9GAjUSzt/K/JqwwQ=;
        b=sRlW/FmfeqvD3KIcAKOZ1JEgiqPWZ4rP+nVCt2+xa6Wvoq09X3//YMXiWVH93O6c6n
         KufHPXFO8V7gJdKV6u9iJoj290TQRCRvPdt0QidUZrTtropqyx+xhoJSh+VSn1WJL0W7
         evByZ6ZHWOhOV848JwBqiL0WHtbahPkplHSp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=infp2VG/S231s1LJwkfDSKXgjRZlN+DR5VOq1m2Nl5EiWFrpchoMJ513KIjQqpeMLS
         aJsgo3BxGiCwllCjEtjPC0qGWK+W8lJH8RfidaFu/BeH0qwpH6CU14ONDBG+V4YGnYq+
         63SqR29gblFAGgSbJ8aQrQQja9FjYSYk6m9Ro=
Received: by 10.231.61.195 with SMTP id u3mr2795322ibh.12.1255796132476; Sat, 
	17 Oct 2009 09:15:32 -0700 (PDT)
In-Reply-To: <4AD870CD.1040709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130562>

On Fri, Oct 16, 2009 at 6:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> chris miles venit, vidit, dixit 15.10.2009 22:51:

>> I'm looking for documentation on gitk and the gui that is distributed with git.

> How about
>
> man gitk
> man git-gui

Here's my attempt to document the GUI parts of gitk (the command line options
you can get from 'man gitk' suggested above).  I haven't maintained it or
updated it in a while but what there is should still be correct.  It may even
be useful :-)

http://sitaramc.github.com/1-basic-usage/gitk.html
