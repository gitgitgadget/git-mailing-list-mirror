From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 12:47:39 +0200
Message-ID: <20050704104739.GH18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050703230326.GF18608MdfPADPa@garage.linux.student.kuleuven.ac.be> <20050704014948.GK29809@kiste.smurf.noris.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 13:06:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpOlw-0001jz-TF
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 13:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVGDLE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 07:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVGDLEz
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 07:04:55 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:61070 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261627AbVGDLEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 07:04:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id BE047137A11
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 13:04:22 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id F271F1379B1
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 13:04:20 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id D373A4C2C5
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 13:04:20 +0200 (CEST)
Received: (qmail 26511 invoked by uid 500); 4 Jul 2005 10:47:39 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050704014948.GK29809@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jul 04, 2005 at 03:49:48AM +0200, Matthias Urlichs wrote:
> Sven Verdoolaege:
> > Note how the patchsets with the same date have somehow
> > been reversed.  Any ideas ?
> > 
> No. I process the lines from cvsps in the order I get them...
> 

Ok, I reran cvs2git and now I get the same order as with
your script.  Something must have changed in the output
of cvsps.

skimo
