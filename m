From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward incompatible
Date: Sun, 15 Feb 2009 14:56:12 -0800 (PST)
Message-ID: <m3k57rtilx.fsf@localhost.localdomain>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<7vfxifid6r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 23:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpvl-0005Ej-VV
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbZBOW4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbZBOW4P
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:56:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:36113 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbZBOW4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:56:14 -0500
Received: by fg-out-1718.google.com with SMTP id 16so161162fgg.17
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=6pTdmA9U80oaRDAz2Fl+MpeQLF9UGKNZglaNF0giPo0=;
        b=aMNQ/LvlULXVike0ZcmLxSo8DYIt0HG9s0dilA0aIFHk4U+S9e2FxrjM63M74wlSsd
         ntA4VWWr+LGryMj6nXlRSXjlgtOtlLedRgcjFsC5Ww/rUVlUL96+Q6J1448S5kEpPRYd
         V1DOJ/HDAtx1N6w9Cr86zMoJtsJNIH1SmxfDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Dd3MDMz6x+dn7Eb7JC7H4VMr8mWRv6iirTgCvSkkx594Zu1FmizJcQ+EjOzz7mXqGq
         oigpKVzX94uOphT2S65RNOLJHc8XnzMhIkCOWg/Si8Lmwpjje53tsl69K18yPiHe41vP
         sQl8vVlLPpprNiPsedekEfULU7yZqoxK76LVk=
Received: by 10.86.100.19 with SMTP id x19mr1053812fgb.29.1234738572789;
        Sun, 15 Feb 2009 14:56:12 -0800 (PST)
Received: from localhost.localdomain (abwt47.neoplus.adsl.tpnet.pl [83.8.243.47])
        by mx.google.com with ESMTPS id d6sm7279358fga.59.2009.02.15.14.56.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 14:56:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1FMuCRq030306;
	Sun, 15 Feb 2009 23:56:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1FMuAbB030303;
	Sun, 15 Feb 2009 23:56:10 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfxifid6r.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110078>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Somebody, please volunteer to keep a list of <project name, volunteering
> > forwarder> tuples.  It might be a good idea to create a new page that is
> > linked from http://git.or.cz/gitwiki/GitProjects for that purpose.
> 
> Please use http://git.or.cz/gitwiki/ProjectContacts for this.

By the way, you could blog it^W^W write about it on your blog.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
