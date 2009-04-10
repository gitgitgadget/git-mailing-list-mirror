From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 07:37:10 -0500
Message-ID: <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
References: <200903171953.23650.ogoffart@kde.org>
	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
	 <200904101417.56422.ogoffart@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Olivier Goffart <ogoffart@kde.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 14:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsG19-0000lz-Pv
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 14:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938146AbZDJMhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 08:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938019AbZDJMhN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 08:37:13 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:51861 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938124AbZDJMhM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 08:37:12 -0400
Received: by qyk16 with SMTP id 16so2199057qyk.33
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2I4m9RsM8xzFOIOBeSTSDMG4oVMuop5ewah04A564lw=;
        b=LU4bjq+upWB1pQDR+3H+UDZ9IlImficI6suTkg2WvnZpeZ6saNhJ8eMEGR4ExxbGG2
         vxYrCcGO1T+HsrpbvOcE0790n5Tz2DHVg38hBpo8Lm+DH9K2fD65XDS7mbmtG7L7FawY
         lUBqn3r1REjXp8jUJHUIgdbi9SKIlU04xW9UY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CoGGjAwQSwipcEYgC99kHuszKpFOzgh35FqxSx6V6g7n4S5J0fV5Xomp59fqCYO+dx
         mW6h+4vxGLE2z7NdyaodX07QKOeAHMWNMwSiLsXCGv5oY4LeeFHqNl4dezWan2ZWqzNU
         hI3Keij5ZS5+8tnd+ZDlVXDj5KjKDIe0AodSY=
Received: by 10.224.37.74 with SMTP id w10mr3584qad.14.1239367030218; Fri, 10 
	Apr 2009 05:37:10 -0700 (PDT)
In-Reply-To: <200904101417.56422.ogoffart@kde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116257>

On Fri, Apr 10, 2009 at 07:17, Olivier Goffart <ogoffart@kde.org> wrote=
:
> Hi,
> Sorry I'm late to reply :-)
>
> I still think this feature to edit the message in git rebase -i is re=
ally
> usefull. =A0So 'm' is really taken, what about 'r' for 'rephrase'?
>
> or maybe 'rephrase' is something different?

How about 'a' for an immediate [a]mend?
