From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Typofixes outside documentation area
Date: Thu, 4 Feb 2010 10:33:22 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002041032110.31053@ds9.cixit.se>
References: <7v636dr2hy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 10:34:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncy6P-000274-4c
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 10:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0BDJda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 04:33:30 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:47046 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752146Ab0BDJd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 04:33:29 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o149XNFw003436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Feb 2010 10:33:23 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o149XM5R003433;
	Thu, 4 Feb 2010 10:33:23 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7v636dr2hy.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 04 Feb 2010 10:33:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138959>

Junio C Hamano:

> diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
> index 5782d80..3a5da4a 100755
> --- a/contrib/fast-import/import-directories.perl
> +++ b/contrib/fast-import/import-directories.perl
> @@ -344,7 +344,7 @@ sub parsekeyvaluepair
>
> Key and value strings may be enclosed in quotes, in which case
> whitespace inside the quotes is preserved. Additionally, an equal
> -sign may be included in the key by preceeding it with a backslash.
> +sign may be included in the key by preceding it with a backslash.
> For example:
>
>  "key1 "=value1

ACKed, obviously.

-- 
\\// Peter - http://www.softwolves.pp.se/
