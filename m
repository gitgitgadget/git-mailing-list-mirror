From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What are branches?
Date: Sun, 19 Apr 2009 10:24:31 -0500
Message-ID: <b4087cc50904190824k4b02a34uf901428e20cb8c7@mail.gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 19 17:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvYuE-0003CZ-LH
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 17:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516AbZDSPYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757739AbZDSPYd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 11:24:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:27203 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548AbZDSPYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 11:24:32 -0400
Received: by qw-out-2122.google.com with SMTP id 5so651401qwd.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CCi2PVA246Wlw+4aZJgEBBslACQvqO0sltu+NuNO9yo=;
        b=Af2Mw24VvjIJfhIdcaFkiX02TcWCwV6QwBIJZ0LwKKHlZP2Elfv5N9dALEbhmxd6Vx
         +fQn896SdnflxKFGXIT7wdgDN6KfYJXlvK/GhCsp9xbsgHUce0P1KTmyhtRlPx7/T4w2
         ZigwmE1uF1jeWz+ewEmoqvbsu9V5+yeP0NWHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=egj/HcvWeQhyWSgH5ILNEZNVkkSea+08W/iQ9zFaSv6vanAwWl3MwgG61Plav7btlF
         Pb8ndUK45E2ytp8EYm+kbOCaxIiCihEw+Y0aJXIM4XXSWKIzKaABo05qiqFBhDOQbCus
         EO82yZGAz+nFKFhJl2JC1rj/I/9MgbJdB5WDU=
Received: by 10.224.67.1 with SMTP id p1mr5435006qai.263.1240154671329; Sun, 
	19 Apr 2009 08:24:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116904>

On Sun, Apr 19, 2009 at 10:17, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> if you're like me, you used Git for _way_ too long to really understand
> how anybody can say that Git is hard to learn.

I think that the human brain struggles with indirection. Consider that
so many programmers have a hard time understanding pointers; no wonder
so many people find git's underlying concepts boggling.

Michael WItten
