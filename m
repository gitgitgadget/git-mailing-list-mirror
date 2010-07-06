From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: help moving boost.org to git
Date: Tue, 06 Jul 2010 01:51:00 -0700 (PDT)
Message-ID: <m3ocelm1tj.fsf@localhost.localdomain>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org>
	<4C32668E.9040000@boostpro.com>
	<loom.20100706T034440-190@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Niebler <eric@boostpro.com>
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 10:51:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW3rz-0005EB-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 10:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab0GFIvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 04:51:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53729 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0GFIvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 04:51:03 -0400
Received: by bwz1 with SMTP id 1so3319809bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3U9ZNJra5x2wpAL6PJoiEEaM/HoQaxvZ4cL2qMVl718=;
        b=W9M9Uq+r1zS6y/hMMvp4sUfHHaqBOpWli8Fn3GZMSFcSMc7WbEoc0a0kz3HAWHxG2/
         JrnOSEeq68aAEBFqqe8gssxZRTcGz4QXLhIchADyoPBZ7n4ypDvfnxSiguPBAq+T/qlO
         iNteLU3w3SpIQ/wgTWepAxAhQtFQzKz5EZfOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=m02wVMI9aWpOQ5RvDldDyAXk76Qve16b5VPQ0n3UGqQVy0omPYuqlwdSAIAjwx4FTm
         fGTwaSmK/muCudokTsvfAM0wR8b+AyMWsHDzPqn1YE/o3vMgw2e/AhoQplfSYA078SiR
         UjU2VIAL1VVpICBnvQSr0F58ku2mhofN81VCE=
Received: by 10.204.83.211 with SMTP id g19mr3365337bkl.50.1278406261069;
        Tue, 06 Jul 2010 01:51:01 -0700 (PDT)
Received: from localhost.localdomain (abwo240.neoplus.adsl.tpnet.pl [83.8.238.240])
        by mx.google.com with ESMTPS id 24sm21980056bkr.19.2010.07.06.01.50.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 01:51:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o668oXgd007454;
	Tue, 6 Jul 2010 10:50:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o668oG65007447;
	Tue, 6 Jul 2010 10:50:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20100706T034440-190@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150335>

Dave Abrahams <dave@boostpro.com> writes:

> Eric Niebler <eric <at> boostpro.com> writes:
> 
> > We are aiming to make boost a clearing-house for C++ libraries (like
> > CPAN, or PyPi for python), 
> 
> Clarification: that's our goal for Ryppl, not Boost.

By the way, could you please add information about Ryppl to Git Wiki?
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Thanks in advance
-- 
Jakub Narebski
Poland
ShadeHawk on #git
