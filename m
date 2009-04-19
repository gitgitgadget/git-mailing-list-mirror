From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 00:10:52 +0200
Message-ID: <4ac8254d0904191510v72ab2f92t6839c8354d0c6fe4@mail.gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 00:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvfFl-0004QT-1H
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 00:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbZDSWLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 18:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZDSWLK
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 18:11:10 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:64242 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZDSWLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 18:11:09 -0400
Received: by ey-out-2122.google.com with SMTP id 9so71806eyd.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B7tgFOlwXR1CKMNQkhmsVvtrjPNn+pweVJsOnMm4xbw=;
        b=v+3E+yHkDOWinEipxYq/0fUsExcyV9FmjT17Jm6i1JtD97MA7A4z5TcWbH80IoZvr/
         /G5BKXPoXDdk/W5dVNvtZMiiAH4jQr5sNsnmQoYkYoBvIwWs/98dBi+Ow4gN+c0PHng3
         SpPdDiaqgap9PJ7sPu35vt1lZK0e2m5T21UVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GLs9I0CG1y4qPPVGPc34WG/ioQwe6gn728EcasiQxoORydTcHu7dX/Zx+Kxjkjal35
         SH6fsYAbV/erKEIgRdFU+XcuJJVKv/52Ll7y+De+bqEd+/PY4b0AgfWRKdPqeNsvOC3r
         E4gVjkg3yphzxCjHdhhHVtmmF/zcmEV9D0GQI=
Received: by 10.210.111.17 with SMTP id j17mr5123986ebc.22.1240179067098; Sun, 
	19 Apr 2009 15:11:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116914>

On Sun, Apr 19, 2009 at 5:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> if you're like me, you used Git for _way_ too long to really understa=
nd
> how anybody can say that Git is hard to learn. =A0The concepts underl=
ying
> Git have sunk so deep that I do not question them anymore.
>
> But it is important to keep in mind that our concept of branches is n=
ot
> intuitive:
>
> http://longair.net/blog/2009/04/16/git-fetch-and-merge/
>
> In particular, we have some pretty confusing nomenclature when it com=
es to
> branches, and we might want to think how to improve the situation.
>
> Food for thought on a lazy Sunday afternoon.

Probably in the same confusion department:
http://blog.teksol.info/2009/04/15/beware-of-gits-content-tracking.html

Is he right and is this the defined correct behavior?
