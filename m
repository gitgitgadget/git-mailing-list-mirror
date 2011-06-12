From: Michael Witten <mfwitten@gmail.com>
Subject: Re: file mode
Date: Sun, 12 Jun 2011 19:12:42 +0000
Message-ID: <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
References: <alpine.DEB.1.10.1106122055210.6124@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peter Kleiweg <pkleiweg@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun Jun 12 21:13:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVq62-0004Pl-GM
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 21:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1FLTNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 15:13:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52547 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab1FLTNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 15:13:12 -0400
Received: by iyb14 with SMTP id 14so3356181iyb.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NLD78Uxklt7AYBgwjVm4BXZEQOhRDua5AHhHtKnh89o=;
        b=OucxmW0bq3GGTjA02tXDZVfMb1QQS5NfIkWEMWFMl0vYLcN8d8sine7ks3r2woodNw
         LzmXZ6Q8763YFzmeQJtiKbWP1bg66dOQ14sNyxjTeTmq0DFEX0m84+O86Q4vfJ7saaVH
         YSerFLgsAvM2qtvLlOADQ6gew1OHd9V5nK/y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=yFGnqyv0JASF6yi1Z2dIrywZ/S68NSbgVF81AAkJ9XZazvEtH25WORCuTeJRNwLyDi
         3N0PIEqQJb1sAWQc+S5zo8K8eGWrNVecYxcHrGCClb6QXWBZ2cCMbKVZPzu+JCQgZTcY
         VAOPJ+w8+5Gb4YNRS7XGAFSqSj2HpVJDKp0dM=
Received: by 10.42.166.3 with SMTP id m3mr5700254icy.113.1307905992108; Sun,
 12 Jun 2011 12:13:12 -0700 (PDT)
Received: by 10.42.217.197 with HTTP; Sun, 12 Jun 2011 12:12:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.1106122055210.6124@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175664>

On Sun, Jun 12, 2011 at 18:57, Peter Kleiweg <pkleiweg@xs4all.nl> wrote:
> I added a file that has file mode 600. When I do a check-out,
> the file comes with mode 644. Is this supposed to happen? Then
> how do I control what permissions files have?

Do some googling.
