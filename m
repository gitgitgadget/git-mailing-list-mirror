From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Thu, 2 Jul 2009 15:58:34 +0200
Message-ID: <46a038f90907020658g67cc0fcdi99c8455842b7ad43@mail.gmail.com>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 15:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMMoJ-0008KT-EL
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 15:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZGBN6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 09:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbZGBN6e
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 09:58:34 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53635 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbZGBN6d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 09:58:33 -0400
Received: by fxm18 with SMTP id 18so1509230fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tppEgHYLBzlNf+SksRTwuoVoRbsk3mUPwJ3I2JyRwxw=;
        b=bRWj8SQ/l0EfVsRAQ4dDdkXjaOHGeA41dATpogLpaE9CZP0SqVukixThpOQANGuztR
         oxiG7fe1yktYo0wdPZZ83vXYKp5FX93Bi+ZHpVazW3YL2ZQw7fxxBNZy83Dl7T/UD51y
         A1zH895zq3KLFXfCcEAnp/Ot2yRBmI7+4YPXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M4jtL86HHwv+su16nAP3G8I7wi9vnUAhOgMdtSouMyyhJ+MM60f1McE2VeKvtHQVdx
         iGIaq4N6/UMW65VLppMgik985IcHnEHsgcjSij1qrmYjoj4xNp9Pjm8wGwdNZEfR8YtO
         79/jUnixFRwN0qQxieIDMB8satn6wv8TcR/CE=
Received: by 10.223.113.3 with SMTP id y3mr73786fap.71.1246543114100; Thu, 02 
	Jul 2009 06:58:34 -0700 (PDT)
In-Reply-To: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122646>

On Thu, Jul 2, 2009 at 3:11 PM, Sitaram Chamarty<sitaramc@gmail.com> wr=
ote:
> The git faq says SMBFS is not recommended. =A0Searching for
> "git on NFS" gets me too many hits about the NFS _code_ :-)

You can use marc.theaimsgroup.info to search the git list archives.

hth



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
