From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 11:52:03 -0500
Message-ID: <b4087cc50904270952k5a7383e6hd3b29104a7aac1fd@mail.gmail.com>
References: <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
	 <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
	 <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com>
	 <20090426112802.GC10155@atjola.homenet>
	 <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com>
	 <20090426175613.GA4942@atjola.homenet>
	 <F2B2D447-57B4-459C-8A0D-A94C12AE791C@boostpro.com>
	 <20090426222532.GA12338@atjola.homenet>
	 <33614929-B5B2-4B54-BF18-81ADBBCC4925@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyU42-0006dx-OM
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbZD0QwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbZD0QwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:52:09 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:37299 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZD0QwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 12:52:08 -0400
Received: by qyk10 with SMTP id 10so47052qyk.33
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=87pxYYa8lHL5+E+pce3V70yaRTUr5QUa+Q9yhMRKgjY=;
        b=oh/uFe10hC/AWHTXtEneeuDKZbPhBXnd3/To2SoImvVEH5n/iPwsCEM0epDWTTytNh
         U7MY0Jj/U+Y3BXW6XKmodFAqRS0bNkzwm1gFPZ3uiGYDm38zLEVeHxH9TbmAawyyv5/A
         9PqtLr8WZEawYFsENeABb6gLC7dGaA6WoBNL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ESq7PdQlqO17iiVPsztgczKljW4ENk8qh0tt6wbHYh08yr9pp/CxKKyGpWFqMjwwvp
         OknTMhw4ed1uG61JUDgb4CWm5DaQvaqzvIXv7UDQdQpzuZ5SLEPVai3fU9ZU7ESGrz9i
         mfmIi2ObAXwesl1g8/bCAwZGGVMjDuV3bD5P4=
Received: by 10.224.10.208 with SMTP id q16mr6160688qaq.387.1240851123524; 
	Mon, 27 Apr 2009 09:52:03 -0700 (PDT)
In-Reply-To: <33614929-B5B2-4B54-BF18-81ADBBCC4925@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117691>

2009/4/27 David Abrahams <dave@boostpro.com>:
>
> I didn't. =A0I meant the general notion of "object" in computing. =A0=
I'm trying
> to talk about how the language used by Git's docs can bias people tow=
ard
> correct or incorrect understandings of Git as they're learning.

Actually, I believe object was first used to describe anything stored
in memory. Given that, I still think my usage of C pointer terminology
is superior to everything; it's just the case that objects are content
addressable in the git world and location addressable in the C world.
