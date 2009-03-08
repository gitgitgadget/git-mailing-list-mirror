From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 08 Mar 2009 06:26:08 -0700 (PDT)
Message-ID: <m363iki1ua.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 08 14:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgJ2b-0006Dk-AN
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 14:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbZCHN0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 09:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZCHN0N
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 09:26:13 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:48293 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZCHN0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 09:26:12 -0400
Received: by bwz26 with SMTP id 26so899761bwz.37
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=M4rbr+AEnIsj4WsQt8CLRf/fZ/+vOS2zzEFQF7gvlaw=;
        b=oAMfndCos5VRFTETj8OYAArrlDAdBAxVYpP8Zp2sNvrhHdJ2/USDZ5OV6UlJYpE9PS
         ZSgna9gJwduzxVLeNyNIlMmvNrvHBbp56UamFDhdBBRcx/8Sd1KFU16wQHMTLBn7YZJv
         weZVy7vKangMbrpheXA0rpse4DhXneQA1vDV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=nFWosFbM8rBeXnCiGWGyWIA0QhPe2G/63zgtsyLhTtSDlv2nrXGbctLBQe0xui3Op5
         V/xytDTYgcN9zD5Cuz9hFzvAJzGnbxqFJsSrXNb0/UHJrZ/yAabDrv0mbcG4IRpjYHfg
         s/kmPzaPSaWQefp+IaEESiRrrJfbJ3M+kV2ZM=
Received: by 10.103.178.17 with SMTP id f17mr2093301mup.45.1236518768556;
        Sun, 08 Mar 2009 06:26:08 -0700 (PDT)
Received: from localhost.localdomain (abvd146.neoplus.adsl.tpnet.pl [83.8.201.146])
        by mx.google.com with ESMTPS id 14sm1622355muo.50.2009.03.08.06.26.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Mar 2009 06:26:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n28DPNru003130;
	Sun, 8 Mar 2009 14:25:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n28DP1MT003125;
	Sun, 8 Mar 2009 14:25:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112620>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Known issues

> - The Logitec QuickCam software can cause spurious crashes. See "Why does 
>   make often crash creating a sh.exe.stackdump file when I try to compile 
>   my source code?" in the MinGW FAQs 
>   (http://www.mingw.org/MinGWiki/index.php/FAQ).

You meant issue described here?
  http://www.mingw.org/wiki/Environment_issues

-- 
Jakub Narebski
Poland
ShadeHawk on #git
