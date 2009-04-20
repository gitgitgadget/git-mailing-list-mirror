From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 14:58:51 -0500
Message-ID: <b4087cc50904201258s4da6cb90rdc84e40c698a9798@mail.gmail.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	 <m3eivnp5p4.fsf@localhost.localdomain>
	 <76718490904201127n5bd9836ak796792ce3cfd18a6@mail.gmail.com>
	 <76718490904201132h3932e6dan3b1c0d841bd3cf00@mail.gmail.com>
	 <b4087cc50904201140n1e156583w28b5c411850d7d25@mail.gmail.com>
	 <alpine.DEB.1.00.0904202110350.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvzfJ-0007GF-D0
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbZDTT6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbZDTT6x
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 15:58:53 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:28011 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZDTT6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 15:58:52 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1086401qwd.37
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IdY5fwrdQuL6E9/7jhktTdoNMoxX3NDkeRlUuLYhWjM=;
        b=UOJLWQjtHnilNXUkSRiDrInygX974zLs6tKlSMX3p8bK/+ol1Hz0ts9a46cyjMn1TV
         lCgMOEPQWQVAMZYJD2FXrAs/F41cKaYPyDB+CRDlPdaXXh5Mrb8GAco2KDaTbKRhrri4
         vMikputGygmKlVyyRZdQLTIdummKOrepLO8ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hl7La4DCdi9Locdf23iv8moNoYmZXxsvDg8jpXWb4VnizlGr9D6lcaY8cTCGKNu/4Z
         AYX/Bmfp733cTKsxk1LYs9LLgP1T5TrMv7uobzWslORxwOYEO+HPo3yp6R5p//EhtZUs
         Ei1hkabGkrFk0As5pagYzILKXu124S92qzZUo=
Received: by 10.224.60.70 with SMTP id o6mr6807316qah.105.1240257531450; Mon, 
	20 Apr 2009 12:58:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904202110350.6771@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117026>

On Mon, Apr 20, 2009 at 14:11, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 20 Apr 2009, Michael Witten wrote:
>
>> It looks like 5.6.0 was released a DECADE ago. Drop it.
>
> What part of "causing others a lot of pain" did you not understand,
> exactly?

I'd say: Take your own advice.

It's very likely that requiring compatibility with a DECADE old perl
is going to cause others a lot of pain.

At some point, backward compatibility is just stupid; it's meant for TRANSITION.
