From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Addresses with full names in patch emails
Date: Tue, 24 Feb 2009 16:58:51 +0100
Message-ID: <200902241658.52498.jnareb@gmail.com>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org> <200902182255.13983.jnareb@gmail.com> <49A41484.1010501@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, fg@one2team.net, giuseppe.bilotta@gmail.com,
	pasky@suse.cz
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:01:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbziG-0005DU-M1
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789AbZBXP7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757165AbZBXP7E
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:59:04 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:65215 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbZBXP7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:59:02 -0500
Received: by fxm11 with SMTP id 11so2897606fxm.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HX8BDDBzOKRYYjwYQy3NmO45QJgOdnr/DmK7iO60FwE=;
        b=ht4gMIYWtmqyv+9JqlCwOtyzd8W9PM1+7llcPZJrpVbHX4gfp0NLvtgQD2ITsDGfK3
         Mz4RAkZIrKptsE+z6xS0wGtD2TuMgdo/rtsyqu23hHu5iWSfdusZk8XoNk3GO96niIem
         uraOM0b+CnvDCbEsn/e/JLFcCmusqGcJV/iUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OtzCqbDC/7m5YYUlh0dtTPya0TlhjCSZGosV7Z6eXTPzSOac/Cc9ocoqILXQZzL4JQ
         oro9AsQVeRwhcpXsHbJtP85e7EgipZC/QFm37k2WYKqeBXGXRre/7Yj8fSut5WpKJrQk
         cEWeqO4GJiSpGaJDK0trvdvM/Wk3DPQUDGIuQ=
Received: by 10.103.192.2 with SMTP id u2mr4554554mup.95.1235491139411;
        Tue, 24 Feb 2009 07:58:59 -0800 (PST)
Received: from ?192.168.1.15? (abvk114.neoplus.adsl.tpnet.pl [83.8.208.114])
        by mx.google.com with ESMTPS id e8sm2139011muf.59.2009.02.24.07.58.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 07:58:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <49A41484.1010501@oak.homeunix.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111307>

On Tue, 24 Feb 2009, Marcel M. Cary wrote:
> Thanks for the two patch tweaks.
> 
> Jakub Narebski wrote:
> > P.S. Why bare emails (without user names), e.g. "pasky@suse.cz"
> > and not "Petr Baudis <pasky@suse.cz>"? Just curious...
> 
> I've been using "git send-email" for patches, and have Thunderbird as my
> MUA otherwise.  (I'd use (al)pine if I could make it work with
> Exchange/NTLM at work, but that's another story...)  I've been
> transfering recipients (--to and --cc) from Thunderbird to the
> commandline with copy/paste.
[...]

Well, 'technical reasons with copy'n'paste' would be enough for me.

P.S. But '"pasky@suse.cz" <pasky@suse.cz>' looks very silly...
-- 
Jakub Narebski
Poland
