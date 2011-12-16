From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git 1.7.7.5
Date: Fri, 16 Dec 2011 04:57:58 -0600
Message-ID: <20111216105757.GA11174@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 11:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbVUV-0006RP-CK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 11:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab1LPK6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 05:58:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43427 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1LPK6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 05:58:07 -0500
Received: by ghbz12 with SMTP id z12so2202401ghb.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=/Byr/AY1fBtHiGjcjqk20j9e1684+vxoQp405V9VhYg=;
        b=Z5/LY6IcVExg1RUy87J0Nhdf0vf04zttDy7Ex8u1WTLBt15t8NuUEpbt1LzQizr7Y7
         xi004UzWB4bfwa4078MPNWPcXyG9GWr8QI+ehiEndM78ObqMQSAFdf4AbXxHJ1tyObPu
         3ye7e9KUsL9RMJGaLuwdF07NI4T/RWpif+M7A=
Received: by 10.236.201.196 with SMTP id b44mr11451954yho.48.1324033086539;
        Fri, 16 Dec 2011 02:58:06 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j25sm13757808yhm.12.2011.12.16.02.58.04
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 02:58:06 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187268>

Hi Junio,

I noticed that v1.7.7.5 was tagged a few days ago (b36dcd72), but
there is no corresponding tarball at

 http://code.google.com/p/git-core/downloads/list

Will there be an official tarball?

I don't mind either way, but it would be useful to know whether
distributors should make their own or just wait.

Thanks,
Jonathan
