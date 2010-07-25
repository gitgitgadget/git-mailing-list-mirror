From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-remote-svn: Call for manpower
Date: Sun, 25 Jul 2010 15:18:50 -0500
Message-ID: <20100725201850.GA16713@burratino>
References: <20100725102908.GA2726@kytes>
 <AANLkTinrAAmr17ujD0ubOQQEZsEy=R0k2Q4HV-5WvyrR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 22:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7gT-0007xQ-Ap
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 22:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab0GYUUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 16:20:01 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51376 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0GYUUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 16:20:01 -0400
Received: by gxk23 with SMTP id 23so639431gxk.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TEblvPekGRgsNuBvaGhqneKlNq0pYUm5WCj/CXHJWHw=;
        b=pc7Xky/xEMhQCbpLsGPtEoNn6l9RLoga6hJgwBfn6362Z+XmnEzmmhFHNuxT4viHXw
         3M0UDXes2dzp/LihHJQFyLeSyre3jlqqRg6mUME6GRfgBwCggf8zD5Q0WLfLxiBhwhk5
         /Pl/lBTXqT5yUF6DyHaQCCEZiT/x2DJukTX7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=B3Yc0G3DHU7tYnnvnyOMeJv2qmPlcYylHhxOV54wkBC+OPnInS1wASrIvBoL9TKi+h
         20QH+53SMfOaUGDsEQVuqXvDuOBVLilXBc6ElUKsYNwvu+VdjupmVHYu2aQjU4f0I7zU
         sCujsOuNJkG636Tf0V8v+t4BeMZEyYzsks6w4=
Received: by 10.100.33.14 with SMTP id g14mr6715493ang.180.1280089199997;
        Sun, 25 Jul 2010 13:19:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm5072808ant.1.2010.07.25.13.19.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 13:19:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinrAAmr17ujD0ubOQQEZsEy=R0k2Q4HV-5WvyrR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151791>

Sverre Rabbelier wrote:
> On Sun, Jul 25, 2010 at 05:29, Ramkumar Ramachandra <artagnon@gmail.c=
om> wrote:

>> 7. Modifications to svn-fast-import: Sverre, and Jonathan: what's th=
e
>> =A0 status of this?
>
> I assume it's still cooking? Jonathan?

Yep, cooking.  I was not planning to submit more git fast-import
patches until the caller is using it, so we can see how well it works
and not get locked into a wrong interface.  Though I would not
complain if the fast-import changes happen before then anyway. ;-)

Jonathan
