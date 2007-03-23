From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: Installation instructions for gitweb?
Date: Fri, 23 Mar 2007 13:20:25 -0300
Message-ID: <f329bf540703230920r5034d025p5fd169b06837ad4e@mail.gmail.com>
References: <etufpl$7en$1@sea.gmane.org>
	 <20070323161210.GI8017@planck.djpig.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Han-Wen Nienhuys" <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 17:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUmVD-00005F-5d
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 17:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbXCWQU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 12:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXCWQU1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 12:20:27 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:30146 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXCWQU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 12:20:26 -0400
Received: by an-out-0708.google.com with SMTP id b33so1437928ana
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 09:20:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r7bEK6RrnsoiE5Tq/l8MWNKLvtLpSVmgM2NZ6l7m6cWoJ3i2phY08TCunB8WGDsJbtE3d8w2aJQJJRaAVygdMHjCYu8ykUiS+qxJRrDKm9d4yZdfF6IpGWWA1EK4qG/P/ylceN3OeTelKaXyHhqzgBKPNKGJFIzHrg1/LUb/20c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TxrBzfv0T2B00XaBnz+SJ+kMOllj5uI0iv/HhCQy1A/1NrJu79ZlMFL0k12/6e5DOyPivSYMPxFQZ/a48VwWhx2u0XDfOc8I/K1gPj/Qgx9l5sEB+2JsINex6sWLWgRoHYcriLtNkWno6jxPim9aumqv4rogy5dLz1ZL5dlBVKA=
Received: by 10.100.135.16 with SMTP id i16mr2856273and.1174666825993;
        Fri, 23 Mar 2007 09:20:25 -0700 (PDT)
Received: by 10.100.92.11 with HTTP; Fri, 23 Mar 2007 09:20:25 -0700 (PDT)
In-Reply-To: <20070323161210.GI8017@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42947>

> gitweb_conf.perl is just included as perl code. It is primarly useful
> for overriding the variables defined at the top of gitweb.cgi

This explanation doesn't help me. Can you post an example snippet?


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
