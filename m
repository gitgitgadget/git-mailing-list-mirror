From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 GSoC] gitweb: Move static files into seperate  subdirectory
Date: Fri, 14 May 2010 23:25:03 +0200
Message-ID: <201005142325.04747.jnareb@gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <4BEBC001.10803@gmail.com> <AANLkTimlfiIulCUGf9WHMU2f4wlR3in83VR9UkP0-vi6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:25:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2Nm-0001Nz-0p
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab0ENVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:25:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52607 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab0ENVZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 17:25:12 -0400
Received: by fxm6 with SMTP id 6so1957268fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xMkB1E310eMVppYxZFqFjsf6WI8NNwMn3R97toWkWlE=;
        b=D+dpi7cOw2D6m6YbQACzmYtG+MreH41EWvGkyn07bBlsj1/uxMKWNlXobWenMWd+JQ
         rnGAXCASr+cdj9DHfXo0j5RASP6mafirFoq0x4HqQZmwrkXt3ILT9dyAPhJmrFvdcHLO
         q7ZLOTQ8IPWlFZfG8fdXkrm6NolVrX89ciVZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xDXWPFSIWqTB9Y92Nbzv/tugBQbe0QDBf85sypaNuExfqMzfQFlV8EJHpVWWEWS4uO
         fpfOgXDenDvjhStKVWV8KafZlT2d+Z7w7YRE0CZ6rCtRKCXXlNFAq0YX4XSwyWKRMIBA
         wxh+ChkyvxtTezTQoq3IOvhwNDQQBCwVrEeN0=
Received: by 10.103.67.38 with SMTP id u38mr1255346muk.107.1273872311293;
        Fri, 14 May 2010 14:25:11 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id e10sm12049065muf.8.2010.05.14.14.25.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 14:25:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimlfiIulCUGf9WHMU2f4wlR3in83VR9UkP0-vi6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147119>

On Fri, 14 May 2010, Pavan Kumar Sunkara wrote:

> Jakub, I would like to know the status of this patch.

I like it, and I think all issues (especially with regard to git-instaweb)
got addressed, but the patch itself is heavily whitespace damaged.  Could
you please then resend it as attachement (of *.txt file to have text/plain),
if you are not able to send it inline without whitespace munging?  Thanks
in advance.

-- 
Jakub Narebski
Poland
