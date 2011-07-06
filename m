From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Front GIT with an ssh or http service
Date: Wed, 06 Jul 2011 06:59:41 -0700 (PDT)
Message-ID: <m3wrfv4ijc.fsf@localhost.localdomain>
References: <1309348950907-6528631.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene <eugene@oggtrading.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 15:59:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeSdr-0006s3-Aa
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 15:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab1GFN7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 09:59:45 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:62889 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab1GFN7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 09:59:44 -0400
Received: by fxd18 with SMTP id 18so111521fxd.11
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:user-agent:mime-version:content-type;
        bh=VcbBQ/yKQilAwSdYBhGTiztw4Ex9HtNAm1mKtAUcp38=;
        b=u8DvnhbMILe3r1eFSTEnEHh7UrG/FvDZbbDPPkFv6zuj1Wm3gpYfjjTEmqhAY4IEuX
         FzbxSNloTGTmYlsa/tL7zNixiN0dDArjDyXtBigHoQyfQtPjHKVb0tC0HP1ffQ6D3sGz
         Zvm2Ep+90kNFHFoTMYkKUDl2nE/RhMUjV7l1E=
Received: by 10.223.97.131 with SMTP id l3mr13191531fan.43.1309960783490;
        Wed, 06 Jul 2011 06:59:43 -0700 (PDT)
Received: from localhost.localdomain (abvw74.neoplus.adsl.tpnet.pl [83.8.220.74])
        by mx.google.com with ESMTPS id o27sm2071210fag.2.2011.07.06.06.59.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 06:59:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p66DxEMu011604;
	Wed, 6 Jul 2011 15:59:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p66Dx4Fb011599;
	Wed, 6 Jul 2011 15:59:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176702>

Eugene <eugene@oggtrading.com> writes:

> Good morning,
>
>   I have a local Git for windows. I want to put an ssh or web service in
> front so somebody else can use me and also set up automatic builds (via
> cruisecontrol) out of my local git.

Could you explain more clearly what you want to do?

Do you want for other people to be able to fetch from your repository?
To push to your repository?  To configure automatic build on push?  To
set up web interface so other people can browser your repositories
using web browser?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
