From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Sat, 8 Aug 2009 14:12:48 +0200
Message-ID: <40aa078e0908080512q43b3c772r3fe7a361102a73f4@mail.gmail.com>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
	 <7v4osj1odt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ori Avtalion <ori@avtalion.name>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 14:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZknI-0007TH-Q2
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 14:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZHHMMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2009 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbZHHMMs
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 08:12:48 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:49380 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbZHHMMs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2009 08:12:48 -0400
Received: by qw-out-2122.google.com with SMTP id 8so836961qwh.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NSZ07rkmL2hge5HG4GWhct1I7WYYrQKcCODguTt+rRM=;
        b=HcyJzNCpGtxtZMscA9VSp4S/zpy3j/Yg6n5G1X7CVTL2O8wWT/gKbUoUIUGLpC33R7
         pxLBwV2WsReLGp/ew91mmoUua0saELxSwmG9lW/+AXJtJnvQZTBZrzlkNORRZY2l8GX4
         oU0m9n5RdkA4ToQFaSnJIW5Yrq9WuDKctFahU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EOCUjZM3Cmzvr8DQL0t8jcf1Sf+DkFW6XcFXt7PCrPdvn5F4Oi4viuC5cuBXkm/06u
         se272nKXmM22h8jihs2V87Y0ewAgQe9nlGKNZNiUtpjmbfBL9fFQ6U32kRc585jhuOKS
         AjEkC1zjf7WFEJYewzG7/3ocTiBO4Lb4Tsac0=
Received: by 10.224.67.18 with SMTP id p18mr1869895qai.182.1249733568671; Sat, 
	08 Aug 2009 05:12:48 -0700 (PDT)
In-Reply-To: <7v4osj1odt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125275>

On Fri, Aug 7, 2009 at 8:15 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
>> -'git-rev-list' is a very essential git program, since it
>> +'git-rev-list' is a very essential git command, since it
>> =A0provides the ability to build and traverse commit ancestry graphs=
=2E For
>> =A0this reason, it has a lot of different options that enables it to=
 be
>> =A0used by commands as different as 'git-bisect' and
>
> Ok, but probably we would want to say "git rev-list" here.

=2E..or maybe just "rev-list", as we're now talking about a git-command
(and not how you invoke it)?


--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
