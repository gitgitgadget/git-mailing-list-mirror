From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 2/2] add variable name to `git_config_*()` error message
Date: Thu, 31 Jul 2014 20:53:35 +0530
Message-ID: <53DA5F77.8020106@gmail.com>
References: <1406814126-10457-1-git-send-email-tanayabh@gmail.com> <1406814126-10457-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:23:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsCo-0000pl-5i
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbaGaPXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:23:41 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44256 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaGaPXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:23:40 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3672809pdj.12
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Bh8Ozjx1qWLuE6tShlrHWnGN5TWVG/TaFUs99BE+DIk=;
        b=ZoFu+LGfi5NEH00bWgFEg2ypf2xsf7TZ7Cy4YaEvQ2xKKLYaF0PGgZUzGBSMfxXuKf
         saPNoNJPwsVmK0n8wN353GdUotTrmjURqIBLaV00zhTTlNx6lFk/lHUGo+f2AatUf8jp
         vnE6x3BRzUh5pFkzLrns668chEZGch7SKOvtbuIResYRmbleFy5Sb7ClY4tFR5oT77bB
         cr6vqNvybRKbtmmVb4a1aq7ySZFSiMuC+kdVskptCo7rCxY9WPS9X4RUYVIGk8YKgJen
         azNQlY2GzVudopeLfDmEj38UZdf8ndGdGFHels+ua3ZkUdUsrWlbkfAZLhBsT2GGXsQD
         E8aQ==
X-Received: by 10.66.66.101 with SMTP id e5mr5306302pat.100.1406820219880;
        Thu, 31 Jul 2014 08:23:39 -0700 (PDT)
Received: from [127.0.0.1] ([223.229.21.143])
        by mx.google.com with ESMTPSA id x1sm8730300pdn.91.2014.07.31.08.23.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:23:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1406814126-10457-2-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254578>

Junio, drop (2/2) of this series, it has conflicts with ta/config-set in pu.
This patch can easily come later. Sorry for the inconvenience.

Patch 1/2 is OK.

Thanks.
