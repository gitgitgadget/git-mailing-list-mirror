From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 02:05:16 +0200
Message-ID: <40aa078e0907291705r65feae3au1dfc5b6400f4e434@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:05:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJ98-0001nH-OD
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbZG3AFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 20:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbZG3AFS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:05:18 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:61298 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476AbZG3AFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:05:17 -0400
Received: by fxm28 with SMTP id 28so322143fxm.17
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/VhWJNatr2dzUi71bVNm+ujJgfhIZLXL+IwT3Qd7RaE=;
        b=NYiRpX1A0pYWSIBbVaT1+5O2FC+NpXGLSe9uvQ+eLBeH7fgVs81I8Cg5kLXZnwDMIb
         UND5YzgFB/yB08vD22HGj9Api7mwPDhD97uWA116uvAX9CC64nEnJTDVrOwdh73SxScR
         yDe7EKUR4yQZ52CqWxy61peg1hPYgqJz7/ZO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SwV1fSk8dobWCs3IZ+vnqc8e8O3PmAhAVZHB68Nsl1aqwwGl9DUczJ+MBaitMfAeBk
         e3DSoEyH22oYmFnNAJZUDidlhX/hJh5EYJ2RhxwaJ/aQqyaqwMpgMCvWhONi62oKJ0ox
         /ZPfBzR3JhlQMSxfkJk5HiVtlv7KrBxlXp0l0=
Received: by 10.204.103.203 with SMTP id l11mr424697bko.71.1248912316270; Wed, 
	29 Jul 2009 17:05:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124415>

On Wed, Jul 29, 2009 at 11:40 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> this mail informs you that Git for Windows 1.6.4 is out. =A0It is les=
s well
> tested than the previous versions, mainly because I was busy with oth=
er
> things and asked for help with testing on the msysGit mailing list an=
d I
> am very impatient.

I'm having issues installing msysGit-netinstall-1.6.4-preview20090729,
due to lack of libcrypto.dll during installation. The command promt
says:



--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
