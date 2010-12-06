From: Miles Bader <miles@gnu.org>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 6 Dec 2010 17:39:54 +0900
Message-ID: <AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org> <20101206082948.1403cc5a@chalon.bertin.fr>
 <buopqtfmi85.fsf@dhlpc061.dev.necel.com> <20101206092122.21c19011@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Dec 06 09:40:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPWci-0002LV-Vg
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 09:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab0LFIkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 03:40:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36006 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0LFIkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 03:40:35 -0500
Received: by fxm20 with SMTP id 20so3963406fxm.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 00:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KW9q8OpCZLqSbCTxKql/iDiK1Hg+Oeg5LFi3de/vJXc=;
        b=ESyKODsDcsp4OJdS6thkJ41nAl39bhNuGdDXR9NgR1tu0fDlQd8ECjGujwbxLE7EJ+
         N6zrNXA1Jza4ifBSRbp0AkIt2njtM8miMD9tln5+Em0szF8c/SkFCtVSI6MuyR6noage
         H9wMjpkzL4EwKZk1DgTH87QyFzMVomd1NyUA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=WwP1Ky3wWQtj8fYyO5uaKKiXeSOjdmOT0c8ZrRay6qovYikX2B8ZYu/sBHtmRfH9tH
         F9jNy3vkqE8pq+Z/l3ICkX10MVxV/8w/PPXWoPvyjptR2xeqtyosExLKs9v9xcP1k/sA
         VDOWDb7vJPdEKyEGNOclQk5UM5MjeIZbNsbHU=
Received: by 10.223.86.4 with SMTP id q4mr5287886fal.20.1291624834464; Mon, 06
 Dec 2010 00:40:34 -0800 (PST)
Received: by 10.223.96.80 with HTTP; Mon, 6 Dec 2010 00:39:54 -0800 (PST)
In-Reply-To: <20101206092122.21c19011@chalon.bertin.fr>
X-Google-Sender-Auth: iM9NEcmsfBCtTjSCuEGPIgWC3LY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162984>

On Mon, Dec 6, 2010 at 5:21 PM, Yann Dirson <dirson@bertin.fr> wrote:
> Seen that argument before.
> 1. does anyone care ? (I personally don't)

If nobody cared, you wouldn't get an argument.

-Miles

--=20
Cat is power. =A0Cat is peace.
