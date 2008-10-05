From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] teamGit v0.0.3
Date: Sun, 05 Oct 2008 03:14:01 -0700 (PDT)
Message-ID: <m38wt3qrij.fsf@localhost.localdomain>
References: <8ce0dfd6-2bd7-4e94-901f-b7c9bbd114aa@w39g2000prb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bain <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 12:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmQdz-0007Yp-8X
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 12:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYJEKOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 06:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbYJEKOG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 06:14:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60428 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbYJEKOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 06:14:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so866777nfc.21
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=oydEBa3M5eX4tPsVwFeaNsX+Mz4Tg/Y1xY3vB9+p2Ic=;
        b=W9OPE1/J96wZj0057b5iIvz5h0jcopvD930gZLM9vJ0KkEhyQow6vNHEdd/o0EWPX/
         b3Le9sgeja4Q7xaSzgqohKrvmz170+/mJ07JtsPSg0P3KD5LR0IxjmrA2zq+AGFAKYWN
         +l6t3+t3PSPCghwClBVCsQRRVrnml+ZIw4p+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qEHAVPWO0qLWJZ3WQjsApYZWk1c6KQOxr8y439DrA79BxuTOMivkjrN9oHC9L63YCP
         PRGH4vHd8CgQONA4F+QrEfDSDXo3fxf2DZgma8VyWFgBKOQqCdacAS1h4FRYsCHSzIH4
         l9QvDO9u7k5fafhBziqo/ZO6Ge9iq3GKS2S7M=
Received: by 10.210.10.1 with SMTP id 1mr4375427ebj.149.1223201642778;
        Sun, 05 Oct 2008 03:14:02 -0700 (PDT)
Received: from localhost.localdomain (abxa221.neoplus.adsl.tpnet.pl [83.8.250.221])
        by mx.google.com with ESMTPS id f4sm27973870nfh.27.2008.10.05.03.14.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 03:14:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m95ADRWP009092;
	Sun, 5 Oct 2008 12:13:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m95AD9Jq009087;
	Sun, 5 Oct 2008 12:13:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8ce0dfd6-2bd7-4e94-901f-b7c9bbd114aa@w39g2000prb.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97507>

bain <bain@devslashzero.com> writes:

> This is an announcement for a small project to create a functional
> git gui.  This project was born as KGit a couple of years back when
> i needed a ui commit tool and none other were mature.  My ambitions
> have grown since then and I recoded it in pure QT4.

Could you please add info about teamGit to the git wiki page
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools ? I think
just below now defunct and unmaintained KGit (or just above) would
be best.

TIA.

P.S. How it differs from othe Git GUIs, like gitk+git-gui, qgit
or git-cola?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
