From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [RFC PATCH] git-p4: introduce asciidoc documentation
Date: Sun, 04 Dec 2011 22:33:56 +0100
Message-ID: <op.v5zh6udk0aolir@keputer>
References: <20111203235328.GA3866@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Pete Wyckoff" <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Dec 04 22:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXJhO-0002QB-Eb
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 22:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab1LDVeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 16:34:08 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53348 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1LDVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 16:34:06 -0500
Received: by eaak14 with SMTP id k14so3704466eaa.19
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=EHSnopg7XRjj0Yt1kZ4N2t/docBA5j0skXnpWYvqQ2Q=;
        b=GgIuRkoWTCb1kd0bHyopPCyAEZ03HEXwCYt5FIRhhb9bgCgYJXHDZw17jZY4BdAlo1
         xyHG4h8BFyqynqBavwu+u6jtljwDpmOCj+vwKFGbkqvcXB8db8Dswt6ZZE9wTzvZhcde
         x66mnAGu7/J2fGr78l9CS5s/Zqdb1p/WzUJV0=
Received: by 10.213.32.197 with SMTP id e5mr461128ebd.142.1323034445142;
        Sun, 04 Dec 2011 13:34:05 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id d6sm51669271eec.10.2011.12.04.13.34.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 13:34:04 -0800 (PST)
In-Reply-To: <20111203235328.GA3866@arf.padd.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186272>

> +Clone options
> +~~~~~~~~~~~~~
> +These options can used in an initial 'clone', along with the 'sync

s/can used/can be used/

Cheers,
Frans
