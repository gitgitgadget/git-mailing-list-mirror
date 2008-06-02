From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Development strategy
Date: Mon, 02 Jun 2008 12:09:07 -0700 (PDT)
Message-ID: <m38wxn1wq8.fsf@localhost.localdomain>
References: <48441715.4010507@gmail.com>
	<bd6139dc0806021130p2cc442a3qfe9c00681fdb05e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Lea Wiemann" <lewiemann@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sverre Rabbelier" <alturin@gmail.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jun 02 21:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3FQJ-00031l-K6
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYFBTJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 15:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbYFBTJP
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 15:09:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:33554 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYFBTJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 15:09:14 -0400
Received: by nf-out-0910.google.com with SMTP id d3so470415nfc.21
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=x81AhDBCqzdSwnaEjBZ0Vf13zM3AmjgufAPv+R4/M2o=;
        b=JjxwODz8HXYLELh/IFkUV5ce16P3AS30iNbBAY8Ocjau1YmNvHBQpLd+JamVGCywuCGk3zPIyj9ELXquj9x4wHyWoRoexBHbw6XoayL5U0GHTb2YdiJVTi0eW3Abm+mPcvTLgLnLEOdrdYp+hdzg1zL3X5iSNc6DA2O5vNjguHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=RwjxTLXKicik0yzRdmq/mjlFUuXNWmR/IQrRH/1yKX9PW00I4Yfp2L1uoXgwgiDZZSY+xdafxwsSP3aheV0wR2uHIiMXsoeZGs/7cLIusFURs8IfetOyAcqEVZxCwKa3OVrk/BrWTcqSmC23NCyo60mLmxud2/LDBR2U24j3a1g=
Received: by 10.210.42.20 with SMTP id p20mr1363960ebp.37.1212433748574;
        Mon, 02 Jun 2008 12:09:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.52])
        by mx.google.com with ESMTPS id i3sm6503007nfh.14.2008.06.02.12.09.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 12:09:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m52J8T0H020198;
	Mon, 2 Jun 2008 21:08:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m52J81Vp020193;
	Mon, 2 Jun 2008 21:08:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <bd6139dc0806021130p2cc442a3qfe9c00681fdb05e3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83554>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> Cheers,
> 
> Sverre, who thinks a few RFC patches are in place soon for git-stats
> too and is glad you are doing the fine-tuning wrt patch submission.

By the way, do you have public git repository set up somewhere (for
example at repo.or.cz)?

Shawn, what is the status of other git GSoC 2008 projects?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
