From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Tue, 15 May 2007 11:34:09 +0100
Message-ID: <200705151134.10229.andyparkins@gmail.com>
References: <200705141429.58412.andyparkins@gmail.com> <200705150914.44641.andyparkins@gmail.com> <7v8xbqlb68.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 12:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnuMJ-00075z-6Y
	for gcvg-git@gmane.org; Tue, 15 May 2007 12:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbXEOKeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 06:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbXEOKeS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 06:34:18 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:22656 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbXEOKeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 06:34:17 -0400
Received: by py-out-1112.google.com with SMTP id a29so72197pyi
        for <git@vger.kernel.org>; Tue, 15 May 2007 03:34:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f0gQUZLL9nOz79/Qw8y45qmeZ0L7fsfZgP0BVnDbAuZLA4xQnLDUn/PHxztIK7ufG6Mbhfp3DP9IBjki02nbgYBIMWv6jEJOxBsVuqdkFv15JQ9aIdqhNzOOD//9gxlGNc5MJnbMcjmAlOeo5RD+lZWAzW0l6EUhNfysSAgL5aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G4TJ2por0VUV0qI/lS9LYsf8UiTiZc9sR/QpQRxDWZtQIHpbcx5VKqIMPdpTG89LUhQue6o4NsXbxlru7FKL7W/mmZ2QPL3CYo0th962cslrENsVxpV+Uo/6w58nAE+uqXweY9YMjAkR/PjaUZ8/q0kSMqeuVb+tsBwUBzFX034=
Received: by 10.64.249.18 with SMTP id w18mr574286qbh.1179225255468;
        Tue, 15 May 2007 03:34:15 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id e18sm349048qba.2007.05.15.03.34.13;
        Tue, 15 May 2007 03:34:14 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8xbqlb68.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47337>

On Tuesday 2007 May 15, Junio C Hamano wrote:

> Actually, Documentation is the least offence.  I wanted to have
> somebody sanity-check the change to count_ident().

Blimey.  It's a good job you're awake.  I'm ashamed of myself for missing 
that.  Apologies again.  You should have just prodded me - I'm always happy 
to fix my mistakes; I certainly don't expect you to have to apply patches and 
fix them as well.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
