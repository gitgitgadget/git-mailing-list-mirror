From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 20:54:06 +0200
Message-ID: <fabb9a1e0904101154o6b4759ddk879bcdabcc03add6@mail.gmail.com>
References: <200903171953.23650.ogoffart@kde.org> <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de> 
	<200904101417.56422.ogoffart@kde.org> <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com> 
	<alpine.DEB.1.00.0904102019250.10279@pacific.mpi-cbg.de> <b4087cc50904101150i31f1bbfdre73bec44dac580eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 20:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLtN-0001vc-8X
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936557AbZDJSyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 14:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbZDJSyX
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:54:23 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:58822 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbZDJSyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 14:54:23 -0400
Received: by bwz17 with SMTP id 17so1182642bwz.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gDrcsX3uVjwo2QmF5BDVOMxPiPnzb6hn95sQ7QVXuV0=;
        b=lAN32aAiwSq4XCMIK/zoWtPYoJd8/F7c7KaQcsxd5aOoB76I1nnVeJnEBOruPyMAFD
         VhtO+C0smhkcB47Y3hbpy/0rX8eu/U5qcfelFy3YJmDWfyCJvvgQtVSDJqwgusFpPLFF
         yWBeWQq/7IWx5mb08j3Qj3WsJeR3ExwvNd+5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G1iuQnernVf685PS7vqhMpXbAs9Igls70Xywm3cklG/ConYTBDKZyRF8PHi1zgiljo
         vHRks+9QIAhEbBVr+xM90SeCNwzJvJqaMhQrbJUrcvQ0whf1fgYwfOxsMKj9end7P8z/
         Pvwvj3G6LtbcIQ2XY3dsMjzHKF09qc7sWnOtE=
Received: by 10.103.240.15 with SMTP id s15mr1996723mur.102.1239389661285; 
	Fri, 10 Apr 2009 11:54:21 -0700 (PDT)
In-Reply-To: <b4087cc50904101150i31f1bbfdre73bec44dac580eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116274>

Heya,

On Fri, Apr 10, 2009 at 20:50, Michael Witten <mfwitten@gmail.com> wrot=
e:
> Also, I still like the idea of being able to write:
>
> =A0 =A0git commit --amend HEAD~5 HEAD^
>
> and then have the rebase setup and started for me.

Suggested before and shot down with "how would that work in the light
of merges?"

--=20
Cheers,

Sverre Rabbelier
