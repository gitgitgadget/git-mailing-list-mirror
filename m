From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Windows & executable bit
Date: Tue, 18 Aug 2009 18:47:14 +0200
Message-ID: <4A8ADB12.2080005@gmail.com>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>  <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>  <200908181223.48291.trast@student.ethz.ch>  <alpine.DEB.1.00.0908181355090.4680@intel-tinevez-2-302> <40aa078e0908180519u41b28ce7oc851791db1d5f773@mail.gmail.com> <alpine.DEB.1.00.0908181459380.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ferry Huberts <ferry.huberts@pelagic.nl>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRqK-0007v3-U7
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360AbZHRQrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759124AbZHRQrT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:47:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:12871 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbZHRQrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:47:19 -0400
Received: by ey-out-2122.google.com with SMTP id 22so799513eye.37
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=MO5jnNn9i7Nx334tAaQ+X5OggLdscuz756zc8rAYmNM=;
        b=xPrrIC5Lwx8G0OHCkVR+Bo9LlqJXtccltYmNFpXDSbz8wM646WEQF6mCn9c44HVu5U
         euVKCC/1xIpfRQXMVhW3lzf4TKuXrqWdb+QVBjJgGHy3DRTDpcWek1Y0WQfIe7rha5XE
         +Lha3vzLonfnZLzQ2iKwiu8y9t+ENH9XgUrMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=HG1d+5K20GuhJkn9p0eTS4xI0s8CCcN1MZJlmKA6bzeOthX+dufA/2FEnCQdKBjUNV
         Kq9v4z/nhydWtXVuByKHxJ/PNu7VglB0PfyiH7B8+yL8bOCTaltBMAifwY7J4W6ostc9
         u5EtohznvJwrsDYlqRCwrsVF2upOaoFpzTb1Q=
Received: by 10.210.71.13 with SMTP id t13mr2389833eba.13.1250614038689;
        Tue, 18 Aug 2009 09:47:18 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 28sm380759eye.15.2009.08.18.09.47.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 09:47:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Newsgroups: gmane.comp.version-control.msysgit,gmane.comp.version-control.git
In-Reply-To: <alpine.DEB.1.00.0908181459380.4680@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126414>

Johannes Schindelin schreef:
> Hi,
> Bah, you're right.  I let myself fool by the lowercase 'm'.  Sorry.


Haha. Looking with developer eyes. I know that problem from someone... 
Oh yea, me.
