From: Aghiles <aghilesk@gmail.com>
Subject: git pull suggestion
Date: Wed, 7 Apr 2010 19:17:35 -0400
Message-ID: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 01:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzeVW-0003cR-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 01:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab0DGXR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 19:17:57 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:55043 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0DGXR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 19:17:56 -0400
Received: by bwz1 with SMTP id 1so1329627bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=+Niu2PHtdxLUs1PQRmeYIW4qnAj6q0jfFicSjqSMUP0=;
        b=OdoFkzXsushCESbfJKJVqTPlsbAf9PR7GRdZfQaqQqtDs6rLbNIanJwf/rh2R6WE/W
         NOjRpmkO0Fe1hczXaNLrWTBhJXuVipIWJ/pGAy6VK1jVjgLI2XNsw/BpwNIFmgS9WUcr
         XY5KOLpZoxd5PYZzcTsPjT4fmTP2IjrlUEY9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=PL/olIYOelApkOEBbAKdW2v9Jvszf92WWb70s/5JxAUu6MBSr6D89Hr7q7tUalL+Sy
         lQkaFdTEYc9c6gS2rnz2SdlyTZeCzIkjahnlrqD5Qdd6+gx78J9rO0YJgjhXbIk6U6Ls
         MVPpBV6OhoQPqjATkd1M6F/AWh/sXTxK9uUyM=
Received: by 10.204.63.196 with HTTP; Wed, 7 Apr 2010 16:17:35 -0700 (PDT)
Received: by 10.204.22.20 with SMTP id l20mr4242287bkb.118.1270682275141; Wed, 
	07 Apr 2010 16:17:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144298>

Hello,

It would be nice to have _all_ the WIP conflicts listed when pulling.
As of now, one has to fix the currently showed conflict to see the next=
 one.

If there is a way to do that, please advise.

Thanks,

=A0 -- aghiles
