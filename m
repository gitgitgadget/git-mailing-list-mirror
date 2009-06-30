From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 5/7] gitweb: gravatar url cache
Date: Tue, 30 Jun 2009 22:18:10 +0200
Message-ID: <200906302218.10624.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjy1-000791-D0
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbZF3UaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbZF3UaE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:30:04 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:59511 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbZF3UaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:30:01 -0400
Received: by bwz25 with SMTP id 25so119602bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RvIPqWAA1AwollXjYMcCSTZY0ZQo02atFHuRWWI5dzY=;
        b=OibD2qe7t3ODh2QimCBwyyP3Qs0MAVfvv72Z/wtppt/IRmNo1QUBrBdok2Kyu0GdxW
         L+rYbKdRdNKz1QghU5AacJ1JgHrlboRKUQB3VjYAdk88MVbWK1A06XIKwZWeHyZIKdCe
         TdHSVNwDacMXZvhgkSg/ujK7SvpG5lrMuEpYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rkwnFLdJYRf1C/gWWfhhwFePgqecTBlHhuqTVJlhtJZ8nDm01xg5eZxPak1gdvcL3O
         k3E9gvZ+YinPkQiDk39HMPJ0Xr4aJwwxKGZs5ZobmZZRGgqdfXjBmzKGZs5BxKruvmq6
         voFhyoG593VdUibLQwZf0301Jtt2PEnIMb1Z0=
Received: by 10.103.131.13 with SMTP id i13mr5061392mun.64.1246393802707;
        Tue, 30 Jun 2009 13:30:02 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id t10sm2191632muh.0.2009.06.30.13.30.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:30:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122535>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

> Views which contain many occurrences of the same email address (e.g.
> shortlog view) benefit from not having to recalculate the MD5 of the
> email address every time.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Very nice, very well written.

Acked-by: Jakub Narebski <jnarebWgmail.com>

-- 
Jakub Narebski
Poland
