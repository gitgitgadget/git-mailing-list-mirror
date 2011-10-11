From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v3] Teach merge the '[-e|--edit]' option
Date: Tue, 11 Oct 2011 14:57:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1110111454490.8685@ds9.cixit.se>
References: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 15:58:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDcqN-00068a-8t
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 15:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab1JKN6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 09:58:01 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47346 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753391Ab1JKN6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 09:58:00 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p9BDvpBi010457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 15:57:52 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id p9BDvmIY010452;
	Tue, 11 Oct 2011 15:57:49 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 11 Oct 2011 15:57:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183295>

Jay Soffian:

> +--edit::
> +-e::
> ++
> +	Invoke editor before committing successful merge to further
> +	edit the default merge message.

I have a feature request, and that is to also add a configuration option to 
make this the default behaviour.

-- 
\\// Peter - http://www.softwolves.pp.se/
