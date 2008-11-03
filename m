From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Mon, 3 Nov 2008 09:40:51 +0100
Message-ID: <bd6139dc0811030040q1dd8de49t23f7924e03ad289d@mail.gmail.com>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
	 <7vljw5evj5.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0811021124q5ba22d6bm6655f735aaeb379b@mail.gmail.com>
	 <alpine.DEB.1.00.0811030729071.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <ee77f5c20811022307r59dc4d09m20551a339a2993ea@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 09:42:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwv0h-0007Rc-PS
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 09:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbYKCIky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 03:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbYKCIky
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 03:40:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:25053 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779AbYKCIkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 03:40:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2109812fgg.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5oQmbDqYFI8KoogS2EhSQTd+Bslrg0iGR4cbYM7IRbI=;
        b=sH90TFvOt4fyIBiRFW/8LVZasioHWvlDOV7nJqVL+VfIC2MINnQ7BL7z9KZN2ds7VE
         G0Isgr6YPpwSeOvZBdgdUc+Qq/i3QI2/3uFOz2sIXlgQRmIeZNVzWnwiJMGKd2vVxy3H
         DiwNQMFhjLNnIh1fy8lcJKW+uFWUjcd3khx1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=tFWoebO8dNAQq2EAT2CZkbmQMDFHM/yp6lw8p123csXNsYKl/rtnCJS/4Mhy3S7ODG
         mBRNRDNTmWg5qUaCvectGs+gEc/Sb2mb8sFD4KVjNIU1jtynYckNwMX00gFrGtBOedOX
         VYheK5KQODJiy169cbcKT//1ZbWCs67q++Hik=
Received: by 10.187.211.3 with SMTP id n3mr1861334faq.60.1225701651689;
        Mon, 03 Nov 2008 00:40:51 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Mon, 3 Nov 2008 00:40:51 -0800 (PST)
In-Reply-To: <ee77f5c20811022307r59dc4d09m20551a339a2993ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99911>

On Mon, Nov 3, 2008 at 08:07, David Symonds <dsymonds@gmail.com> wrote:
> I chatted to Sverre separately, and I think we concluded that we could
> probably just do a single patch (no history, no changelogs, etc.), and
> just point to the complete git-stats.git repo for folk who want the
> detail.

Either is fine with me, anything to get more exposure is fine with me :).

-- 
Cheers,

Sverre Rabbelier
