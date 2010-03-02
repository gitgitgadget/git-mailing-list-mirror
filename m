From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb multiple project roots documentation
Date: Tue, 2 Mar 2010 01:38:18 +0100
Message-ID: <201003020138.22657.jnareb@gmail.com>
References: <201003012318.29548.jnareb@gmail.com> <1267488297-10415-1-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Mar 02 01:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmG89-0003OJ-KH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 01:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab0CBAi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 19:38:27 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:46281 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab0CBAi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 19:38:27 -0500
Received: by fxm19 with SMTP id 19so1378337fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8WqFJQGqnGJAqftUINFx/vPrz22Rwa1p51tkxhfa4KY=;
        b=xH8Xg2fzaWXDfgQYhfk9tgBE2sOHFEqKlwuI11iiUvLlJxNg4P/UlpCWXtE5i2fCAz
         q7Z9rIWlk9uX1qNYceS8cZXClc+tCXA6C+n3Od3X57cPNxDqobT1xqux5LpN4jRBAlbq
         j+RJxM79aSgTJ7XIlOYXTR+6NTGPJOQwYSkiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CZsXCK9xE6csA4uQh0ud8GsgZ3PjZdg2VWPwatpzv9TYeeBKrd1nRSpdBzSex5tm9x
         1pF3bUCzBpRNYANzfbrsa0cTu+GvaTUcxVAIsW5Ma0K9qUj1PXmXqgzC0P95plOFiTAm
         yy3WgaUiDzScwtrr42xgX6G/SaaOAJL2tFBD8=
Received: by 10.223.62.83 with SMTP id w19mr1063904fah.22.1267490305410;
        Mon, 01 Mar 2010 16:38:25 -0800 (PST)
Received: from ?192.168.1.13? (abwj97.neoplus.adsl.tpnet.pl [83.8.233.97])
        by mx.google.com with ESMTPS id 14sm2551728fxm.9.2010.03.01.16.38.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 16:38:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1267488297-10415-1-git-send-email-sylvain@abstraction.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141371>

Sylvain Rabot wrote:

> This commit adds in the gitweb/README file a description of how to use gitweb
> with several project roots using apache virtualhost rewrite rules.
> 
> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>

For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
