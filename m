From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Wed, 14 Apr 2010 08:22:48 +0100
Message-ID: <20100414072248.GA30975@arachsys.com>
References: <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
 <20100408115706.GE2077@arachsys.com>
 <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
 <20100409054536.GB2151@arachsys.com>
 <20100413090604.GB770@arachsys.com>
 <20100413090713.GC770@arachsys.com>
 <7vsk6zt93s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 09:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1ww7-0002Un-U1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 09:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab0DNHWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 03:22:52 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:52042 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0DNHWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 03:22:51 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O1wvx-0002Xk-JX; Wed, 14 Apr 2010 08:22:50 +0100
Content-Disposition: inline
In-Reply-To: <7vsk6zt93s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144855>

Junio C Hamano <gitster@pobox.com> writes:

> Ok.  Somebody else may want to add an autoconf support on top of this, but
> this is good as-is, I think.

Thanks; sorry it took me three attempts to get such a simple patch right!

Cheers,

Chris.
