From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 00:28:02 +0200
Message-ID: <85ejhvkxvx.fsf@lola.goethe.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	<vpqlkc34ret.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 23 00:28:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INygN-0008Ua-Gy
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764148AbXHVW2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 18:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759843AbXHVW2G
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 18:28:06 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:59216 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759811AbXHVW2E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 18:28:04 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E4B8E15BEAA;
	Thu, 23 Aug 2007 00:28:03 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id D9B78ABAE7;
	Thu, 23 Aug 2007 00:28:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-060-116.pools.arcor-ip.net [84.61.60.116])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id A5A011C761F;
	Thu, 23 Aug 2007 00:28:03 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3722F1C36605; Thu, 23 Aug 2007 00:28:03 +0200 (CEST)
In-Reply-To: <vpqlkc34ret.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed\, 22 Aug 2007 15\:42\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56431>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Could you be so kind as to give a one-sentence summary what the
>> benefits over using a shell script would be?  I think this work has
>> started before I joined the list, and I'd be interested in the
>> motivation for it.  In general, I find shell scripts more pleasant for
>> hacking on than C code, and there is no long-term plan to replace all
>> of them, is there?
>
> That's a Google SoC project :
>
> http://git.or.cz/gitwiki/SoC2007Projects?highlight=%28soc%29#head-2b49ddde32756b52fde3b9d9ab01e1bff6aa687c

Thanks, good to know.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
